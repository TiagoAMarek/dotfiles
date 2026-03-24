# AGENTS.md Patterns by Project Type

Reference guide for common AGENTS.md patterns by technology stack and project structure.

---

## Node.js Projects

### Minimal (Small Library)

**Target**: 25-40 lines

```markdown
# AGENTS.md

## Build & Test
npm run build        # TypeScript → dist/
npm test             # Jest
npm run lint         # ESLint

## Code Style
- Use const, never var
- camelCase for variables
- NEVER use default exports

## Type Checking
TypeScript strict mode. All code must pass type checking.
```

**Focus**: Build commands, code style basics, type requirements

---

### Standard (App or Library)

**Target**: 50-75 lines

```markdown
# AGENTS.md

## Build & Test
npm run build -- --production
npm test -- --coverage
npm run lint
npm run type-check

## Code Style
MANDATORY:
- Use const, NEVER var
- camelCase for variables
- Arrow functions for callbacks
- NEVER use default exports

PREFERRED:
- One export per file
- 80-character line limit (with exceptions for imports)

## Module Structure
/src/utils/      — Pure functions, no React imports
/src/services/   — API clients, no React imports
/src/hooks/      — Custom React hooks
/src/components/ — React components

## Error Handling
ALWAYS wrap async/await in try/catch
NEVER use .catch() for error handling
```

**Focus**: Build/test, folder structure, component patterns

---

### Complex (Large Application)

**Target**: 100-150 lines

```markdown
# AGENTS.md

## Commands
npm run dev              # Start development server with hot reload
npm run build -- --minify
npm test -- --watch
npm run lint -- --fix
npm run type-check

## Mandatory Rules (ALL code)
- ALWAYS use const
- NEVER use var
- NEVER use default exports
- NEVER use function declarations (use arrow functions)
- ALWAYS use async/await, never .then()
- NEVER use setTimeout in tests

## Module Structure
/src/
  /utils/        — Pure functions, no side effects, no imports from other src/
  /services/     — API clients, configuration, no React imports
  /hooks/        — React hooks, can import from utils/ and services/
  /components/   — React components, can import from all modules
  /types/        — TypeScript interfaces and types
  /constants/    — Constants, no functions

## Component Patterns
- Functional components only
- Use React.memo for performance-critical components
- Custom hooks for state and side effects
- Avoid prop drilling, use Context API for shared state

## API Integration
- Use services/api/ client for all requests
- NEVER make fetch calls in components
- MANDATORY error handling for all API calls

## Testing
- Unit tests for utils/ and services/
- Integration tests for components
- Snapshot tests only for small components
- Aim for 80%+ coverage
```

**Focus**: Detailed structure, patterns, integration rules

---

## Python Projects

### Data Science

**Target**: 60-90 lines

```markdown
# AGENTS.md

## Commands
pytest tests/ -v
pytest tests/ --cov=src --cov=70
mypy src/ --strict
ruff check src/
jupyter notebook

## Data Handling
MANDATORY:
- Raw data in data/raw/ with date stamps
- Processing scripts in src/processing/, not notebooks
- NEVER modify raw data files
- Processed data in data/processed/

## Notebooks
- Exploratory: notebooks/exploratory/
- Final: notebooks/final/
- NEVER commit notebooks to git
- Code from notebooks → src/ modules

## Model Management
- Models in models/ with version: model_v1.pkl
- ALWAYS include training date in filename
- NEVER hardcode paths, use MODEL_PATH env var
- Model cards in models/[name]_card.md

## Type Checking
Strict mode required (mypy --strict). All functions must have type hints.
NEVER use Any type.
```

**Focus**: Data pipeline, notebook conventions, artifact management

---

### API (FastAPI/Django)

**Target**: 70-100 lines

```markdown
# AGENTS.md

## Commands
python -m pytest tests/
python -m pytest tests/ --cov=app
python manage.py runserver (Django) OR uvicorn main:app (FastAPI)
mypy app/ --strict

## Endpoint Patterns
GET /api/resource/        → List
GET /api/resource/{id}/   → Retrieve
POST /api/resource/       → Create (requires body)
PUT /api/resource/{id}/   → Update (full)
PATCH /api/resource/{id}/ → Partial update

## Request/Response
MANDATORY:
- All endpoints return JSON
- NEVER return raw HTML
- Status codes: 200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found, 500 Server Error
- NEVER use 200 for errors

## Database
- Models in app/models/
- Queries in app/repositories/ (Django) or app/db.py (FastAPI)
- NEVER query in route handlers, use repository pattern
- ALWAYS use prepared statements

## Error Handling
MANDATORY:
- All exceptions caught and logged
- NEVER expose internal errors to client
- Return standard error format: {"error": "message", "status": 400}
```

**Focus**: API patterns, error handling, database patterns

---

## Monorepos

### Nx/Turborepo Structure

**Target**: 120-180 lines

