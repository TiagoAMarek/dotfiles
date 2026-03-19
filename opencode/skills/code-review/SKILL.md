---
name: code-review
description: Review code for security, performance, maintainability, and compliance with project standards. Use when reviewing pull requests, code changes, or providing feedback on implementations. Checks against AGENTS.md standards, framework best practices (Next.js, React, TypeScript), and detects common anti-patterns in monorepo setups.
license: MIT
compatibility: opencode
---

# Code Review

## Core Philosophy

Great code reviews balance finding issues with acknowledging good patterns. They're not about personal preference—they're about production stability, maintainability, and compliance with documented standards.

**Priority order**:
1. **Project standards** (AGENTS.md) - if it exists, this is law
2. **Security** - vulnerabilities that could be exploited
3. **Performance** - issues that degrade user experience
4. **Maintainability** - code that will be hard to change in 6 months
5. **Style** - only when it impacts readability or violates documented conventions

Expert reviewers know what NOT to do as much as what to do. Half of expertise is recognizing anti-patterns before they reach production.

## Review Mindset

Before reviewing, ask yourself:

**Risk Assessment**:
- What could break in production? (runtime errors, security holes)
- What assumptions could fail? (null checks, type safety, edge cases)
- What external dependencies could change? (API contracts, library versions)

**Maintainability Lens**:
- Will this be clear to someone in 6 months?
- Is the complexity justified by the requirements?
- Are tests sufficient to catch regressions?

**Standards Compliance**:
- Does this follow documented project conventions?
- Are there NEVER/ALWAYS rules being violated?
- Is the tech stack being used correctly? (Server Components, hook rules, etc.)

**Positive Recognition**:
- What's done well that should be acknowledged?
- Are there patterns worth replicating elsewhere?
- Did they handle edge cases thoughtfully?

## The Review Process

### Phase 1: Context Discovery

**ALWAYS start by finding project standards:**

```bash
# Check for AGENTS.md files (priority order)
ls .opencode/AGENTS.md 2>/dev/null
ls AGENTS.md 2>/dev/null
find packages -name "AGENTS.md" -type f 2>/dev/null  # For monorepos
```

**Parse severity from keywords**:
- **Critical** (must fix): NEVER, ALWAYS, MUST, REQUIRED, CRITICAL
- **Important** (should fix): SHOULD, IMPORTANT, RECOMMENDED, AVOID
- **Minor** (nice to have): PREFER, CONSIDER, OPTIONAL, TRY

**Detect tech stack** (if no AGENTS.md):
- Read `package.json` for dependencies
- Check for `next.config.js` (Next.js), `tsconfig.json` (TypeScript)
- Look at imports in code being reviewed

**When you need detailed discovery guidance**, load `references/project-standards-guide.md`.

### Phase 2: Systematic Review

Review in this order:

**1. Project Standards First** (if AGENTS.md exists)
- Check for violations of documented NEVER/ALWAYS rules
- Cite AGENTS.md with file path and line numbers
- This takes priority over everything else

**2. Security**
- Input validation before use
- Environment variables (client vs server-only)
- Authentication/authorization checks
- No secrets in code

**3. Performance**
- Unnecessary React rerenders (missing memo, wrong deps)
- N+1 database queries
- Large Client Components in Next.js
- Missing pagination

**4. Maintainability**
- Type safety (no `any` types)
- Test coverage for new functionality
- Clear variable/function names
- Error handling

**5. Framework-Specific**
- Next.js: Server vs Client Components, data fetching patterns
- React: Hook dependency arrays, effect cleanup
- TypeScript: Proper type guards, generic usage

**For comprehensive checklists**, load `references/review-categories.md`.

**For framework expert patterns**, load `references/framework-specifics.md`.

### Phase 3: Categorize & Report

**🔴 Critical Issues** (must fix before merge):
- Security vulnerabilities
- NEVER/ALWAYS rule violations from AGENTS.md
- Breaking changes
- Type safety violations (if project uses TypeScript strict mode)

**🟡 Important Suggestions** (should fix):
- Performance concerns
- Maintainability issues
- Missing tests
- Deviation from project conventions (non-critical)

**🟢 Minor Suggestions** (nice to have):
- Code style improvements
- Alternative approaches
- Optimization opportunities

