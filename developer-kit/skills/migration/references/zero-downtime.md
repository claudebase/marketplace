# Zero-Downtime Deployment Reference

## Deployment Strategies

### Rolling Deployment

```yaml
# Kubernetes rolling update
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-service
spec:
  replicas: 4
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # One extra pod during update
      maxUnavailable: 0  # Never reduce below desired count
  template:
    spec:
      containers:
        - name: api
          image: api:v2.0.0
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
```

### Blue-Green Deployment

```yaml
# Blue environment (current production)
apiVersion: v1
kind: Service
metadata:
  name: api-production
spec:
  selector:
    app: api
    version: blue  # Points to blue deployment
  ports:
    - port: 80
      targetPort: 3000

---
# Switch to green after verification
# kubectl patch service api-production -p '{"spec":{"selector":{"version":"green"}}}'
```

### Canary Deployment

```yaml
# Istio canary configuration
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: api-service
spec:
  hosts:
    - api.example.com
  http:
    - match:
        - headers:
            x-canary:
              exact: "true"
      route:
        - destination:
            host: api-canary
    - route:
        - destination:
            host: api-stable
          weight: 95
        - destination:
            host: api-canary
          weight: 5
```

## Database Zero-Downtime

### Expand-Contract Example

```sql
-- Phase 1: EXPAND (deploy-safe)
-- Add new column, nullable
ALTER TABLE users ADD COLUMN email_verified BOOLEAN;

-- Phase 2: MIGRATE (background job)
-- Backfill data
UPDATE users SET email_verified = (verified_at IS NOT NULL)
WHERE email_verified IS NULL;

-- Phase 3: CONTRACT (after all code uses new column)
-- Add constraint
ALTER TABLE users ALTER COLUMN email_verified SET DEFAULT FALSE;
ALTER TABLE users ALTER COLUMN email_verified SET NOT NULL;

-- Drop old column (if applicable)
ALTER TABLE users DROP COLUMN verified_at;
```

### Online Schema Migration Tools

```bash
# gh-ost (GitHub's online schema migration for MySQL)
gh-ost \
  --host=db.example.com \
  --database=myapp \
  --table=users \
  --alter="ADD COLUMN phone VARCHAR(20)" \
  --execute

# pt-online-schema-change (Percona)
pt-online-schema-change \
  --alter "ADD COLUMN phone VARCHAR(20)" \
  D=myapp,t=users \
  --execute

# pg_repack (PostgreSQL - reclaims space, reorganizes)
pg_repack -d myapp -t users
```

## Feature Flags

### LaunchDarkly Integration

```javascript
const LaunchDarkly = require('launchdarkly-node-server-sdk');
const client = LaunchDarkly.init(process.env.LD_SDK_KEY);

app.get('/api/users/:id', async (req, res) => {
  const user = await getUser(req.params.id);

  // Check feature flag
  const useNewFormat = await client.variation(
    'new-user-response-format',
    { key: user.id, email: user.email },
    false  // default value
  );

  if (useNewFormat) {
    return res.json(formatUserV2(user));
  }

  res.json(formatUserV1(user));
});
```

### Simple Feature Flag Implementation

```javascript
class FeatureFlags {
  constructor() {
    this.flags = new Map();
  }

  async isEnabled(flagName, context = {}) {
    const flag = this.flags.get(flagName);
    if (!flag) return false;

    // Check rollout percentage
    if (flag.rolloutPercentage !== undefined) {
      const hash = this.hashContext(flagName, context);
      return (hash % 100) < flag.rolloutPercentage;
    }

    // Check user allowlist
    if (flag.allowedUsers?.includes(context.userId)) {
      return true;
    }

    return flag.enabled || false;
  }

  hashContext(flagName, context) {
    const str = `${flagName}:${context.userId || context.sessionId || ''}`;
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      hash = ((hash << 5) - hash) + str.charCodeAt(i);
      hash |= 0;
    }
    return Math.abs(hash);
  }
}

// Usage
const flags = new FeatureFlags();
flags.flags.set('new-checkout-flow', {
  enabled: true,
  rolloutPercentage: 10,  // 10% of users
  allowedUsers: ['internal-tester-1']
});
```

## Health Checks

### Kubernetes Probes

```javascript
// Liveness: Is the process healthy?
app.get('/health/live', (req, res) => {
  res.status(200).json({ status: 'alive' });
});

// Readiness: Can it serve traffic?
app.get('/health/ready', async (req, res) => {
  try {
    // Check database
    await db.query('SELECT 1');

    // Check required services
    await redis.ping();

    // Check if migrations complete
    const pendingMigrations = await getMigrationStatus();
    if (pendingMigrations > 0) {
      return res.status(503).json({
        status: 'not ready',
        reason: 'pending migrations'
      });
    }

    res.status(200).json({ status: 'ready' });
  } catch (error) {
    res.status(503).json({
      status: 'not ready',
      error: error.message
    });
  }
});

// Startup: Has it finished initializing?
app.get('/health/startup', (req, res) => {
  if (appInitialized) {
    res.status(200).json({ status: 'started' });
  } else {
    res.status(503).json({ status: 'starting' });
  }
});
```

## Rollback Procedures

### Automated Rollback

```yaml
# Kubernetes with Argo Rollouts
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: api-service
spec:
  strategy:
    canary:
      steps:
        - setWeight: 10
        - pause: { duration: 5m }
        - setWeight: 50
        - pause: { duration: 10m }
        - setWeight: 100
      analysis:
        templates:
          - templateName: success-rate
        startingStep: 1
        args:
          - name: service-name
            value: api-service

---
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: success-rate
spec:
  metrics:
    - name: success-rate
      interval: 1m
      successCondition: result >= 0.99
      provider:
        prometheus:
          query: |
            sum(rate(http_requests_total{status!~"5.*",service="{{args.service-name}}"}[5m]))
            /
            sum(rate(http_requests_total{service="{{args.service-name}}"}[5m]))
```

### Manual Rollback Script

```bash
#!/bin/bash
# rollback.sh

DEPLOYMENT=$1
REVISION=${2:-1}  # Default to previous revision

echo "Rolling back $DEPLOYMENT to revision $REVISION..."

# Kubernetes rollback
kubectl rollout undo deployment/$DEPLOYMENT --to-revision=$REVISION

# Wait for rollout
kubectl rollout status deployment/$DEPLOYMENT --timeout=5m

# Verify health
kubectl get pods -l app=$DEPLOYMENT

echo "Rollback complete. Verify application health."
```
