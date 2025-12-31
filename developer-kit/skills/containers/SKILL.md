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

Create optimized Dockerfiles, development-friendly compose configurations, and production-ready Kubernetes manifests with official documentation and community best practices.

## Activation Triggers

- Dockerfile creation ("create Dockerfile", "containerize app")
- Docker Compose ("docker-compose", "multi-container setup")
- Kubernetes ("k8s deployment", "Kubernetes manifest", "pod config")
- Helm ("create Helm chart", "Helm template")
- Optimization ("optimize Docker image", "reduce image size")
- Development ("local dev with Docker", "dev containers")

## Do NOT Activate When

- Cloud infrastructure provisioning → use `devops` skill
- CI/CD pipeline configuration → use `devops` skill
- Application code changes unrelated to containers
- Monitoring/observability setup → use `observability` skill
- Container security scanning → use `security` skill

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
- Consider resource limits
```

**Design Decisions:**

- **Base Image**: Alpine vs Slim vs Distroless vs Full
- **Build Strategy**: Single-stage vs Multi-stage
- **User**: Root vs Non-root (prefer non-root)
- **Filesystem**: Read-write vs Read-only

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Create container configurations:

1. **Dockerfile** - Optimized, multi-stage, secure
2. **docker-compose.yml** - Development environment
3. **Kubernetes manifests** - Deployment, Service, ConfigMap
4. **Helm chart** - If templating needed

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
```

**Tools**: Bash

## MCP Integration

### Context7 (Official Documentation)

**Primary source for Docker and Kubernetes best practices:**

```
mcp__context7__resolve-library-id - Resolve Docker/K8s library IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource        | Library ID                  | Snippets |
| --------------- | --------------------------- | -------- |
| Docker Docs     | `/websites/docs_docker_com` | 15,954   |
| Docker GitHub   | `/docker/docs`              | 11,763   |
| Kubernetes Docs | `/kubernetes/website`       | 27,521   |
| Kubernetes API  | `/websites/kubernetes_io`   | 10,654   |

**Use cases:**

- "How to write multi-stage Dockerfile"
- "Kubernetes deployment best practices"
- "Docker healthcheck configuration"
- "K8s resource limits and requests"

### GitHub MCP (Pattern Research)

**Find real-world container configurations:**

```
mcp__github__search_code - Find Dockerfile/K8s patterns in repos
mcp__github__get_file_contents - Get specific configuration files
```

**Search patterns:**

```
# Find Node.js production Dockerfiles
"FROM node alpine" "multi-stage" filename:Dockerfile

# Find Kubernetes HPA configurations
kind:HorizontalPodAutoscaler filename:.yaml

# Find Helm chart patterns
kind:Deployment filename:deployment.yaml path:templates
```

**Use cases:**

- Find how popular projects structure Dockerfiles
- Research K8s deployment patterns
- Get Helm chart examples

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
- "Distroless vs Alpine comparison"

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

## Dockerfile Best Practices

### Multi-Stage Build Pattern

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

# Remove build dependencies
RUN apk add --no-cache --virtual .build-deps gcc && \
    npm install && \
    apk del .build-deps
```

## Image Size Comparison

| Base Image     | Size   | Use Case              |
| -------------- | ------ | --------------------- |
| ubuntu:22.04   | ~77MB  | Full OS, debugging    |
| node:20        | ~1GB   | Development           |
| node:20-slim   | ~200MB | Smaller, Debian-based |
| node:20-alpine | ~130MB | Minimal, production   |
| distroless     | ~20MB  | Minimal, no shell     |

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
    spec:
      containers:
        - name: api
          image: myapp:v1.0.0
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

## Reference Files

For detailed patterns and examples, see:

- `references/dockerfile-patterns.md` - Optimized Dockerfile examples
- `references/compose-patterns.md` - Docker Compose configurations
- `references/kubernetes-patterns.md` - K8s deployment patterns
- `references/helm-patterns.md` - Helm chart development

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
- Generate Kubernetes manifests (Deployment, Service, ConfigMap)
- Create Helm charts with proper templating
- Configure container resources and limits
- Set up container networking
- Implement security best practices (non-root, read-only fs)

**Will Not:**

- Provision cloud infrastructure (use `devops`)
- Configure CI/CD pipelines (only container build steps)
- Set up container orchestration platforms
- Manage production deployments without review
- Configure cloud-specific container services (ECS, Cloud Run)
- Perform container security scanning (use `security`)
