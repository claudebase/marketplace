---
name: containers
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. Activates for: 'create Dockerfile', 'docker compose', 'containerize app', 'Kubernetes manifest', 'k8s deployment', 'Helm chart', 'pod configuration', 'container setup'."
allowed-tools:
  # Core Implementation
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  # Documentation Lookup
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Architecture Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Containers Skill

Create optimized Dockerfiles, development-friendly compose configurations, production-ready Kubernetes manifests, and GitOps workflows with official documentation and community best practices.

**Core Principle**: "Build once, run anywhere. Optimize for security, size, and speed."

**Key Enhancement**: Research container patterns, orchestration best practices, and GitOps workflows before implementing configurations.

**Key Distinction**: This skill CREATES container configurations. For CI/CD pipelines, use the `devops` skill. For container security audits, use the `security` skill.

## Activation Triggers

- Dockerfile creation ("create Dockerfile", "containerize app")
- Docker Compose ("docker-compose", "multi-container setup")
- Kubernetes ("k8s deployment", "Kubernetes manifest", "pod config")
- Helm ("create Helm chart", "Helm template")
- Kustomize ("kustomize overlays", "kustomization")
- GitOps ("ArgoCD application", "FluxCD", "GitOps deployment")
- Optimization ("optimize Docker image", "reduce image size")
- Development ("local dev with Docker", "dev containers")

## Do NOT Activate When

- Cloud infrastructure provisioning → use `devops` skill
- CI/CD pipeline configuration → use `devops` skill
- Application code changes unrelated to containers
- Monitoring/observability setup → use `observability` skill
- Container security scanning → use `security` skill

**Boundary Clarification:**
This skill creates container configurations and orchestration manifests. For CI/CD pipelines that build/push images, use the `devops` skill. For security audits of container configurations, use the `security` skill.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    DESIGN    │  IMPLEMENT   │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Choose base  │ Create       │ Build and    │
│ runtime      │ official     │ images       │ Dockerfile   │ test locally │
│ requirements │ docs         │              │              │              │
│              │              │              │              │              │
│ Check build  │ Find         │ Plan multi-  │ Write        │ Verify       │
│ dependencies │ patterns     │ stage builds │ compose/K8s  │ image size   │
│              │              │              │              │              │
│ Assess       │ Research     │ Design       │ Configure    │ Test         │
│ resources    │ best         │ networking   │ resources    │ networking   │
│              │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Bash
     Grep           GitHub        Thinking        Edit           (docker build)
                    Tavily
```

### Phase 1: ANALYZE

Understand application requirements before containerizing:

1. **Read existing code** - Identify language, framework, dependencies
2. **Check package files** - `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`
3. **Identify runtime needs** - Ports, environment variables, volumes
4. **Assess resource requirements** - Memory, CPU, storage needs

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup Docker official documentation
mcp__context7__resolve-library-id → "/docker/docs" or "/websites/docs_docker_com"
mcp__context7__query-docs("multi-stage build best practices")

# Lookup Kubernetes documentation
mcp__context7__resolve-library-id → "/kubernetes/website"
mcp__context7__query-docs("deployment resource limits")

# Lookup Helm chart patterns
mcp__context7__resolve-library-id → "/websites/helm_sh"
mcp__context7__query-docs("Helm chart template values best practices")

# Lookup Kustomize overlays
mcp__context7__resolve-library-id → "/kubernetes-sigs/kustomize"
mcp__context7__query-docs("Kustomize overlays patches components")

# Lookup ArgoCD GitOps
mcp__context7__resolve-library-id → "/argoproj/argo-cd"
mcp__context7__query-docs("ArgoCD application sync deployment")

# Find real-world Dockerfile patterns
mcp__github__search_code("FROM node alpine multi-stage production")

# Research current best practices
mcp__tavily__tavily-search("Docker image optimization 2024 best practices")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Plan container architecture with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Choose appropriate base image (size vs features)
- Plan multi-stage build strategy
- Design volume/persistence approach
- Plan networking (ports, service discovery)
- Consider resource limits and requests
- Plan GitOps deployment strategy
```

