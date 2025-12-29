# GitLab CI Reference

## Pipeline Structure

```yaml
# .gitlab-ci.yml

stages:
  - build
  - test
  - deploy

variables:
  NODE_VERSION: "20"

default:
  image: node:${NODE_VERSION}
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - node_modules/
```

## Node.js Pipeline

```yaml
stages:
  - install
  - lint
  - test
  - build
  - deploy

variables:
  NODE_ENV: test

.node_template: &node_template
  image: node:20-alpine
  cache:
    key:
      files:
        - package-lock.json
    paths:
      - node_modules/
    policy: pull

install:
  <<: *node_template
  stage: install
  cache:
    policy: pull-push
  script:
    - npm ci
  artifacts:
    paths:
      - node_modules/
    expire_in: 1 hour

lint:
  <<: *node_template
  stage: lint
  needs: [install]
  script:
    - npm run lint

test:
  <<: *node_template
  stage: test
  needs: [install]
  script:
    - npm test -- --coverage
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      junit: junit.xml
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml

build:
  <<: *node_template
  stage: build
  needs: [lint, test]
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
  only:
    - main
    - tags
```

## Python Pipeline

```yaml
stages:
  - test
  - build
  - deploy

variables:
  PIP_CACHE_DIR: "$CI_PROJECT_DIR/.cache/pip"

.python_template: &python_template
  image: python:3.11-slim
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - .cache/pip
      - venv/

before_script:
  - python -m venv venv
  - source venv/bin/activate
  - pip install --upgrade pip
  - pip install -r requirements.txt

lint:
  <<: *python_template
  stage: test
  script:
    - pip install ruff mypy
    - ruff check .
    - mypy src/

test:
  <<: *python_template
  stage: test
  script:
    - pip install pytest pytest-cov
    - pytest --cov=src --cov-report=xml --junitxml=report.xml
  coverage: '/TOTAL.*\s+(\d+%)/'
  artifacts:
    reports:
      junit: report.xml
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml

build:
  <<: *python_template
  stage: build
  script:
    - pip install build
    - python -m build
  artifacts:
    paths:
      - dist/
  only:
    - tags
```

## Docker Build

```yaml
stages:
  - build
  - push
  - deploy

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"
  IMAGE_TAG: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

build:
  stage: build
  image: docker:24
  services:
    - docker:24-dind
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - docker build --cache-from $CI_REGISTRY_IMAGE:latest -t $IMAGE_TAG .
    - docker push $IMAGE_TAG
  only:
    - main
    - merge_requests

push_latest:
  stage: push
  image: docker:24
  services:
    - docker:24-dind
  needs: [build]
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - docker pull $IMAGE_TAG
    - docker tag $IMAGE_TAG $CI_REGISTRY_IMAGE:latest
    - docker push $CI_REGISTRY_IMAGE:latest
  only:
    - main

push_tag:
  stage: push
  image: docker:24
  services:
    - docker:24-dind
  needs: [build]
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - docker pull $IMAGE_TAG
    - docker tag $IMAGE_TAG $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
  only:
    - tags
```

## Kubernetes Deployment

```yaml
.deploy_template: &deploy_template
  image: bitnami/kubectl:latest
  before_script:
    - kubectl config set-cluster k8s --server="$KUBE_URL" --certificate-authority="$KUBE_CA_PEM_FILE"
    - kubectl config set-credentials gitlab --token="$KUBE_TOKEN"
    - kubectl config set-context default --cluster=k8s --user=gitlab
    - kubectl config use-context default

deploy_staging:
  <<: *deploy_template
  stage: deploy
  environment:
    name: staging
    url: https://staging.example.com
  script:
    - kubectl set image deployment/app app=$IMAGE_TAG -n staging
    - kubectl rollout status deployment/app -n staging
  only:
    - main

deploy_production:
  <<: *deploy_template
  stage: deploy
  environment:
    name: production
    url: https://example.com
  script:
    - kubectl set image deployment/app app=$IMAGE_TAG -n production
    - kubectl rollout status deployment/app -n production
  when: manual
  only:
    - tags
```

## Multi-Environment Deployment

```yaml
stages:
  - build
  - test
  - deploy

.deploy:
  stage: deploy
  script:
    - echo "Deploying to $CI_ENVIRONMENT_NAME"
    - ./deploy.sh $CI_ENVIRONMENT_NAME

deploy:staging:
  extends: .deploy
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - develop

deploy:production:
  extends: .deploy
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

## Merge Request Pipelines

```yaml
workflow:
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH && $CI_OPEN_MERGE_REQUESTS
      when: never
    - if: $CI_COMMIT_BRANCH

test:
  stage: test
  script:
    - npm test
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
```

## Parallel and Matrix Jobs

```yaml
test:
  stage: test
  parallel:
    matrix:
      - PYTHON_VERSION: ["3.10", "3.11", "3.12"]
        DATABASE: ["postgres", "mysql"]
  image: python:$PYTHON_VERSION
  services:
    - name: $DATABASE:latest
      alias: db
  script:
    - pytest
```

## DAG (Directed Acyclic Graph)

```yaml
stages:
  - build
  - test
  - deploy

build_frontend:
  stage: build
  script: npm run build:frontend
  artifacts:
    paths: [dist/frontend]

build_backend:
  stage: build
  script: npm run build:backend
  artifacts:
    paths: [dist/backend]

test_frontend:
  stage: test
  needs: [build_frontend]
  script: npm run test:frontend

test_backend:
  stage: test
  needs: [build_backend]
  script: npm run test:backend

deploy:
  stage: deploy
  needs: [test_frontend, test_backend]
  script: ./deploy.sh
```

## Include and Extends

### Local includes
```yaml
include:
  - local: '/.gitlab/ci/build.yml'
  - local: '/.gitlab/ci/test.yml'
  - local: '/.gitlab/ci/deploy.yml'
```

### Remote includes
```yaml
include:
  - project: 'company/ci-templates'
    ref: main
    file: '/templates/node.yml'
```

### Template extension
```yaml
# templates/base.yml
.base:
  before_script:
    - echo "Setting up..."
  after_script:
    - echo "Cleaning up..."

# .gitlab-ci.yml
include:
  - local: 'templates/base.yml'

job:
  extends: .base
  script:
    - echo "Running job"
```

## Artifacts and Caching

```yaml
build:
  script: npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
    reports:
      junit: junit.xml
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura.xml

test:
  cache:
    key:
      files:
        - package-lock.json
    paths:
      - node_modules/
    policy: pull-push
```

## Security Scanning

```yaml
include:
  - template: Security/SAST.gitlab-ci.yml
  - template: Security/Secret-Detection.gitlab-ci.yml
  - template: Security/Dependency-Scanning.gitlab-ci.yml
  - template: Security/Container-Scanning.gitlab-ci.yml

container_scanning:
  variables:
    CS_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
```

## Best Practices

1. **Use templates** - DRY with `.template` and `extends`
2. **Cache wisely** - Use file-based cache keys
3. **Use artifacts** - Pass data between jobs
4. **DAG optimization** - Use `needs` for parallel execution
5. **Environment protection** - Use protected environments for production
6. **Security scanning** - Include GitLab security templates
7. **Review apps** - Create dynamic environments for MRs
