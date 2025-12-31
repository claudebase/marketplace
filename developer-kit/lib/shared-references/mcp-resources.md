# MCP Resource Library Reference

Consolidated Context7 library IDs and MCP tool resources for all agents and skills.

## How to Use

```yaml
# Step 1: Resolve library ID
mcp__context7__resolve-library-id("library-name")
# Returns: /org/repo or /websites/domain

# Step 2: Query documentation
mcp__context7__query-docs(libraryId, "specific query topic")
```

---

## Python Ecosystem

### Core Python

| Resource      | Library ID                         | Snippets | Use Case               |
| ------------- | ---------------------------------- | -------- | ---------------------- |
| Python 3.14   | `/websites/devdocs_io_python_3_14` | 21,524   | Core language, stdlib  |
| asyncio       | `/websites/devdocs_io_python_3_14` | -        | Async programming      |
| typing        | `/websites/devdocs_io_python_3_14` | -        | Type hints             |
| dataclasses   | `/websites/devdocs_io_python_3_14` | -        | Data classes           |
| collections   | `/websites/devdocs_io_python_3_14` | -        | Specialized containers |
| functools     | `/websites/devdocs_io_python_3_14` | -        | Higher-order functions |
| pathlib       | `/websites/devdocs_io_python_3_14` | -        | Path operations        |
| contextlib    | `/websites/devdocs_io_python_3_14` | -        | Context managers       |
| unittest.mock | `/websites/devdocs_io_python_3_14` | -        | Test mocking           |

### Web Frameworks

| Resource   | Library ID                       | Snippets | Use Case                  |
| ---------- | -------------------------------- | -------- | ------------------------- |
| FastAPI    | `/websites/fastapi_tiangolo`     | 31,710   | Modern async APIs         |
| Django 6.0 | `/websites/djangoproject_en_6_0` | 10,667   | Full-stack web framework  |
| Flask      | `/pallets/flask`                 | 500      | Lightweight web framework |
| Starlette  | `/encode/starlette`              | 800      | ASGI framework base       |
| Litestar   | `/litestar-org/litestar`         | 1,200    | Modern API framework      |

### Data Validation & Serialization

| Resource    | Library ID                      | Snippets | Use Case           |
| ----------- | ------------------------------- | -------- | ------------------ |
| Pydantic    | `/pydantic/pydantic`            | 2,500    | Data validation    |
| msgspec     | `/jcrist/msgspec`               | 200      | Fast serialization |
| attrs       | `/python-attrs/attrs`           | 400      | Class generation   |
| marshmallow | `/marshmallow-code/marshmallow` | 350      | Serialization      |

### Python Testing

| Resource    | Library ID                    | Snippets | Use Case          |
| ----------- | ----------------------------- | -------- | ----------------- |
| Pytest      | `/pytest-dev/pytest`          | 1,200    | Testing framework |
| Hypothesis  | `/HypothesisWorks/hypothesis` | 500      | Property testing  |
| Factory Boy | `/FactoryBoy/factory_boy`     | 200      | Test factories    |
| Faker       | `/joke2k/faker`               | 300      | Fake data         |
| pytest-mock | `/pytest-dev/pytest-mock`     | 150      | Mock integration  |

### Async & Concurrency

| Resource | Library ID                | Snippets | Use Case          |
| -------- | ------------------------- | -------- | ----------------- |
| httpx    | `/projectdiscovery/httpx` | 400      | Async HTTP client |
| aiohttp  | `/aio-libs/aiohttp`       | 600      | Async HTTP        |
| Celery   | `/celery/celery`          | 800      | Task queues       |
| dramatiq | `/Bogdanp/dramatiq`       | 200      | Task processing   |
| trio     | `/python-trio/trio`       | 400      | Async alternative |
| anyio    | `/agronholm/anyio`        | 250      | Async abstraction |

### CLI & Tooling

| Resource | Library ID            | Snippets | Use Case            |
| -------- | --------------------- | -------- | ------------------- |
| Typer    | `/tiangolo/typer`     | 300      | CLI framework       |
| Click    | `/pallets/click`      | 600      | CLI building        |
| Rich     | `/Textualize/rich`    | 800      | Terminal formatting |
| Textual  | `/Textualize/textual` | 500      | TUI applications    |

### Code Quality

| Resource | Library ID        | Snippets | Use Case         |
| -------- | ----------------- | -------- | ---------------- |
| Ruff     | `/astral-sh/ruff` | 400      | Fast linting     |
| mypy     | `/python/mypy`    | 700      | Type checking    |
| Black    | `/psf/black`      | 200      | Code formatting  |
| isort    | `/PyCQA/isort`    | 150      | Import sorting   |
| Bandit   | `/PyCQA/bandit`   | 200      | Security linting |