**Design Decisions:**

- **Base Image**: Alpine vs Slim vs Distroless vs Full
- **Build Strategy**: Single-stage vs Multi-stage
- **User**: Root vs Non-root (prefer non-root)
- **Filesystem**: Read-write vs Read-only
- **Orchestration**: Helm vs Kustomize vs Plain YAML

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Create container configurations:

1. **Dockerfile** - Optimized, multi-stage, secure
2. **docker-compose.yml** - Development environment
3. **Kubernetes manifests** - Deployment, Service, ConfigMap
4. **Helm chart** - If templating needed
5. **Kustomize** - If overlay customization needed
6. **ArgoCD Application** - If GitOps deployment needed

**Tools**: Write, Edit

### Phase 5: VALIDATE

Test and verify container builds:

```bash
# Build and verify
docker build -t myapp:test .
docker images myapp:test  # Check size

# Test locally
docker run --rm -p 3000:3000 myapp:test

# Kubernetes dry-run
kubectl apply --dry-run=client -f k8s/

# Helm template validation
helm template ./chart

# Kustomize build
kustomize build overlays/production
```

**Tools**: Bash

## MCP Integration

### Context7 (Official Documentation)

**Primary source for container and orchestration best practices:**

```
mcp__context7__resolve-library-id - Resolve Docker/K8s/Helm library IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource        | Library ID                                   | Snippets | Use Case                          |
| --------------- | -------------------------------------------- | -------- | --------------------------------- |
| Docker Docs     | `/websites/docs_docker_com`                  | 15,954   | Dockerfile, compose, networking   |
| Docker GitHub   | `/docker/docs`                               | 11,763   | Docker Engine, CLI reference      |
| Docker Manuals  | `/websites/docs_docker_com-manuals`          | 32,987   | Build, compose, desktop guides    |
| Kubernetes Docs | `/kubernetes/website`                        | 27,521   | K8s concepts, API, best practices |
| Kubernetes API  | `/websites/kubernetes_io`                    | 10,654   | API reference, resources          |
| Helm            | `/websites/helm_sh`                          | 1,883    | Chart development, templating     |
| Helm GitHub     | `/helm/helm`                                 | 188      | Helm CLI, commands                |
| Kustomize       | `/kubernetes-sigs/kustomize`                 | 1,397    | Overlays, patches, components     |
| ArgoCD          | `/argoproj/argo-cd`                          | 2,510    | GitOps, sync, applications        |
| ArgoCD Docs     | `/websites/argo-cd_readthedocs_io_en_stable` | 2,065    | ArgoCD user guide                 |
| Podman          | `/containers/podman`                         | 3,021    | Rootless containers, pods         |
| Podman Docs     | `/websites/podman_io_en`                     | 3,232    | Podman CLI, compatibility         |
| Buildah         | `/containers/buildah`                        | 971      | OCI image building                |
| Istio           | `/websites/istio_io`                         | 5,416    | Service mesh, traffic management  |
| Istio GitHub    | `/istio/istio.io`                            | 12,499   | Istio documentation               |
| Skaffold        | `/googlecontainertools/skaffold`             | 2,301    | K8s development workflow          |
| Terraform       | `/websites/developer_hashicorp_terraform`    | 215,150  | Infrastructure as code            |

**Query patterns:**

```
# Docker multi-stage builds
mcp__context7__resolve-library-id → "/docker/docs"
mcp__context7__query-docs("multi-stage build best practices layer optimization")

# Kubernetes deployments
mcp__context7__resolve-library-id → "/kubernetes/website"
mcp__context7__query-docs("deployment resource limits requests probes")

# Helm chart templating
mcp__context7__resolve-library-id → "/websites/helm_sh"
mcp__context7__query-docs("Helm values template functions best practices")

