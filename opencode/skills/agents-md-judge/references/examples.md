# Example AGENTS.md Files — Good vs Poor

## Example 1: Simple Node.js Project

### Poor Example (Generic Tutorial)

```markdown
# AGENTS.md

## Building Your Project

To build the project, you'll want to run the npm build command. This compiles
your TypeScript code into JavaScript. Make sure you have Node.js installed first.

## TypeScript

TypeScript is a superset of JavaScript that adds static types. It helps catch errors
before runtime. Types are optional but strongly recommended.

## Testing

You should write tests for your code. Tests help ensure your code works as expected.
You can use Jest or Mocha for testing. Make sure to test edge cases.

## Code Style

Write clean code. Use meaningful variable names. Avoid nesting too deeply.
Handle errors properly. Don't use var, use const instead.

## Comments

Comments are helpful for explaining complex logic. Write comments in a clear way.
```

**Problems**:
- Generic framework basics (what TypeScript is, how Jest works)
- No actual commands
- Vague rules ("write clean code", "handle errors properly")
- No project-specific guidance
- No distinction between mandatory and optional
- ~220 words of generic advice

**Score**: ~D (65/100)
- D1: 8/30 (mostly generic)
- D2: 5/20 (no actual commands)
- D3: 3/15 (no enforcement clarity)
- D4: 3/15 (too long for simple project)
- D5: 6/10 (some structure but unclear)
- D6: 0/5 (all redundant)
- D7: 4/5 (has some elements)

---

### Good Example (Project-Specific)

```markdown
# AGENTS.md

## Build & Test Commands

```bash
npm run build        # Compile TypeScript to dist/
npm run test         # Run Jest with coverage (must be >80%)
npm run lint         # Check code with ESLint
```

## Code Style

MANDATORY:
- ALWAYS use `const`, NEVER use `var`
- NEVER use default exports from utils/
- Use camelCase for variables: userName, isActive
- Use SCREAMING_SNAKE_CASE for constants

PREFERRED:
- Arrow functions for callbacks
- Explicit return types in async functions

## Module Structure

- `/src/utils/` — Pure functions, no side effects
- `/src/services/` — API clients, no React imports
- `/src/hooks/` — React hooks only, cannot import from utils/
- `/src/components/` — React components only

## TypeScript

Strict mode enabled (tsconfig.json). All code must pass type checking.
NEVER use `any` type. Use `unknown` if truly unknown.
```

**Strengths**:
- Project-specific rules (no default exports, specific folder structure)
- Exact commands with context
- Clear mandatory vs preferred
- Concise (35 lines)
- Focused on what's unique here

**Score**: A (92/100)
- D1: 28/30 (all project-specific, one generic mention)
- D2: 19/20 (exact commands, clear rules)
- D3: 15/15 (perfect enforcement)
- D4: 15/15 (right length for simple project)
- D5: 9/10 (good structure, minor improvements)
- D6: 5/5 (nothing redundant)
- D7: 5/5 (all essentials)

---

## Example 2: Complex Monorepo

### Poor Example (Encyclopedia)

```markdown
# AGENTS.md

## Architecture Overview

This is a monorepo containing 12 packages organized as follows...
[200 lines explaining architecture, not project-specific rules]

## Individual Package Builds

### Package: web
The web package contains React components...
[100 lines explaining web package]

### Package: api
The API package provides endpoints for...
[100 lines explaining API]

[... continues with 500+ lines of documentation]
```

**Problems**:
- Reads like README, not project context
- Explains package structure instead of coding rules
- No actual guidance on what to do
- Too long (500+ lines for complex = fine length, but content is wrong)

**Score**: D (62/100)
- D1: 10/30 (mostly architectural explanation, not guidance)
- D2: 8/20 (no actionable commands or rules)
- D3: 5/15 (no enforcement)
- D4: 15/15 (length is right, but content is wrong)
- D5: 8/10 (organized but not actionable)
- D6: 0/5 (should be in README)
- D7: 3/5 (missing critical guidance)

---

### Good Example (Project-Specific Rules for Monorepo)

```markdown
# AGENTS.md

## Build & Test

From workspace root:
```bash
bun install                    # Install all packages
bun run build                  # Build all packages
bun run build -- --filter=web # Build only web package
bun test                       # Test all packages
```

From individual package directory:
```bash
bun run build
bun test
```

## Mandatory Rules (ALL packages)

- ALWAYS use TypeScript strict mode
- NEVER use default exports
- NEVER import from sibling packages without going through exports
- Use camelCase for variables, SCREAMING_SNAKE_CASE for constants

## Package-Specific Rules

### web (React frontend)
- DO NOT import from api/ directly, use client API module
- React 18+, functional components only
- Component files use .tsx extension

### api (Express backend)
- MUST use dependency injection for database/logger
- NEVER use async/await in route handlers without try/catch
- Router files: /routes/[resource].ts

### db (Shared database)
- DO NOT expose queries directly, use repository pattern
- Migrations must be reversible
- NEVER name migrations generically

## Code Review Checklist

When reviewing PRs, check:
- [ ] No var keyword
- [ ] No default exports
- [ ] Cross-package imports use correct entry points
- [ ] Package-specific rules followed
```