### Data Processing

| Resource | Library ID           | Snippets | Use Case         |
| -------- | -------------------- | -------- | ---------------- |
| Polars   | `/pola-rs/polars`    | 1,500    | Fast DataFrames  |
| Pandas   | `/pandas-dev/pandas` | 5,000    | Data analysis    |
| NumPy    | `/numpy/numpy`       | 3,000    | Numerical arrays |
| DuckDB   | `/duckdb/duckdb`     | 400      | Embedded OLAP    |
| Arrow    | `/apache/arrow`      | 600      | Columnar data    |

### Logging & Observability

| Resource      | Library ID                             | Snippets | Use Case           |
| ------------- | -------------------------------------- | -------- | ------------------ |
| structlog     | `/hynek/structlog`                     | 200      | Structured logging |
| loguru        | `/Delgan/loguru`                       | 150      | Simple logging     |
| sentry        | `/getsentry/sentry-python`             | 300      | Error tracking     |
| OpenTelemetry | `/open-telemetry/opentelemetry-python` | 400      | Tracing            |

### Packaging

| Resource | Library ID              | Snippets | Use Case              |
| -------- | ----------------------- | -------- | --------------------- |
| Poetry   | `/python-poetry/poetry` | 600      | Dependency management |
| Hatch    | `/pypa/hatch`           | 300      | Build backend         |
| PDM      | `/pdm-project/pdm`      | 250      | Package manager       |
| uv       | `/astral-sh/uv`         | 200      | Fast package manager  |

---

## JavaScript/TypeScript Ecosystem

### Frameworks

| Resource | Library ID         | Snippets | Use Case              |
| -------- | ------------------ | -------- | --------------------- |
| Next.js  | `/vercel/next.js`  | 15,000+  | React framework       |
| React    | `/facebook/react`  | 8,000+   | UI library            |
| Vue.js   | `/vuejs/vue`       | 5,000+   | Progressive framework |
| Svelte   | `/sveltejs/svelte` | 3,000+   | Compiler-based        |
| Angular  | `/angular/angular` | 10,000+  | Full framework        |
| Astro    | `/withastro/astro` | 2,000+   | Content sites         |

### Backend

| Resource | Library ID           | Snippets | Use Case            |
| -------- | -------------------- | -------- | ------------------- |
| Express  | `/expressjs/express` | 1,500    | Node.js framework   |
| Hono     | `/honojs/website`    | 1,000    | Edge runtime        |
| tRPC     | `/trpc/trpc`         | 800      | End-to-end typesafe |
| Fastify  | `/fastify/fastify`   | 1,200    | Fast Node.js        |
| NestJS   | `/nestjs/nest`       | 2,500    | Enterprise Node.js  |

### State Management

| Resource       | Library ID               | Snippets | Use Case          |
| -------------- | ------------------------ | -------- | ----------------- |
| Zustand        | `/pmndrs/zustand`        | 400      | Lightweight state |
| TanStack Query | `/TanStack/query`        | 1,500    | Server state      |
| Redux Toolkit  | `/reduxjs/redux-toolkit` | 1,000    | Global state      |
| Jotai          | `/pmndrs/jotai`          | 300      | Atomic state      |

### UI Components

| Resource     | Library ID                  | Snippets | Use Case            |
| ------------ | --------------------------- | -------- | ------------------- |
| shadcn/ui    | MCP: shadcn                 | -        | Component registry  |
| Radix UI     | `/radix-ui/primitives`      | 800      | Headless components |
| Tailwind CSS | `/tailwindlabs/tailwindcss` | 2,000    | Utility CSS         |

### Testing

| Resource        | Library ID                               | Snippets | Use Case          |
| --------------- | ---------------------------------------- | -------- | ----------------- |
| Vitest          | `/vitest-dev/vitest`                     | 600      | Fast testing      |
| Jest            | `/jestjs/jest`                           | 1,500    | Testing framework |
| Playwright      | MCP: playwright                          | -        | E2E testing       |
| Testing Library | `/testing-library/react-testing-library` | 400      | Component testing |

---

## Database & ORM

### SQL Databases

| Resource   | Library ID                              | Snippets | Use Case             |
| ---------- | --------------------------------------- | -------- | -------------------- |
| PostgreSQL | `/websites/postgresql`                  | 5,000+   | Primary SQL database |
| MySQL      | `/websites/dev_mysql_doc_refman_9_4_en` | 3,000+   | MySQL database       |
| SQLite     | `/websites/sqlite`                      | 1,000    | Embedded database    |

