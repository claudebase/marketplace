---
name: containers
description: "Docker and Kubernetes configurations. Activates for: Docker, Dockerfile, container, Kubernetes, k8s, Helm, pod, deployment."
composable: true
mode: read-write
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

Create optimized Dockerfiles, compose configurations, and Kubernetes manifests.

## Quick Reference

**Activates for**: Docker, Dockerfile, container, Kubernetes, k8s, Helm, pod, deployment
**Mode**: read-write
**Output**: Production-ready container configurations

## Workflow

```
ANALYZE → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
```

## When to Use

- Dockerfile creation ("create Dockerfile", "containerize app")
- Docker Compose ("docker-compose", "multi-container setup")
- Kubernetes ("k8s deployment", "Kubernetes manifest")
- Helm/Kustomize ("create Helm chart", "kustomize overlays")

## When NOT to Use

- CI/CD pipelines → use `devops` skill
- Container security scanning → use `security` skill
- Monitoring setup → use `observability` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Dockerfile Patterns](references/dockerfile-patterns.md) - Multi-stage builds
- [Compose Patterns](references/compose-patterns.md) - Development and production
- [Kubernetes Patterns](references/kubernetes-patterns.md) - Deployments, HPA, Ingress

## Boundaries

**Will**: Create Dockerfiles, compose files, K8s manifests, Helm charts
**Will Not**: Provision cloud infrastructure, configure CI/CD, perform security scans