**Strengths**:
- Exact commands with context for each package
- Mandatory rules clearly marked (applies to all)
- Package-specific guidance (what makes each different)
- Practical (usable as PR checklist)
- Concise (~90 lines) for a monorepo

**Score**: A (91/100)
- D1: 28/30 (very project-specific, minor room for improvement)
- D2: 20/20 (exact commands, actionable rules, checklist)
- D3: 15/15 (perfect enforcement)
- D4: 14/15 (slightly under ideal for complex monorepo, but focused)
- D5: 9/10 (organized well, minor improvement)
- D6: 5/5 (nothing redundant)
- D7: 5/5 (all essentials covered)

---

## Example 3: Python Data Science Project

### Poor Example (Redundant with Config)

```markdown
# AGENTS.md

## Python Version

This project uses Python 3.11. Make sure you have it installed.

## Dependencies

We use several important libraries:
- pandas: For data manipulation
- scikit-learn: For machine learning
- jupyter: For notebooks

Install them with: pip install -r requirements.txt

## Code Style

We follow PEP 8 naming conventions. Use snake_case for variables.
Use 4 spaces for indentation. Keep line length under 88 characters.
These are configured in pyproject.toml.

## Type Hints

We use type hints in our code. Type hints help catch errors.

## Testing

We use pytest for testing. Write test files in tests/ directory.
Test functions should start with test_.
```

**Problems**:
- Explains PEP 8 (standard Python, not project-specific)
- Refers to pyproject.toml but repeats its content
- Doesn't explain anything unique about THIS project
- Generic best practices ("write tests")
- No actual commands

**Score**: D (58/100)
- D1: 5/30 (all generic)
- D2: 6/20 (mentions tools but no actual commands)
- D3: 2/15 (no enforcement)
- D4: 10/15 (slightly long for simple project)
- D5: 5/10 (poor organization)
- D6: 0/5 (all redundant with pyproject.toml)
- D7: 2/5 (missing critical info)

---

### Good Example (Project-Specific)

```markdown
# AGENTS.md

## Build & Test

```bash
pytest tests/ -v --tb=short         # Run all tests
pytest tests/ --cov=src --cov=60    # Must achieve 60% coverage
mypy src/ --strict                  # Type checking, no errors allowed
ruff check src/                      # Linting (see ruff.toml for rules)
jupyter notebook                     # Start Jupyter for analysis
```

## Data Pipeline Rules

MANDATORY:
- All raw data in `data/raw/` with date-stamped filenames
- Processing scripts in `src/processing/`, not notebooks
- DO NOT modify raw data files, always create processed versions
- NEVER commit data files >1MB to Git, use DVC instead

## Notebook Conventions

PREFERRED:
- Development notebooks in `notebooks/exploratory/`
- Final analysis notebooks in `notebooks/final/`
- DO NOT run final notebooks from root, run from `notebooks/` dir
- Clear markdown between cells explaining analysis

## Model Artifacts

- Trained models stored in `models/` with version: `model_v1.pkl`
- NEVER hardcode model paths, use `MODEL_PATH` env variable
- ALWAYS include model training date and dataset version in filename

## Python

Strict type checking required (mypy --strict). All functions must have type hints.
NEVER use `Any` type.
```

**Strengths**:
- Actual commands with expected behavior
- Project-specific rules (data handling, notebook location, DVC requirement)
- Mandatory rules clearly marked
- Addresses data science workflows (raw data, processing, notebooks, models)
- Concise (~60 lines)

**Score**: A (94/100)
- D1: 29/30 (nearly all project-specific)
- D2: 19/20 (exact commands, actionable rules)
- D3: 15/15 (perfect enforcement)
- D4: 15/15 (perfect length for medium complexity)
- D5: 10/10 (excellent organization)
- D6: 5/5 (nothing redundant)
- D7: 5/5 (all essentials)

---

## Summary: What Makes a Good AGENTS.md

| Element | Good | Poor |
|---------|------|------|
| **Content** | Project-specific rules | Generic best practices |
| **Commands** | Exact with flags | Vague or missing |
| **Enforcement** | MANDATORY/prefer/consider | All equal weight |
| **Length** | Focused (20-200 lines) | Encyclopedia or stub |
| **Redundancy** | Nothing in config files | Repeats .eslintrc, pyproject.toml |
| **Actionability** | Can implement immediately | Requires interpretation |
| **Organization** | Clear sections | Random order |

---

## Evaluation Checklist

Use these examples as reference when scoring new AGENTS.md files:

- Does it read like a tutorial or like project context?
- Are the commands exact and tested?
- Is the enforcement clear (MANDATORY vs optional)?
- Does it contain anything in config files?
- Would a new engineer know what's unique about this project after reading it?
- Can you immediately act on the guidance, or does it require interpretation?

If it matches the "good" column above → likely high score (A/B).
If it matches the "poor" column → likely low score (D/F).