### NoSQL Databases

| Resource | Library ID                  | Snippets | Use Case          |
| -------- | --------------------------- | -------- | ----------------- |
| MongoDB  | `/mongodb/docs`             | 4,000+   | Document database |
| Redis    | `/websites/redis_io`        | 1,500    | Key-value/cache   |
| DynamoDB | `/websites/docs_aws_amazon` | -        | AWS NoSQL         |

### JavaScript/TypeScript ORMs

| Resource    | Library ID                       | Snippets | Use Case            |
| ----------- | -------------------------------- | -------- | ------------------- |
| Prisma      | `/prisma/docs`                   | 3,000    | Type-safe ORM       |
| Drizzle ORM | `/drizzle-team/drizzle-orm-docs` | 1,200    | SQL-like ORM        |
| TypeORM     | `/typeorm/typeorm`               | 1,500    | Decorator-based ORM |
| Sequelize   | `/sequelize/website`             | 1,000    | Node.js ORM         |
| Mongoose    | `/websites/mongoosejs`           | 800      | MongoDB ODM         |
| Knex.js     | `/knex/knex`                     | 600      | SQL query builder   |

### Python ORMs

| Resource      | Library ID                 | Snippets | Use Case             |
| ------------- | -------------------------- | -------- | -------------------- |
| SQLAlchemy    | `/sqlalchemy/sqlalchemy`   | 3,000    | ORM, Core            |
| Alembic       | `/sqlalchemy/alembic`      | 400      | Migrations           |
| SQLModel      | `/tiangolo/sqlmodel`       | 300      | FastAPI + SQLAlchemy |
| Tortoise      | `/tortoise/tortoise-orm`   | 250      | Async ORM            |
| Prisma Python | `/prisma/prisma-client-py` | 200      | Type-safe ORM        |

---

## DevOps & Infrastructure

### Containers

| Resource   | Library ID                                    | Snippets | Use Case            |
| ---------- | --------------------------------------------- | -------- | ------------------- |
| Docker     | `/docker/docs` or `/websites/docs_docker_com` | 2,000+   | Containerization    |
| Kubernetes | `/kubernetes/website`                         | 5,000+   | Orchestration       |
| Helm       | `/websites/helm_sh`                           | 800      | K8s package manager |
| Kustomize  | `/kubernetes-sigs/kustomize`                  | 400      | K8s customization   |
| ArgoCD     | `/argoproj/argo-cd`                           | 600      | GitOps              |

### CI/CD

| Resource       | Library ID                     | Snippets | Use Case         |
| -------------- | ------------------------------ | -------- | ---------------- |
| GitHub Actions | `/websites/docs_github_com_en` | 2,000    | CI/CD pipelines  |
| GitLab CI      | `/websites/docs_gitlab_com`    | 1,500    | GitLab pipelines |

### Cloud Providers

| Resource  | Library ID                  | Snippets | Use Case               |
| --------- | --------------------------- | -------- | ---------------------- |
| AWS       | `/websites/docs_aws_amazon` | 10,000+  | Amazon cloud           |
| Terraform | `/hashicorp/terraform`      | 2,000    | Infrastructure as code |
| Pulumi    | `/pulumi/docs`              | 1,000    | IaC with programming   |

---

## API Design

| Resource | Library ID                           | Snippets | Use Case              |
| -------- | ------------------------------------ | -------- | --------------------- |
| OpenAPI  | `/oai/openapi-specification`         | 500      | API specification     |
| Swagger  | `/websites/swagger_io_specification` | 400      | API documentation     |
| GraphQL  | `/graphql/graphql.github.io`         | 1,000    | Query language        |
| C4 Model | `/websites/c4model`                  | 200      | Architecture diagrams |

---

## Observability

| Resource      | Library ID                         | Snippets | Use Case            |
| ------------- | ---------------------------------- | -------- | ------------------- |
| Prometheus    | `/prometheus/docs`                 | 1,000    | Metrics             |
| Grafana       | `/grafana/grafana`                 | 800      | Dashboards          |
| OpenTelemetry | `/open-telemetry/opentelemetry-js` | 600      | Distributed tracing |
| Sentry        | `/getsentry/sentry-docs`           | 500      | Error tracking      |
| Pino          | `/pinojs/pino`                     | 300      | Node.js logging     |
| Winston       | `/winstonjs/winston`               | 400      | Node.js logging     |

