# Container Patterns Reference

## Docker Best Practices

### Image Optimization

```dockerfile
# Use specific version tags, not :latest
FROM node:20.10-alpine3.18

# Combine RUN commands to reduce layers
RUN apk add --no-cache \
    git \
    curl \
    && rm -rf /var/cache/apk/*

# Use .dockerignore to exclude unnecessary files
# Copy dependency files first for better caching
COPY package*.json ./
RUN npm ci --only=production

# Copy source last (most frequently changing)
COPY . .
```

### Multi-Stage Builds

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER node
CMD ["node", "dist/index.js"]

# Stage 3: Development
FROM node:20-alpine AS development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
```

### Security Hardening

```dockerfile
# Run as non-root user
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser
USER appuser

# Use read-only filesystem where possible
# Set in docker-compose or K8s securityContext

# Scan images for vulnerabilities
# docker scout cves myimage:latest
# trivy image myimage:latest
```

## Docker Compose Patterns

### Development Environment

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      target: development
    volumes:
      - .:/app:cached
      - node_modules:/app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: ${DB_NAME:-myapp}
      POSTGRES_USER: ${DB_USER:-dev}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-devpass}
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-dev}"]
      interval: 5s
      timeout: 5s
      retries: 5

volumes:
  node_modules:
  postgres_data:
```

### Production-Like Setup

```yaml
version: '3.8'

services:
  app:
    image: myregistry/myapp:${VERSION:-latest}
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
      restart_policy:
        condition: on-failure
        max_attempts: 3
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"
```

## Container Orchestration

### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-service
  labels:
    app: api-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api-service
  template:
    metadata:
      labels:
        app: api-service
    spec:
      containers:
        - name: api
          image: myregistry/api:v1.0.0
          ports:
            - containerPort: 3000
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 500m
              memory: 256Mi
          livenessProbe:
            httpGet:
              path: /health/live
              port: 3000
            initialDelaySeconds: 10
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 3000
            initialDelaySeconds: 5
```

### Resource Management

| Resource Type | Request | Limit | Notes |
|---------------|---------|-------|-------|
| CPU | 100m | 500m | Start low, scale up |
| Memory | 128Mi | 256Mi | Based on profiling |
| Ephemeral Storage | 100Mi | 500Mi | For temp files |

### Pod Disruption Budget

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: api-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: api-service
```

## CI/CD Integration

### GitHub Actions Build

```yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v5
  with:
    context: .
    push: true
    tags: |
      myregistry/myapp:${{ github.sha }}
      myregistry/myapp:latest
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

### Image Tagging Strategy

```
myregistry/myapp:latest          # Latest build (avoid in prod)
myregistry/myapp:v1.2.3          # Semantic version
myregistry/myapp:abc123f         # Git commit SHA
myregistry/myapp:main-abc123f    # Branch + SHA
myregistry/myapp:pr-42           # Pull request builds
```

## Container Registry

### Registry Authentication

```bash
# Docker Hub
docker login -u username

# GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# AWS ECR
aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY

# Google Artifact Registry
gcloud auth configure-docker us-docker.pkg.dev
```

### Image Scanning

```bash
# Docker Scout (Docker Desktop)
docker scout cves myimage:latest

# Trivy
trivy image myimage:latest

# Snyk
snyk container test myimage:latest
```

## Debugging Containers

```bash
# View logs
docker logs -f container_name

# Execute shell in running container
docker exec -it container_name /bin/sh

# Inspect container
docker inspect container_name

# View resource usage
docker stats

# Copy files from container
docker cp container_name:/path/to/file ./local/path
```
