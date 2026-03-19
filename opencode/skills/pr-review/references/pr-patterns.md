# PR Patterns and Best Practices

Guidelines for effective pull request review, including PR size recommendations, when to split PRs, description best practices, and common anti-patterns by PR type.

## PR Size Guidelines

### Size Categories

**Small PR (<200 lines)**
- **Review time:** 10-20 minutes
- **Ideal for:** Bug fixes, small features, documentation updates
- **Benefits:** Quick to review, easy to understand, fast merge
- **Example:** Fix validation bug in login form (3 files, +45 -23)

**Medium PR (200-500 lines)**
- **Review time:** 30-60 minutes
- **Ideal for:** Standard features, moderate refactoring
- **Benefits:** Thorough review possible, manageable scope
- **Example:** Add user profile page (8 files, +324 -67)

**Large PR (500-1000 lines)**
- **Review time:** 1-2 hours
- **Ideal for:** Complex features, significant refactors (with good reason)
- **Benefits:** Can contain feature when splitting would break coherence
- **Caution:** Requires extra focus, prone to issues being missed
- **Example:** Implement OAuth authentication system (15 files, +789 -234)

**Too Large (>1000 lines)**
- **Review time:** 2+ hours (often incomplete)
- **Problems:** 
  - Very difficult to review thoroughly
  - Higher bug risk (reviewers miss issues)
  - Slower merge cycle (back-and-forth takes longer)
  - Merge conflicts more likely
- **Recommendation:** Split into smaller PRs
- **Exception:** Generated code, migrations, dependency updates

### Visual Size Guide

```
< 200 lines   ████░░░░░░ Small    - Quick review, fast merge
200-500       ███████░░░ Medium   - Standard review
500-1000      █████████░ Large    - Needs focus
> 1000        ██████████ Too Big  - Consider splitting
```

## When to Split vs Keep Together

### Split When:

**1. Multiple Independent Changes**
```
❌ One PR with:
   - Fix authentication bug
   - Add dark mode
   - Update dependencies
   - Refactor API client

✅ Four separate PRs:
   PR #1: Fix authentication bug
   PR #2: Add dark mode support
   PR #3: Update dependencies to latest
   PR #4: Refactor API client for better error handling
```

**2. Feature Can Be Broken Into Incremental Steps**
```
❌ One massive PR: "Build user dashboard"

✅ Sequential PRs:
   PR #1: Add dashboard route and basic layout
   PR #2: Add user stats widget
   PR #3: Add activity feed widget
   PR #4: Add settings panel
```

**3. Some Changes Can Land Independently**
```
Example: Adding a new feature that requires both frontend and backend

✅ Better approach:
   PR #1: Add backend API endpoints (can merge & deploy)
   PR #2: Add frontend UI (depends on #1)
```

**4. Mixing Risky and Safe Changes**
```
❌ One PR with:
   - Safe: Update documentation
   - Risky: Rewrite authentication system

✅ Split:
   PR #1: Update authentication documentation (safe, quick merge)
   PR #2: Rewrite authentication system (needs careful review)
```

### Keep Together When:

**1. Changes Are Tightly Coupled**
```
✅ Keep in one PR:
   - Add new User model
   - Add migrations for User table
   - Update API to use User model
   - Add tests for User functionality

Why? Splitting would create incomplete/broken states.
```

**2. Context Is Lost When Split**
```
✅ Keep together: Refactoring that touches many files but tells one story
   Example: "Rename 'customer' to 'user' throughout codebase"
   - 30 files changed
   - But it's one logical change
   - Splitting would make it harder to review
```

**3. Feature Requires Simultaneous Changes**
```
✅ Keep together: Breaking API change
   - Update API endpoint contract
   - Update all callers
   - Update tests
   
Why? Can't merge partial changes without breaking production.
```

**4. Generated Code or Bulk Updates**
```
✅ Keep together:
   - TypeScript types generated from OpenAPI spec (500 lines)
   - Dependency updates (package.json + lock file)
   - Database migration files
```

## PR Description Best Practices

### Template Structure

```markdown
## What

Brief description of the change (1-2 sentences).

## Why

Explain the motivation:
- What problem does this solve?
- What value does it add?
- Links to issues/tickets

## How

Technical approach:
- Key decisions made
- Any tradeoffs considered
- Alternative approaches rejected

## Testing

How was this tested?
- Unit tests added/updated
- Manual testing performed
- Edge cases covered

## Checklist

- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Breaking changes documented
- [ ] Reviewed my own code
```