# Kustomize overlays
mcp__context7__resolve-library-id → "/kubernetes-sigs/kustomize"
mcp__context7__query-docs("Kustomize components overlays patches")

# ArgoCD GitOps
mcp__context7__resolve-library-id → "/argoproj/argo-cd"
mcp__context7__query-docs("ArgoCD application sync policy automated")

# Service mesh
mcp__context7__resolve-library-id → "/websites/istio_io"
mcp__context7__query-docs("Istio traffic management virtual service")
```

### GitHub MCP (Pattern Research)

**Find real-world container configurations:**

```
mcp__github__search_code - Find Dockerfile/K8s patterns in repos
mcp__github__get_file_contents - Get specific configuration files
```

**Search patterns:**

```
# Find Node.js production Dockerfiles
"FROM node alpine" "multi-stage" filename:Dockerfile stars:>500

# Find Python Dockerfiles with poetry
"FROM python" "poetry" "multi-stage" filename:Dockerfile

# Find Kubernetes HPA configurations
kind:HorizontalPodAutoscaler filename:.yaml stars:>100

# Find Helm chart patterns
kind:Deployment filename:deployment.yaml path:templates stars:>100

# Find Kustomize base configurations
apiVersion:kustomize.config.k8s.io filename:kustomization.yaml

# Find ArgoCD application examples
kind:Application apiVersion:argoproj.io filename:.yaml

# Find Istio VirtualService patterns
kind:VirtualService apiVersion:networking.istio.io filename:.yaml
```

**Use cases:**

- Find how popular projects structure Dockerfiles
- Research K8s deployment patterns
- Get Helm chart examples
- Study Kustomize overlay patterns
- Find ArgoCD application configurations

### Tavily (Best Practices Research)

**Research current container best practices:**

```
mcp__tavily__tavily-search - Research optimization techniques
mcp__tavily__tavily-extract - Extract from articles/docs
```

**Use cases:**

- "Docker image size optimization techniques 2024"
- "Kubernetes resource limits best practices"
- "Container security hardening patterns"
- "Distroless vs Alpine comparison production"
- "Helm vs Kustomize comparison when to use"
- "ArgoCD GitOps best practices 2024"
- "Kubernetes namespace isolation patterns"
- "Container orchestration security best practices"

### Sequential Thinking (Architecture Planning)

**Plan complex container architectures:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step design reasoning
```

**Use for:**

- Multi-service compose architecture
- Kubernetes namespace/RBAC design
- Complex networking requirements
- Resource allocation planning
- GitOps workflow design
- Service mesh configuration

## Dockerfile Best Practices

### Multi-Stage Build Pattern

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production=false
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy only production dependencies and build artifacts
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

USER nextjs
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### Python Multi-Stage Build

```dockerfile
# Build stage
FROM python:3.12-slim AS builder
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install poetry
RUN pip install poetry
COPY pyproject.toml poetry.lock ./
RUN poetry export -f requirements.txt > requirements.txt
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt

# Production stage
FROM python:3.12-slim AS runner
WORKDIR /app

# Create non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy wheels and install
COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/*

COPY --chown=appuser:appuser . .
USER appuser

EXPOSE 8000
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app"]
```

### Go Distroless Build

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/server

# Production stage - Distroless
FROM gcr.io/distroless/static-debian12
COPY --from=builder /app/server /server
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/server"]
```

### Layer Optimization

```dockerfile
# Bad: Invalidates cache on any file change
COPY . .
RUN npm install

# Good: Separate dependency installation from code
COPY package*.json ./
RUN npm ci
COPY . .
```

### Security Hardening

```dockerfile
# Use non-root user
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser
USER appuser

# Remove build dependencies
RUN apk add --no-cache --virtual .build-deps gcc && \
    npm install && \
    apk del .build-deps

