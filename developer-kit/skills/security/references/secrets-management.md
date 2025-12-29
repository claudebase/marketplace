# Secrets Management Reference

## Principles

1. **Never hardcode secrets** - No secrets in source code
2. **Encrypt at rest** - Secrets must be encrypted when stored
3. **Encrypt in transit** - Use TLS for all secret transmission
4. **Least privilege** - Minimal access to secrets
5. **Rotate regularly** - Automate secret rotation
6. **Audit access** - Log all secret access

## Environment Variables

### Local Development

```bash
# .env file (NEVER commit)
DATABASE_URL=postgres://user:password@localhost:5432/db
API_KEY=sk-12345
JWT_SECRET=your-jwt-secret
```

```javascript
// Load with dotenv
require('dotenv').config();

const dbUrl = process.env.DATABASE_URL;
const apiKey = process.env.API_KEY;
```

### .env.example Template

```bash
# .env.example (commit this)
# Copy to .env and fill in values

# Database
DATABASE_URL=postgres://user:password@host:5432/database

# Authentication
JWT_SECRET=generate-a-strong-secret
SESSION_SECRET=generate-another-secret

# External APIs
STRIPE_API_KEY=sk_test_xxx
SENDGRID_API_KEY=SG.xxx

# AWS (if using)
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=us-east-1
```

### .gitignore

```gitignore
# Secrets
.env
.env.local
.env.*.local
*.pem
*.key
credentials.json
secrets.json
```

## HashiCorp Vault

### CLI Usage

```bash
# Login
vault login -method=token

# Write a secret
vault kv put secret/myapp/database \
  username="dbuser" \
  password="dbpass"

# Read a secret
vault kv get secret/myapp/database

# Read specific field
vault kv get -field=password secret/myapp/database
```

### Node.js Integration

```javascript
const vault = require('node-vault')({
  apiVersion: 'v1',
  endpoint: process.env.VAULT_ADDR,
  token: process.env.VAULT_TOKEN
});

async function getSecret(path) {
  const { data } = await vault.read(path);
  return data.data;
}

// Usage
const dbCreds = await getSecret('secret/data/myapp/database');
const connectionString = `postgres://${dbCreds.username}:${dbCreds.password}@host/db`;
```

### Python Integration

```python
import hvac

client = hvac.Client(
    url=os.environ['VAULT_ADDR'],
    token=os.environ['VAULT_TOKEN']
)

# Read secret
secret = client.secrets.kv.v2.read_secret_version(
    path='myapp/database',
    mount_point='secret'
)

db_password = secret['data']['data']['password']
```

## AWS Secrets Manager

### CLI Usage

```bash
# Create secret
aws secretsmanager create-secret \
  --name myapp/database \
  --secret-string '{"username":"admin","password":"secret123"}'

# Retrieve secret
aws secretsmanager get-secret-value \
  --secret-id myapp/database

# Rotate secret
aws secretsmanager rotate-secret \
  --secret-id myapp/database
```

### Node.js Integration

```javascript
const { SecretsManager } = require('@aws-sdk/client-secrets-manager');

const client = new SecretsManager({ region: 'us-east-1' });

async function getSecret(secretName) {
  const response = await client.getSecretValue({ SecretId: secretName });
  return JSON.parse(response.SecretString);
}

// Usage
const dbCreds = await getSecret('myapp/database');
```

### Python Integration

```python
import boto3
import json

def get_secret(secret_name):
    client = boto3.client('secretsmanager', region_name='us-east-1')
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])

# Usage
db_creds = get_secret('myapp/database')
```

## Kubernetes Secrets

### Create Secret

```yaml
# secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: myapp-secrets
type: Opaque
stringData:
  DATABASE_URL: postgres://user:password@host:5432/db
  API_KEY: sk-12345
```

```bash
# Create from file
kubectl create secret generic myapp-secrets --from-env-file=.env