### Examples by PR Type

**Bug Fix:**
```markdown
## Fix authentication timeout issue

**What:** Fixed bug where users were logged out after 1 hour instead of 24 hours.

**Why:** Users complained about frequent re-logins. Root cause was token expiry 
set to 3600 seconds instead of 86400 seconds.

**How:** Changed TOKEN_EXPIRY constant in auth.config.ts from 3600 to 86400.

**Testing:**
- Added test for token expiry validation
- Manually verified token persists for 24 hours
- Confirmed existing auth tests still pass

Fixes #456
```

**Feature:**
```markdown
## Add dark mode support

**What:** Implements system-wide dark mode with toggle in user settings.

**Why:** Requested by 45% of users in recent survey (#789). Improves 
accessibility and reduces eye strain.

**How:**
- Added CSS variables for color theming
- Created useTheme hook for theme state
- Implemented theme toggle in settings
- Stored preference in localStorage

**Testing:**
- Unit tests for useTheme hook
- E2E test for theme toggle
- Tested in Chrome, Firefox, Safari
- Verified respects prefers-color-scheme

Closes #789
```

**Refactoring:**
```markdown
## Refactor API client to use axios instead of fetch

**What:** Replaced all fetch() calls with axios for consistency.

**Why:**
- Already using axios in 60% of codebase
- Better error handling with axios interceptors
- Easier request/response transformation
- Built-in timeout support

**How:**
- Created axios instance with default config
- Added interceptors for auth and errors
- Migrated all fetch calls (18 files)
- No API contract changes (pure refactor)

**Testing:**
- All existing API tests pass
- Added tests for interceptors
- Manually tested all API flows

**Migration strategy:** This PR changes implementation but NOT behavior. 
All existing tests pass without modification.
```

## Common Anti-Patterns by PR Type

### Feature PRs

**❌ Anti-Pattern: "While I was here..."**
```
Adding dark mode feature but also:
- Fixing unrelated bugs
- Updating dependencies
- Refactoring components
- Adding new utilities
```
**✅ Fix:** Separate PRs for each concern

**❌ Anti-Pattern: No tests**
```
Adding new feature with zero test coverage
```
**✅ Fix:** Include tests for new functionality

**❌ Anti-Pattern: Breaking changes without migration plan**
```
Changing API contract without:
- Documenting breaking change
- Providing migration guide
- Updating all callers
```
**✅ Fix:** Document breaking changes and provide migration path

### Bug Fix PRs

**❌ Anti-Pattern: No test for the bug**
```
Fixing bug but not adding test to prevent regression
```
**✅ Fix:** Add test that fails before fix, passes after

**❌ Anti-Pattern: Fixing symptoms instead of root cause**
```
Adding null checks everywhere instead of fixing why value is null
```
**✅ Fix:** Debug root cause and fix that

**❌ Anti-Pattern: "Quick fix" with no explanation**
```
Description: "fix"
Code: Changes random timeout value
```
**✅ Fix:** Explain what was broken, why this fixes it

### Refactoring PRs

**❌ Anti-Pattern: Refactoring + behavior changes**
```
PR changes both how code works AND what it does
```
**✅ Fix:** Separate PRs - refactor first, then change behavior

**❌ Anti-Pattern: No before/after comparison**
```
Large refactor with no explanation of improvement
```
**✅ Fix:** Show metrics - bundle size, performance, complexity

**❌ Anti-Pattern: Breaking existing tests**
```
Refactor changes so many internals that all tests need rewriting
```
**✅ Fix:** If tests break, refactor might be changing behavior unintentionally

### Documentation PRs

**❌ Anti-Pattern: Updating docs AFTER feature merges**
```
Feature merged weeks ago, docs PR comes later
```
**✅ Fix:** Include docs in feature PR or open docs PR immediately

**❌ Anti-Pattern: No examples**
```
Documentation explains API but shows no usage examples
```
**✅ Fix:** Include code examples for all public APIs

**❌ Anti-Pattern: Stale docs**
```
Docs describe old behavior that changed
```
**✅ Fix:** Review docs when making changes

### Dependency Update PRs

**❌ Anti-Pattern: Major version bumps with no testing**
```
Updating to next major version without checking breaking changes
```
**✅ Fix:** Read changelog, test thoroughly, note breaking changes