# Read-only filesystem support
ENV NODE_ENV=production
```

## Image Size Comparison

| Base Image       | Size   | Use Case              |
| ---------------- | ------ | --------------------- |
| ubuntu:22.04     | ~77MB  | Full OS, debugging    |
| node:20          | ~1GB   | Development           |
| node:20-slim     | ~200MB | Smaller, Debian-based |
| node:20-alpine   | ~130MB | Minimal, production   |
| python:3.12      | ~1GB   | Development           |
| python:3.12-slim | ~150MB | Production            |
| golang:1.22      | ~800MB | Development           |
| distroless       | ~20MB  | Minimal, no shell     |
| scratch          | ~0MB   | Static binaries only  |

## Docker Compose Patterns

### Development Environment

```yaml
version: "3.8"

services:
  app:
    build:
      context: .
      target: development
    volumes:
      - .:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgres://dev:devpass@db:5432/myapp
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started

  db:
    image: postgres:16-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: devpass
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U dev -d myapp"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

### Production Compose

```yaml
version: "3.8"

services:
  app:
    image: myapp:${VERSION:-latest}
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: "0.5"
          memory: 512M
        reservations:
          cpus: "0.25"
          memory: 256M
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## Kubernetes Patterns

### Deployment with Best Practices

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-service
  labels:
    app: api-service
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api-service
  template:
    metadata:
      labels:
        app: api-service
        version: v1
    spec:
      serviceAccountName: api-service
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
      containers:
        - name: api
          image: myapp:v1.0.0
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 3000
              protocol: TCP
          resources:
            requests:
              memory: "128Mi"
              cpu: "100m"
            limits:
              memory: "256Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /health/live
              port: 3000
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL
          env:
            - name: NODE_ENV
              value: "production"
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: api-secrets
                  key: database-url
          volumeMounts:
            - name: tmp
              mountPath: /tmp
      volumes:
        - name: tmp
          emptyDir: {}
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchLabels:
                    app: api-service
                topologyKey: kubernetes.io/hostname
```

### Horizontal Pod Autoscaler

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-service-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-service
  minReplicas: 3
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
```

### Service and Ingress

```yaml
apiVersion: v1
kind: Service
metadata:
  name: api-service
spec:
  selector:
    app: api-service
  ports:
    - port: 80
      targetPort: 3000
      protocol: TCP
  type: ClusterIP
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  tls:
    - hosts:
        - api.example.com
      secretName: api-tls
  rules:
    - host: api.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
```

## Helm Chart Patterns

### Chart Structure

```
mychart/
├── Chart.yaml
├── values.yaml
├── values-staging.yaml
├── values-production.yaml
├── templates/
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── configmap.yaml
│   ├── secret.yaml
│   └── serviceaccount.yaml
└── charts/
```

### values.yaml Best Practices

```yaml
# values.yaml - Flat structure preferred for --set compatibility
replicaCount: 3

image:
  repository: myapp
  tag: latest
  pullPolicy: IfNotPresent

# serverName is the host name for the service
serverName: api.example.com
# serverPort is the HTTP port for the service
serverPort: 3000

resources:
  limits:
    cpu: 500m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: api.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: api-tls
      hosts:
        - api.example.com