```markdown
# AGENTS.md

## Workspace Commands
npm run build                      # Build all packages
npm run build -- --filter=web      # Build single package
npm run test
npm run test -- --filter=api

## Build Order Dependencies
web → depends on lib/
api → depends on lib/, shared/
lib/ → depends on shared/
shared/ → depends on nothing

## Mandatory Rules (ALL packages)
- Use TypeScript strict mode
- NEVER use default exports
- NEVER import from sibling packages directly
- Import from: import { X } from "@workspace/package"

## Package Rules

### @workspace/web (React)
- React 18+, functional components
- Component files: .tsx
- NEVER import from api/
- Use client API module for requests

### @workspace/api (Express)
- Express server with dependency injection
- Route files: routes/[resource].ts
- NEVER async handler without try/catch
- Models in models/, controllers in controllers/

### @workspace/lib (Shared utilities)
- Pure functions, no React, no Node imports
- Exports in lib/package.json "exports" field
- No side effects

### @workspace/shared (Types & constants)
- Only TypeScript interfaces and types
- Only constants, no functions
- Used by all other packages

## Cross-Package Communication
web → uses api through client library
web → uses lib
api → uses lib and shared
lib → uses shared only

## Testing
Unit tests: same directory as source
Integration tests: tests/ directory at workspace root
NEVER mock packages, use real implementations from lib/
```

**Focus**: Build order, cross-package rules, package-specific guidance

---

## Frontend (React/Next.js/Vue)

### Standard React App

**Target**: 50-80 lines

```markdown
# AGENTS.md

## Build & Test
npm run dev           # Development server with HMR
npm run build         # Production build
npm test              # Jest + React Testing Library
npm run lint

## Component Structure
/src/
  /components/       — Reusable components
  /pages/ or /views/ — Page components
  /hooks/            — Custom hooks
  /services/         — API clients
  /utils/            — Pure functions
  /types/            — TypeScript types

## Component Patterns
- Functional components only
- One component per file (except closely related)
- Use custom hooks for reusable logic
- Props: destructure in function parameters

## Styling
CSS Modules (or Tailwind/Styled Components)
- Component styles in Component.module.css
- Global styles in styles/global.css
- NEVER use inline styles

## State Management
Use React Context for app-level state.
NEVER use Redux without explicit team decision.

## Testing
- Test files: __tests__/ or .test.tsx next to source
- React Testing Library (prefer over Enzyme)
- Test behavior, not implementation
- Aim for 70%+ coverage
```

**Focus**: Component patterns, styling approach, state management

---

## Common Deviations from Standards

### Strict Type Checking

```markdown
## Type Checking
TypeScript strict mode MANDATORY:
- noImplicitAny: must have types
- strictNullChecks: null/undefined explicit
- strictFunctionTypes: function types strict
NEVER use any. Use unknown if necessary.
```

### Custom Formatting Rules

```markdown
## Code Format
ESLint enforces rules (see .eslintrc.json).
Project deviations:
- 100-character line limit (not standard 80)
- 2-space indentation (not standard 4)
- Semicolons required (not Prettier default)
```

### Framework-Specific Overrides

```markdown
## Next.js Specific
NEVER use getServerSideProps in app/ routes.
Use Server Components by default, Client Components marked with 'use client'.
Routes in app/ directory, not pages/.
```

```markdown
## Django Specific
NEVER use raw SQL, use ORM.
Migrations are required for schema changes.
USE: python manage.py makemigrations after model changes.
THEN: python manage.py migrate before deployment.
```

---

## Patterns to Avoid in AGENTS.md

### ❌ Avoid: Framework Tutorials

```markdown
# BAD: Explains what the framework is

## What is React?
React is a JavaScript library for building user interfaces...
Components are reusable building blocks...
```

```markdown
# GOOD: Assumes agent knows React, states project-specific rules

## Component Patterns
Functional components only.
Custom hooks for shared logic.
Avoid prop drilling; use Context API.
```

---

### ❌ Avoid: Repeating Config Files

```markdown
# BAD: Copies .eslintrc rules

## ESLint Rules
No var keyword.
camelCase for variables.
No default exports.
```

```markdown
# GOOD: References config, states if project deviates

## Code Style
See .eslintrc for rules. Project deviations:
- We use 100-char line limit (vs 80 standard)
- We require semicolons explicitly
```

---

### ❌ Avoid: Generic Best Practices

```markdown
# BAD: Generic advice not unique to project

## Testing
Write tests for your code.
Test edge cases.
Use mocks when necessary.
Aim for good coverage.
```

```markdown
# GOOD: Project-specific testing rules

## Testing
Aim for 80%+ coverage (enforced in CI).
DO NOT use mocks, test with real implementations.
Test files: tests/ directory, name: [feature].test.ts
```

---

## Quick Reference: What to Include by Project Type

| Type | Must Include | Nice to Have |
|------|----------|--------------|
| **Node.js Library** | Build command, export pattern | Type checking |
| **Node.js App** | Build/test, folder structure, state management | Error handling, testing approach |
| **Frontend** | Component patterns, styling approach | State management, routing rules |
| **Backend API** | Endpoint patterns, error format, auth | Database patterns, validation |
| **Data Science** | Data handling, notebook conventions, artifact storage | Model versioning, testing approach |
| **Monorepo** | Build order, cross-package rules, package-specific patterns | Workspace commands |

Use this as a checklist when evaluating completeness (D7).
