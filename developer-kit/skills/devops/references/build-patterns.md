# Build Patterns

## Build Types

### Development Build
```bash
# Fast builds for development
npm run dev
# or
yarn dev
```
- Hot module replacement enabled
- Source maps included
- No minification
- Fast iteration

### Production Build
```bash
# Optimized production builds
npm run build
# or
yarn build
```
- Minification enabled
- Tree shaking
- Code splitting
- Optimized assets

### Test Build
```bash
# Build for testing environment
NODE_ENV=test npm run build
```
- Test instrumentation
- Coverage collection
- Mock integrations

## Common Build Issues

### Dependency Errors
```
Error: Cannot find module 'package-name'
```
**Solution**: `npm install` or check package.json

### Memory Issues
```
FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed
```
**Solution**: `NODE_OPTIONS=--max_old_space_size=4096 npm run build`

### TypeScript Errors
```
error TS2307: Cannot find module
```
**Solution**: Check tsconfig paths, install @types packages

## Build Optimization

### Bundle Analysis
```bash
# Analyze bundle size
npm run build -- --analyze
# or use webpack-bundle-analyzer
```

### Code Splitting
```javascript
// Dynamic imports for code splitting
const Component = lazy(() => import('./Component'));
```

### Tree Shaking
- Use ES modules (import/export)
- Avoid side effects in modules
- Mark pure functions

## CI/CD Integration

### GitHub Actions
```yaml
- name: Build
  run: npm run build
  env:
    NODE_ENV: production
```

### Docker Build
```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
```