```

### Deployment Template

```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
    {{- include "mychart.labels" . | nindent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "mychart.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "mychart.selectorLabels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.serverPort }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
```

## Kustomize Patterns

### Base Configuration

```yaml
# base/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - deployment.yaml
  - service.yaml
  - configmap.yaml

commonLabels:
  app: myapp
```

### Production Overlay

```yaml
# overlays/production/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

namespace: production

commonLabels:
  environment: production

replicas:
  - name: myapp
    count: 5

images:
  - name: myapp
    newTag: v1.2.3

patches:
  - path: increase-resources.yaml

configMapGenerator:
  - name: myapp-config
    behavior: merge
    literals:
      - LOG_LEVEL=info
```

### Kustomize Components

```yaml
# components/monitoring/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1alpha1
kind: Component

resources:
  - servicemonitor.yaml

labels:
  - pairs:
      monitoring: enabled

patches:
  - patch: |-
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: not-important
      spec:
        template:
          metadata:
            annotations:
              prometheus.io/scrape: "true"
              prometheus.io/port: "8080"
    target:
      kind: Deployment
```

## GitOps with ArgoCD

### ArgoCD Application

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/myorg/myapp.git
    targetRevision: HEAD
    path: k8s/overlays/production
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
```

### ArgoCD ApplicationSet

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: myapp-environments
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - env: staging
            cluster: staging-cluster
          - env: production
            cluster: production-cluster
  template:
    metadata:
      name: "myapp-{{env}}"
    spec:
      project: default
      source:
        repoURL: https://github.com/myorg/myapp.git
        targetRevision: HEAD
        path: "k8s/overlays/{{env}}"
      destination:
        server: "{{cluster}}"
        namespace: "{{env}}"
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
```

## Output Format

```markdown
## Container Configuration Report

### Configuration Summary

| Aspect          | Details                       |
| --------------- | ----------------------------- |
| Type            | [Dockerfile/Compose/K8s/Helm] |
| Base Image      | [node:20-alpine]              |
| Build Strategy  | [Multi-stage]                 |
| Target Platform | [Development/Production]      |

### Research Applied

- Docker patterns: [Multi-stage build from Context7]
- K8s best practices: [Resource limits, probes]
- Security: [Non-root user, read-only filesystem]

### Files Created

| File                | Purpose                    |
| ------------------- | -------------------------- |
| Dockerfile          | Production container build |
| docker-compose.yml  | Development environment    |
| k8s/deployment.yaml | Kubernetes deployment      |
| k8s/service.yaml    | Service configuration      |

### Image Optimization

| Metric        | Before | After    | Improvement |
| ------------- | ------ | -------- | ----------- |
| Image Size    | 1.2GB  | 150MB    | 87%         |
| Build Layers  | 12     | 6        | 50%         |
| Security User | root   | non-root | Hardened    |

### Validation Results

\`\`\`bash
docker build -t myapp:test . # Success
docker images myapp:test # 150MB
kubectl apply --dry-run=client -f k8s/ # Valid
\`\`\`

### Next Steps

- [ ] Push image to container registry
- [ ] Deploy to staging environment
- [ ] Configure CI/CD pipeline
```

## Reference Files

For detailed patterns and examples, see:

- `references/dockerfile-patterns.md` - Optimized Dockerfile examples
- `references/compose-patterns.md` - Docker Compose configurations
- `references/kubernetes-patterns.md` - K8s deployment patterns
- `references/helm-patterns.md` - Helm chart development
- `references/kustomize-patterns.md` - Kustomize overlay patterns
- `references/gitops-patterns.md` - ArgoCD and FluxCD patterns

## Handoffs

| Scenario                      | Hand off to           |
| ----------------------------- | --------------------- |
| Need CI/CD pipeline           | `devops` skill        |
| Need container security audit | `security` skill      |
| Need monitoring/logging       | `observability` skill |
| Need database optimization    | `database` skill      |
| Need cloud infrastructure     | `devops` skill        |

## Boundaries

**Will:**

- Create optimized Dockerfiles with multi-stage builds
- Write docker-compose configurations for development
- Generate Kubernetes manifests (Deployment, Service, ConfigMap, HPA)
- Create Helm charts with proper templating
- Configure Kustomize bases and overlays
- Set up ArgoCD applications for GitOps
- Configure container resources, limits, and probes
- Implement security best practices (non-root, read-only fs)
- Research patterns via Context7, GitHub, and Tavily

**Will Not:**

- Provision cloud infrastructure (use `devops`)
- Configure CI/CD pipelines (only container build steps)
- Set up container orchestration platforms
- Manage production deployments without review
- Configure cloud-specific container services (ECS, Cloud Run)
- Perform container security scanning (use `security`)
