# Containers Skill - Detailed Guide

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

## Phase 1: ANALYZE

Understand application requirements before containerizing:

1. **Read existing code** - Identify language, framework, dependencies
2. **Check package files** - `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`
3. **Identify runtime needs** - Ports, environment variables, volumes
4. **Assess resource requirements** - Memory, CPU, storage needs

**Tools**: Read, Grep, Glob

## Phase 2: RESEARCH

Gather official documentation and community patterns:

```yaml
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

## Phase 3: DESIGN

Plan container architecture with structured reasoning:

```yaml
mcp__sequential-thinking__sequentialthinking
- Choose appropriate base image (size vs features)
- Plan multi-stage build strategy
- Design volume/persistence approach
- Plan networking (ports, service discovery)
- Consider resource limits and requests
- Plan GitOps deployment strategy
```

**Design Decisions:**

| Decision       | Options                              |
| -------------- | ------------------------------------ |
| Base Image     | Alpine vs Slim vs Distroless vs Full |
| Build Strategy | Single-stage vs Multi-stage          |
| User           | Root vs Non-root (prefer non-root)   |
| Filesystem     | Read-write vs Read-only              |
| Orchestration  | Helm vs Kustomize vs Plain YAML      |

**Tools**: Sequential Thinking

## Phase 4: IMPLEMENT

Create container configurations:

1. **Dockerfile** - Optimized, multi-stage, secure
2. **docker-compose.yml** - Development environment
3. **Kubernetes manifests** - Deployment, Service, ConfigMap
4. **Helm chart** - If templating needed
5. **Kustomize** - If overlay customization needed
6. **ArgoCD Application** - If GitOps deployment needed

**Tools**: Write, Edit

## Phase 5: VALIDATE

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

## MCP Resources

For library IDs and query patterns, see:

- [MCP Resources](../../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../../lib/shared-references/tool-integration-patterns.md)

### Container Resources

| Resource    | Library ID                   | Use Case            |
| ----------- | ---------------------------- | ------------------- |
| Docker Docs | `/websites/docs_docker_com`  | Dockerfile, compose |
| Kubernetes  | `/kubernetes/website`        | K8s concepts, API   |
| Helm        | `/websites/helm_sh`          | Chart development   |
| Kustomize   | `/kubernetes-sigs/kustomize` | Overlays, patches   |
| ArgoCD      | `/argoproj/argo-cd`          | GitOps, sync        |

### GitHub Search Patterns

```yaml
# Node.js production Dockerfiles
"FROM node alpine" "multi-stage" filename:Dockerfile stars:>500

# Python Dockerfiles with poetry
"FROM python" "poetry" "multi-stage" filename:Dockerfile

# Kubernetes HPA configurations
kind:HorizontalPodAutoscaler filename:.yaml stars:>100

# Helm chart patterns
kind:Deployment filename:deployment.yaml path:templates stars:>100

# ArgoCD application examples
kind:Application apiVersion:argoproj.io filename:.yaml
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

### Files Created

| File                | Purpose                    |
| ------------------- | -------------------------- |
| Dockerfile          | Production container build |
| docker-compose.yml  | Development environment    |
| k8s/deployment.yaml | Kubernetes deployment      |

### Validation Results

docker build -t myapp:test . # Success
docker images myapp:test # 150MB
```

## Handoffs

| Scenario                      | Hand off to           |
| ----------------------------- | --------------------- |
| Need CI/CD pipeline           | `devops` skill        |
| Need container security audit | `security` skill      |
| Need monitoring/logging       | `observability` skill |
| Need cloud infrastructure     | `devops` skill        |