# Create from literal
kubectl create secret generic myapp-secrets \
  --from-literal=DATABASE_URL='postgres://...' \
  --from-literal=API_KEY='sk-...'
```

### Use in Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  containers:
    - name: app
      image: myapp:latest
      envFrom:
        - secretRef:
            name: myapp-secrets
      # Or individual values
      env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: myapp-secrets
              key: DATABASE_URL
```

### External Secrets Operator

```yaml
# ExternalSecret pulling from AWS Secrets Manager
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: myapp-secrets
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: SecretStore
  target:
    name: myapp-secrets
  data:
    - secretKey: DATABASE_URL
      remoteRef:
        key: myapp/database
        property: url
```

## Docker Secrets

### Docker Swarm

```bash
# Create secret
echo "my-secret-value" | docker secret create my_secret -

# Use in service
docker service create \
  --name myapp \
  --secret my_secret \
  myapp:latest
```

```yaml
# docker-compose.yml (Swarm mode)
version: '3.8'
services:
  app:
    image: myapp:latest
    secrets:
      - db_password
      - api_key
    environment:
      DB_PASSWORD_FILE: /run/secrets/db_password
      API_KEY_FILE: /run/secrets/api_key

secrets:
  db_password:
    external: true
  api_key:
    external: true
```

### Docker Compose (Local)

```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    image: myapp:latest
    secrets:
      - db_password
    environment:
      DB_PASSWORD_FILE: /run/secrets/db_password

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

## GitHub Actions Secrets

### Using Secrets

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        env:
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: ./deploy.sh
```

### Environment Secrets

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy
        env:
          # Uses production environment secrets
          API_KEY: ${{ secrets.API_KEY }}
        run: ./deploy.sh
```

## Secret Rotation

### Automated Rotation Pattern

```javascript
class SecretRotator {
  constructor(secretsManager, notifier) {
    this.secretsManager = secretsManager;
    this.notifier = notifier;
  }

  async rotateSecret(secretId) {
    // 1. Generate new secret value
    const newValue = this.generateSecretValue();

    // 2. Create new version (pending)
    await this.secretsManager.putSecretValue({
      SecretId: secretId,
      SecretString: newValue,
      VersionStage: 'AWSPENDING'
    });

    // 3. Test new credentials
    const isValid = await this.testCredentials(newValue);
    if (!isValid) {
      throw new Error('New credentials failed validation');
    }

    // 4. Promote to current
    await this.secretsManager.updateSecretVersionStage({
      SecretId: secretId,
      VersionStage: 'AWSCURRENT',
      MoveToVersionId: newVersionId
    });

    // 5. Notify dependent services
    await this.notifier.notify('secret-rotated', { secretId });
  }
}
```

## Security Checklist

| Item | Status |
|------|--------|
| No secrets in code | [ ] |
| .env in .gitignore | [ ] |
| Secrets encrypted at rest | [ ] |
| Secrets encrypted in transit | [ ] |
| Rotation policy defined | [ ] |
| Access audit logging | [ ] |
| Least privilege access | [ ] |
| Backup/recovery procedure | [ ] |
| Secret scanning in CI | [ ] |

## Secret Scanning

### Git pre-commit hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check for potential secrets
PATTERNS=(
  "password\s*=\s*['\"][^'\"]+['\"]"
  "api[_-]?key\s*=\s*['\"][^'\"]+['\"]"
  "secret\s*=\s*['\"][^'\"]+['\"]"
  "-----BEGIN.*PRIVATE KEY-----"
)

for pattern in "${PATTERNS[@]}"; do
  if git diff --cached | grep -iE "$pattern"; then
    echo "ERROR: Potential secret detected in staged changes"
    exit 1
  fi
done
```

### GitHub Secret Scanning

```yaml
# .github/workflows/security.yml
name: Security Scan
on: [push, pull_request]

jobs:
  secrets:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Scan for secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          extra_args: --only-verified
```
