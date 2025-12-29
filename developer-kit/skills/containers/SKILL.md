---
name: containers
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. Activates for: 'create Dockerfile', 'docker compose', 'containerize app', 'Kubernetes manifest', 'k8s deployment', 'Helm chart', 'pod configuration', 'container setup'."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  - mcp__sequential-thinking__sequentialthinking
---

# Containers Skill

## Purpose

Enable containerization of applications with optimized Dockerfiles, development-friendly compose configurations, and production-ready Kubernetes manifests.

## Activation Triggers

Activate when the user mentions:
- "Create a Dockerfile"
- "Containerize this application"
- "Set up docker-compose"
- "Deploy to Kubernetes"
- "Create a Helm chart"
- "Optimize Docker image size"
- "Set up local development with Docker"
- "Create Kubernetes deployment"
- "Configure container resources"
- "Set up container networking"

## Do NOT Activate When

- Cloud infrastructure provisioning (use `devops`)
- CI/CD pipeline configuration (use `devops`)
- Application code changes not related to containers
- Monitoring setup (use `observability`)

## Behavioral Flow

### 1. Analyze Application
- Identify runtime requirements
- Determine build dependencies
- Check for secrets/configuration needs
- Assess resource requirements

### 2. Design Container Strategy
- Choose appropriate base image
- Plan multi-stage build if applicable
- Design volume/persistence strategy
- Plan networking requirements

### 3. Implement
- Create optimized Dockerfile
- Write compose configuration
- Generate Kubernetes manifests
- Configure secrets management

### 4. Optimize
- Minimize image size
- Layer caching optimization
- Security hardening
- Resource limits

### 5. Validate
- Build and test locally
- Security scanning
- Resource verification
- Documentation

## Dockerfile Best Practices

### Multi-Stage Build

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Production stage
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
EXPOSE 3000
CMD ["node", "server.js"]
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

# Remove unnecessary packages
RUN apk add --no-cache --virtual .build-deps gcc && \
    npm install && \
    apk del .build-deps

# Set read-only root filesystem
# (configure in Kubernetes securityContext)
```

## Image Size Comparison

| Base Image | Size | Use Case |
|------------|------|----------|
| ubuntu:22.04 | ~77MB | Full OS, debugging |
| node:20 | ~1GB | Development |
| node:20-slim | ~200MB | Smaller, Debian-based |
| node:20-alpine | ~130MB | Minimal, production |
| distroless | ~20MB | Minimal, no shell |

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
      - .:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: devpass

  redis:
    image: redis:7-alpine

volumes:
  postgres_data:
```

## Kubernetes Essentials

### Deployment with Best Practices

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-service
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
          image: myapp:v1.0.0
          ports:
            - containerPort: 3000
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
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 3000
          securityContext:
            runAsNonRoot: true
            readOnlyRootFilesystem: true
```

## MCP Integration

- **sequential-thinking**: Design complex container architectures

## References

- [dockerfile-patterns.md](references/dockerfile-patterns.md) - Optimized Dockerfile examples
- [compose-patterns.md](references/compose-patterns.md) - Docker Compose configurations
- [kubernetes-patterns.md](references/kubernetes-patterns.md) - K8s deployment patterns
- [helm-patterns.md](references/helm-patterns.md) - Helm chart development

## Boundaries

### Will Do
- Create optimized Dockerfiles
- Write docker-compose configurations
- Generate Kubernetes manifests
- Create Helm charts
- Configure container resources and limits
- Set up container networking
- Implement security best practices

### Will NOT Do
- Provision cloud infrastructure
- Configure CI/CD pipelines (only container build steps)
- Set up container orchestration platforms
- Manage production deployments without review
- Configure cloud-specific container services (ECS, Cloud Run)