**❌ Anti-Pattern: Updating 20 dependencies at once**
```
One PR updates every dependency
```
**✅ Fix:** Group related deps (React ecosystem, testing tools, etc.)

**❌ Anti-Pattern: No lockfile update**
```
package.json updated but package-lock.json not regenerated
```
**✅ Fix:** Always regenerate lockfiles

## Review Prioritization

When reviewing a PR, check items in this priority order:

### 1. Security (Critical)
- Input validation
- Authentication/authorization
- Secrets management
- XSS/CSRF vulnerabilities
- SQL injection risks

**Stop here if security issues found.**

### 2. Correctness (Critical)
- Does it work as intended?
- Logic errors
- Edge cases handled
- Error handling
- Race conditions

**Stop here if correctness issues found.**

### 3. Tests (High Priority)
- Test coverage adequate?
- Edge cases tested?
- Tests actually validate behavior?
- Tests are maintainable?

### 4. Performance (Medium Priority)
- Unnecessary loops
- N+1 queries
- Memory leaks
- Bundle size impact

### 5. Maintainability (Medium Priority)
- Code clarity
- Naming conventions
- Documentation
- Code duplication
- Complexity

### 6. Style (Low Priority)
- Formatting (should be auto-formatted)
- Naming nitpicks
- Organization preferences

**Note:** Auto-fixable style issues should be caught by linters, not reviewers.

## Handling Stale PRs

**Definition:** PR with no updates for >2 weeks

### Common Causes

1. **Waiting for review** - Reviewer hasn't responded
2. **Waiting for changes** - Author hasn't addressed feedback
3. **Blocked by dependency** - Waiting for another PR
4. **Forgotten** - Both parties moved on

### Resolution Strategies

**If you're the reviewer:**
```
Comment: "This PR has been open for 3 weeks. Status check:
- Is this still needed?
- Should we close and revisit later?
- What's blocking merge?"
```

**If you're the author:**
```
Comment: "Rebasing on main and addressing feedback now. 
Expected to be ready for re-review by [date]."
```

**If PR is no longer needed:**
```
Close with comment: "Closing this PR. [Reason: superseded by #123 / 
no longer needed / different approach chosen]. Thanks for the work!"
```

## Dealing with Unresolved Conversations

### Types of Conversations

**Blocking:** Must be resolved before merge
```
Examples:
- Security vulnerability identified
- Logic error found
- Breaking change not documented
```

**Non-blocking:** Suggestions for improvement
```
Examples:
- "Consider extracting this to a function"
- "This could be more concise"
- "Add a comment explaining this"
```

### Resolution Process

**1. Acknowledge quickly**
```
Author: "Good catch! I'll fix this."
or
Author: "I considered that, here's why I chose this approach: [...]"
```

**2. For disagreements, provide context**
```
Reviewer: "This should use useMemo"
Author: "I profiled this and it's only called once per render with small 
arrays (<10 items), so memoization overhead outweighs benefit."
Reviewer: "Makes sense, resolved."
```

**3. For non-blocking suggestions**
```
Author: "Great idea! I'll address this in a follow-up PR to keep this 
focused on [main goal]. Created issue #456 to track."
```

**4. Don't leave conversations hanging**
```
❌ Reviewer suggests change, author makes change, no one marks resolved
✅ Author: "Done in commit abc123" (marks resolved)
```

## PR Review Etiquette

### As a Reviewer

**DO:**
- ✅ Be respectful and constructive
- ✅ Explain WHY, not just WHAT to change
- ✅ Acknowledge good code
- ✅ Ask questions instead of making demands
- ✅ Distinguish between blocking and non-blocking feedback

**DON'T:**
- ❌ Be condescending ("This is obviously wrong")
- ❌ Nitpick style if linters exist
- ❌ Request changes without explanation
- ❌ Focus only on negatives
- ❌ Let PRs sit for days without response

### As an Author

**DO:**
- ✅ Respond to all feedback
- ✅ Push back respectfully if you disagree
- ✅ Mark conversations resolved
- ✅ Say "good catch" when reviewers find issues
- ✅ Self-review before requesting review

**DON'T:**
- ❌ Take feedback personally
- ❌ Ignore suggestions without explanation
- ❌ Force-push after reviews (loses context)
- ❌ Mark your own unresolved comments as resolved
- ❌ Request review before self-review
