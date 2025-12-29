# Test Framework Detection

Patterns for detecting test frameworks across different ecosystems.

## JavaScript/TypeScript

### Jest
```bash
# Detection files
package.json (jest in dependencies/devDependencies)
jest.config.js
jest.config.ts
jest.config.json

# Test file patterns
**/*.test.js
**/*.test.ts
**/*.spec.js
**/*.spec.ts
**/__tests__/**/*.js
**/__tests__/**/*.ts

# Run command
npm test
npx jest
npx jest --coverage
```

### Vitest
```bash
# Detection files
vitest.config.js
vitest.config.ts
vite.config.* (with test configuration)

# Test file patterns
**/*.test.ts
**/*.spec.ts

# Run command
npm test
npx vitest
npx vitest --coverage
```

### Mocha
```bash
# Detection files
.mocharc.js
.mocharc.json
.mocharc.yml
mocha.opts (legacy)

# Test file patterns
test/**/*.js
test/**/*.ts

# Run command
npm test
npx mocha
```

## Python

### Pytest
```bash
# Detection files
pytest.ini
pyproject.toml (with [tool.pytest] or [pytest])
conftest.py
setup.cfg (with [tool:pytest])

# Test file patterns
test_*.py
*_test.py
tests/*.py

# Run command
pytest
pytest -v
pytest --cov=src
python -m pytest
```

### unittest
```bash
# Detection files (none specific, standard library)
# Test file patterns
test_*.py

# Run command
python -m unittest discover
python -m unittest test_module
```

## Go

### go test
```bash
# Detection files
go.mod
*_test.go files

# Test file patterns
*_test.go

# Run command
go test ./...
go test -v ./...
go test -cover ./...
go test -coverprofile=coverage.out ./...
```

## Rust

### cargo test
```bash
# Detection files
Cargo.toml
tests/ directory

# Test file patterns
tests/*.rs
src/**/*.rs (with #[test] annotations)

# Run command
cargo test
cargo test --all
cargo test -- --nocapture
```

## Ruby

### RSpec
```bash
# Detection files
.rspec
spec/spec_helper.rb
Gemfile (rspec gem)

# Test file patterns
spec/**/*_spec.rb

# Run command
bundle exec rspec
rspec
```

### Minitest
```bash
# Detection files
test/test_helper.rb

# Test file patterns
test/**/*_test.rb

# Run command
ruby -Itest test/test_*.rb
rake test
```

## PHP

### PHPUnit
```bash
# Detection files
phpunit.xml
phpunit.xml.dist

# Test file patterns
tests/**/*Test.php

# Run command
./vendor/bin/phpunit
phpunit
```

## Detection Priority

When multiple frameworks detected, prioritize:

1. **Config file present** - Explicit configuration wins
2. **Package manager** - Check dependencies
3. **Test directory structure** - Standard patterns
4. **Test file naming** - *.test.*, *_test.*, *_spec.*

## Auto-Detection Script

```bash
detect_test_framework() {
    # JavaScript/TypeScript
    if [ -f "jest.config.js" ] || [ -f "jest.config.ts" ]; then
        echo "jest"
    elif [ -f "vitest.config.js" ] || [ -f "vitest.config.ts" ]; then
        echo "vitest"
    elif [ -f ".mocharc.js" ] || [ -f ".mocharc.json" ]; then
        echo "mocha"
    # Python
    elif [ -f "pytest.ini" ] || [ -f "conftest.py" ]; then
        echo "pytest"
    # Go
    elif [ -f "go.mod" ] && ls *_test.go 1>/dev/null 2>&1; then
        echo "go"
    # Rust
    elif [ -f "Cargo.toml" ]; then
        echo "cargo"
    # Ruby
    elif [ -f ".rspec" ] || [ -d "spec" ]; then
        echo "rspec"
    # PHP
    elif [ -f "phpunit.xml" ] || [ -f "phpunit.xml.dist" ]; then
        echo "phpunit"
    else
        echo "unknown"
    fi
}
```