**✅ Positive Feedback** (always include):
- Good patterns followed
- Strong test coverage
- Thoughtful edge case handling
- Compliance with standards

**Format**: Always include:
- Brief description of issue
- WHY it matters (not just WHAT is wrong)
- Code example for suggested fix
- AGENTS.md reference (if applicable) with file path and line number

## Anti-Patterns: NEVER Do

### Review Process
- **NEVER skip reading AGENTS.md** when it exists—project standards override your preferences
- **NEVER give generic feedback** like "looks good" or "needs improvement" without specifics
- **NEVER report issues without WHY**—explain the impact (security, performance, maintainability)
- **NEVER forget positive feedback**—acknowledge what's done well
- **NEVER enforce strict rules on permissive codebases**—if it's JavaScript, don't demand TypeScript patterns
- **NEVER apply personal preferences over documented standards**—your opinion < AGENTS.md

### Next.js App Router
- **NEVER use "use client" unnecessarily**—Server Components are the default, only use Client when you need interactivity
- **NEVER fetch data in Client Components**—use async Server Components or Server Actions
- **NEVER put secrets in NEXT_PUBLIC_ variables**—these are exposed to the browser
- **NEVER use getServerSideProps or getStaticProps**—those are Pages Router, use App Router patterns

### React
- **NEVER omit dependencies from useEffect arrays**—this causes stale closures and bugs
- **NEVER forget to clean up effects**—subscriptions, timers, listeners must be cleaned up
- **NEVER use index as key in lists that reorder**—causes rendering bugs
- **NEVER call hooks conditionally**—they must be called in the same order every render

### TypeScript
- **NEVER use `any` type**—it defeats the purpose of TypeScript. Use `unknown` with type guards instead
- **NEVER skip return types on exported functions**—explicit return types catch errors and improve API clarity
- **NEVER ignore TypeScript errors**—fix them or use proper type guards, don't bypass with `as any`

### Performance
- **NEVER create functions inside render**—they cause unnecessary rerenders. Use useCallback
- **NEVER use useEffect for derived state**—calculate during render instead
- **NEVER forget to implement pagination**—large datasets will crash the browser
- **NEVER use inline styles**—they prevent optimization and reuse. Use CSS classes or styled components

### Security
- **NEVER trust user input**—validate and sanitize before use
- **NEVER put credentials in code**—use environment variables
- **NEVER expose internal errors to users**—they leak implementation details
- **NEVER skip auth checks**—verify permissions on server, not just client

### Testing
- **NEVER test implementation details**—test behavior, not internal state
- **NEVER mock what you own**—only mock external dependencies (APIs, libraries)
- **NEVER use getByTestId as first choice**—prefer getByRole, getByLabelText for accessibility
- **NEVER forget to test error cases**—happy path is not enough

### Monorepo
- **NEVER create circular dependencies**—package A imports B imports A will break builds
- **NEVER duplicate dependencies across packages**—hoist shared deps to root
- **NEVER violate package boundaries**—use public APIs only, not internal imports
- **NEVER skip workspace protocols**—use `workspace:*` for internal package references

## Reference Files

When you need detailed guidance, load these on-demand:

| Scenario | File | When to Load |
|----------|------|--------------|
| First time in project, need AGENTS.md discovery details | `references/project-standards-guide.md` | MANDATORY when reviewing new project |
| Need comprehensive checklists for all categories | `references/review-categories.md` | Complex reviews, unsure what to check |
| Need framework expert patterns and anti-patterns | `references/framework-specifics.md` | Reviewing Next.js/React/TypeScript code |

**Most reviews need only this SKILL.md**—reference files are for deep dives.

## Quick Checklist

Before submitting review:

- [ ] Read AGENTS.md if it exists
- [ ] Checked project standards first (if AGENTS.md found)
- [ ] Security: Input validation, auth, no secrets in code
- [ ] Performance: No unnecessary rerenders, N+1 queries, or missing pagination
- [ ] Maintainability: Type safety, test coverage, clear names
- [ ] Framework: Server vs Client Components, hook rules, proper data fetching
- [ ] Cited AGENTS.md with file path and line numbers (when applicable)
- [ ] Included code examples for suggested fixes
- [ ] Categorized issues by severity (Critical/Important/Minor)
- [ ] Acknowledged what's done well (positive feedback)
