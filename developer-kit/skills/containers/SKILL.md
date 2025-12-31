---
name: containers
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. This skill should be used when the user asks to 'create Dockerfile', 'docker compose', 'containerize app', or 'Kubernetes manifest'. Also use when user mentions k8s deployment, Helm chart, pod configuration, or container orchestration."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Containers Skill

Create optimized Dockerfiles, development-friendly compose configurations, and production-ready Kubernetes manifests with best practices.

**Core Principle**: "Build once, run anywhere. Optimize for security, size, and speed."

## When to Use

- Dockerfile creation ("create Dockerfile", "containerize app")
- Docker Compose ("docker-compose", "multi-container setup")
- Kubernetes ("k8s deployment", "Kubernetes manifest")
- Helm/Kustomize ("create Helm chart", "kustomize overlays")

## When NOT to Use

- CI/CD pipelines → use `devops` skill
- Container security scanning → use `security` skill
- Cloud infrastructure → use `devops` skill
- Monitoring setup → use `observability` skill

## Quick Workflow

```
ANALYZE → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
  Read     Context7   Sequential   Write      Bash
  Grep     GitHub     Thinking     Edit       (docker build)
           Tavily
```

1. **Analyze** - Read code, check dependencies, identify runtime needs
2. **Research** - Query Context7 for Docker/K8s docs, search GitHub patterns
3. **Design** - Plan base images, multi-stage builds, resources
4. **Implement** - Write Dockerfile, compose, K8s manifests
5. **Validate** - Build image, test locally, verify size

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID                   | Use Case              |
| ---------- | ---------------------------- | --------------------- |
| Docker     | `/websites/docs_docker_com`  | Dockerfile, compose   |
| Kubernetes | `/kubernetes/website`        | Deployments, services |
| Helm       | `/websites/helm_sh`          | Chart templating      |
| Kustomize  | `/kubernetes-sigs/kustomize` | Overlays              |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Dockerfile Patterns](references/dockerfile-patterns.md) - Multi-stage builds, optimization
- [Compose Patterns](references/compose-patterns.md) - Development and production
- [Kubernetes Patterns](references/kubernetes-patterns.md) - Deployments, HPA, Ingress
- [Helm Patterns](references/helm-patterns.md) - Chart structure and templating

## Boundaries

**Will**: Create Dockerfiles, compose files, K8s manifests, Helm charts, configure resources/probes

**Will Not**: Provision cloud infrastructure, configure CI/CD pipelines, perform security scans