---

## Query Patterns

### Python Patterns

| Topic            | Query Pattern                                       |
| ---------------- | --------------------------------------------------- |
| Async            | `"async await asyncio gather TaskGroup"`            |
| Type hints       | `"typing Generic Protocol TypeVar Annotated"`       |
| Pydantic         | `"BaseModel Field validator model_validator"`       |
| FastAPI          | `"Depends APIRouter HTTPException status"`          |
| Django ORM       | `"QuerySet filter annotate F Q objects"`            |
| Testing          | `"pytest fixture parametrize mock"`                 |
| Dataclasses      | `"@dataclass field frozen slots"`                   |
| Context managers | `"async with contextmanager asynccontextmanager"`   |
| Pattern matching | `"match case guard pattern structural"`             |
| Protocols        | `"Protocol runtime_checkable structural subtyping"` |

### JavaScript/TypeScript Patterns

| Topic           | Query Pattern                                     |
| --------------- | ------------------------------------------------- |
| React hooks     | `"useState useEffect useCallback useMemo"`        |
| Next.js routing | `"app router page layout server components"`      |
| tRPC            | `"createTRPCRouter publicProcedure input output"` |
| Prisma          | `"findMany where include select orderBy"`         |
| Drizzle         | `"pgTable serial varchar relations"`              |
| Zod             | `"z.object z.string z.number infer"`              |
| TanStack Query  | `"useQuery useMutation queryKey"`                 |

### Database Patterns

| Topic               | Query Pattern                                 |
| ------------------- | --------------------------------------------- |
| PostgreSQL index    | `"CREATE INDEX CONCURRENTLY B-tree GIN GiST"` |
| PostgreSQL query    | `"EXPLAIN ANALYZE window functions CTE"`      |
| Prisma schema       | `"model @relation @@index @@unique"`          |
| Drizzle schema      | `"pgTable serial references foreignKey"`      |
| MongoDB aggregation | `"$match $group $lookup $unwind pipeline"`    |
| Redis caching       | `"SET GET EXPIRE TTL pub/sub streams"`        |

---

## GitHub Search Patterns

### Code Search

```yaml
# Python patterns
mcp__github__search_code("@app.post Depends HTTPException filename:.py stars:>100")
mcp__github__search_code("class BaseModel Field validator filename:.py")
mcp__github__search_code("async def await asyncio.gather filename:.py stars:>50")

# TypeScript patterns
mcp__github__search_code("createTRPCRouter publicProcedure filename:.ts")
mcp__github__search_code("z.object z.string infer filename:.ts")
mcp__github__search_code("useQuery useMutation filename:.tsx")

# Database patterns
mcp__github__search_code("model @relation @@index filename:schema.prisma stars:>500")
mcp__github__search_code("pgTable serial references filename:schema.ts")
mcp__github__search_code("CREATE TABLE CONSTRAINT filename:migration stars:>500")

# Infrastructure patterns
mcp__github__search_code("FROM node alpine multi-stage production filename:Dockerfile")
mcp__github__search_code("apiVersion: apps/v1 kind: Deployment filename:.yaml")
```

### Repository Search

```yaml
mcp__github__search_repositories("python fastapi production template stars:>500")
mcp__github__search_repositories("typescript nextjs starter template stars:>1000")
mcp__github__search_repositories("kubernetes helm chart best-practices stars:>200")
```

---

## Tavily Research Patterns

### Best Practices Research

```yaml
mcp__tavily__tavily-search("Python 3.12 best practices 2025")
mcp__tavily__tavily-search("FastAPI async dependency injection patterns")
mcp__tavily__tavily-search("Next.js 14 app router patterns 2025")
mcp__tavily__tavily-search("PostgreSQL 16 query optimization best practices")
mcp__tavily__tavily-search("microservices vs modular monolith 2025 decision guide")
mcp__tavily__tavily-search("Kubernetes best practices production 2025")
```

### Technology Comparison

```yaml
mcp__tavily__tavily-search("Prisma vs Drizzle vs TypeORM comparison 2025")
mcp__tavily__tavily-search("REST vs GraphQL vs tRPC comparison 2025")
mcp__tavily__tavily-search("Vitest vs Jest comparison 2025")
mcp__tavily__tavily-search("Docker vs Podman comparison")
```

---

## Notes

- Library IDs may change over time; use `resolve-library-id` to get current IDs
- Snippet counts are approximate and represent indexed documentation pages
- Some resources are available through MCP tools (e.g., `shadcn`, `playwright`)
- Always verify library IDs before querying documentation
