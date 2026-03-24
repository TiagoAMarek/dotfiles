---
name: agents-md-judge
description: Evaluate AGENTS.md quality for project context effectiveness. Use when reviewing or auditing AGENTS.md files to ensure they provide actionable, project-specific guidance without redundancy. Provides scoring across information delta, actionability, enforcement clarity, scope, organization, specificity, and completeness. Includes suggestions for improvement.
license: MIT
compatibility: opencode
---

# AGENTS.md Judge

Evaluate project AGENTS.md files against standards that ensure they deliver genuine project-specific value to the agent.

---

## Core Philosophy

### What is AGENTS.md?

AGENTS.md is **project context externalization** — a file that tells OpenCode agents what's specific and important about *this* codebase.

Unlike SKILL.md (which teaches new general knowledge), AGENTS.md is:

```
SKILL.md: "Here's how to write a good React component design"
AGENTS.md: "In THIS project, we use this specific React pattern"

SKILL.md: General knowledge (applies to all projects)
AGENTS.md: Project-specific knowledge (applies to one project)
```

### The Core Formula

> **Good AGENTS.md = Project-Specific Information − What the Agent Already Knows**

The value is measured by **information delta**:

- **Project-specific knowledge**: Build commands with custom flags, mandatory style rules unique to this codebase, framework patterns specific to the team, critical "NEVER do X in this project" rules
- **What the agent already knows**: Language conventions (PEP 8, ESLint defaults), standard best practices ("write clean code"), framework basics (how React hooks work)

When AGENTS.md explains "what is TypeScript" or "how to write a for-loop", it's wasting the agent's context window. This is **token waste** — the agent's context is shared with your conversation, other skills, and project files.

### Three Types of Information in AGENTS.md

| Type | Definition | Treatment |
|------|------------|-----------|
| **Project-Specific** | Unique to this codebase, agent needs to know | Must keep — this is the file's value |
| **Framework Standard** | Part of the framework's defaults or docs | Keep only if this project deviates from standard |
| **Generic** | Standard best practice in any codebase | Should delete — wastes tokens |

The art of AGENTS.md design is maximizing project-specific content, minimizing generic content.

### Target Length by Project Complexity

| Tier | Examples | Target Lines | Max Lines |
|------|----------|-------------|-----------|
| **Simple** | Single framework, <10k LOC | 20-50 | 100 |
| **Medium** | Monorepo or complex framework | 50-100 | 200 |
| **Complex** | Large monorepo, multiple frameworks | 100-200 | 300 |

A longer file isn't better—it's a sign the content isn't focused enough.

---

## Evaluation Dimensions (100 points total)

### D1: Information Delta (30 points) — THE CORE DIMENSION

Does the AGENTS.md provide genuine project-specific information, or is it rehashing what the agent already knows?

| Score | Criteria |
|-------|----------|
| 0-10 | Mostly generic or framework tutorial content |
| 11-20 | Mix of project-specific and generic, unclear value |
| 21-27 | Mostly project-specific, minimal redundancy |
| 28-30 | Pure project value — every line earns its tokens |

**Red flags** (instant score ≤10):

- "What is [framework/language]" sections
- Explaining language conventions (PEP 8, ESLint rules, TypeScript basics)
- Standard best practices ("write clean code", "handle errors", "use tests")
- Copying rules already in .eslintrc, pyproject.toml, or package.json
- "How to use [standard library/framework]" tutorials

**Green flags** (indicators of high delta):

- Project-specific build commands with non-standard flags
- Mandatory style rules unique to THIS codebase
- Critical "NEVER do X in this project" rules
- Framework usage patterns specific to the team
- Project-specific folder structure or naming conventions
- Tools or processes unique to the team

**Evaluation questions**:

1. For each section, ask: "Does the agent already know this from the framework docs?"
2. Is this explaining a standard, or overriding a standard?
3. Would a new engineer in this project need this information?

---

### D2: Actionability (20 points)

Can the agent immediately apply this guidance without confusion?

| Score | Criteria |
|-------|----------|
| 0-5 | Vague, ambiguous, or requires interpretation |
| 6-15 | Mostly clear, some ambiguity in edge cases |
| 16-19 | Clear and immediately actionable |
| 20 | Precise, with concrete examples |

**Actionable content has**:

- Exact commands with flags: `npm run build -- --production` not "build the project"
- Specific rules: "Always use `const`, never `var`" not "prefer const"
- Concrete examples: Code snippets showing the pattern
- Decision trees: For multi-option scenarios, clear guidance on which to use
- Clear error responses: "If [situation], do [specific action]"

**Example of actionable**:

```markdown
### Build Command
npm run build -- --production --sourcemaps=false

### Code Style
- ALWAYS use const, NEVER use var
- Use camelCase for variables (e.g., userName, isActive)
- NEVER use default exports from utils/
```

**Example of non-actionable**:

```markdown
### Build
Build the project with appropriate settings.

### Code Style
Prefer const over var.
Use clear naming conventions.
Follow standard practices.
```

---

### D3: Enforcement Clarity (15 points)

Are mandatory rules clearly distinguished from preferences?

| Score | Criteria |
|-------|----------|
| 0-5 | No distinction, all recommendations equal weight |
| 6-10 | Some use of emphasis, but inconsistent |
| 11-13 | Clear distinction with mostly consistent language |
| 14-15 | Perfect: MANDATORY/NEVER rules stand out, preferences softened |

**Enforcement language**:

| Level | Keywords | Usage |
|-------|----------|-------|
| **Mandatory** | ALWAYS, NEVER, MUST, DO NOT | Non-negotiable rules |
| **Strong Preference** | Should, avoid, prefer | Important but contextual |
| **Optional** | Consider, typically, usually | Nice-to-have patterns |

**Inconsistent example** (bad):

```markdown
Always use TypeScript.
Prefer functional components.
Don't use var.
Consider adding comments.
Try to keep files small.
```

What's mandatory? What's negotiable? Unclear.

**Consistent example** (good):

```markdown
MANDATORY:
- ALWAYS use TypeScript
- NEVER use var
- DO NOT use default exports

PREFERRED:
- Prefer functional components
- Prefer clear variable names

OPTIONAL:
- Consider adding JSDoc comments
```

---

### D4: Scope Appropriateness (15 points)

Is the file the appropriate length for the project's complexity?

Scoring is **adaptive** — expectations change based on project tier.

| Project Tier | Target | Penalty Zone |
|--------------|--------|------------|
| **Simple** (Single framework, <10k LOC) | 20-50 lines | >100 lines |
| **Medium** (Monorepo or complex setup) | 50-100 lines | >200 lines |
| **Complex** (Large monorepo, multiple frameworks) | 100-200 lines | >300 lines |

| Score | Criteria |
|-------|----------|
| 0-5 | Severely wrong length (stub for complex, encyclopedia for simple) |
| 6-10 | Wrong length (30% over/under) |
| 11-13 | Slightly over or under target, not critical |
| 14-15 | Right length for project complexity |

**How to detect project tier**:

- **Simple**: Single language, one framework (React, Flask, etc.), <10k lines of code
- **Medium**: Monorepo with multiple packages, complex framework setup, or large single codebase (10-100k LOC)
- **Complex**: Large monorepo (multiple services), multiple frameworks in one project, or 100k+ LOC

**The problem zones**:

- **Too short** (<target/2): Missing critical project context
- **Too long** (>max): Becomes reference documentation (wrong purpose), wastes context

---

### D5: Organization (10 points)

Is information logically structured and easy to navigate?

| Score | Criteria |
|-------|----------|
| 0-3 | Chaotic, no clear structure |
| 4-6 | Has structure, but unclear organization |
| 7-8 | Clear sections, minor organization issues |
| 9-10 | Excellent structure, easy to navigate |

**Standard pattern** (recommended):

```markdown
## Build/Test/Lint Commands
npm run build
npm run test
npm run lint

## Code Style
### Variables & Names
(rules here)

### Control Flow
(rules here)

## Project Structure
(structure here)

## Framework-Specific Patterns
(patterns here)
```

**Why this order**:

1. Commands first — agents need these immediately
2. Code style by category — easier to scan
3. Structure overview — context for new work
4. Framework patterns — specific to tech choices

---

### D6: Specificity (5 points)

Does it avoid redundancy with existing configuration and defaults?

| Score | Criteria |
|-------|----------|
| 0-2 | Mostly redundant with config files or framework defaults |
| 3 | Some redundancy but mostly specific content |
| 4 | Mostly specific, minimal redundancy |
| 5 | Pure specificity — nothing redundant |

**What's redundant**:

- Rules already in .eslintrc, .prettierrc, or pyproject.toml
- Language conventions (PEP 8, JavaScript Standard Style)
- Framework documentation (how React hooks work, Django ORM basics)
- Standard library usage

**What's project-specific**:

- "We use these specific flags when building"
- "This project has a unique folder structure"
- "We've chosen to do X instead of the framework default"
- "These tools/packages are forbidden in this project"

**Redundancy check**:

```
grep "const" .eslintrc → If found, don't repeat in AGENTS.md
grep "PEP 8" AGENTS.md → Remove, everyone knows it
"You MUST use TypeScript" + tsconfig.json present → Redundant
```

---

### D7: Completeness (5 points)

Does it have essential project information for the agent to work effectively?

| Score | Criteria |
|-------|----------|
| 0-2 | Missing multiple critical elements |
| 3 | Has most elements, some gaps |
| 4 | All essential elements present, no major gaps |
| 5 | Comprehensive, no missing essentials |

**Essential elements** (checklist):

- [ ] Build command (how to build the project)
- [ ] Test command (how to run tests)
- [ ] Critical code patterns (what's mandatory in this project)
- [ ] No obvious gaps for the project type

**Type-specific essentials**:

| Project Type | Must Have |
|--------------|-----------|
| Node.js | npm/bun commands, TypeScript config |
| Python | test runner, import patterns, type checking |
| Monorepo | workspace structure, build order dependencies |
| Frontend | component patterns, styling approach |
| API | endpoint patterns, error handling standards |

---

## Evaluation Protocol

### Step 1: Project Context Detection

Before scoring, detect the project type:

```
Clues from AGENTS.md location and content:
- package.json present? → Node.js project
- pyproject.toml present? → Python project
- Multiple package.json files? → Monorepo
- Mentions React, Vue, Next.js? → Frontend
- File count / estimated LOC? → Determines complexity tier
```

**Determine complexity tier**:

- Count sections/rules
- Estimate total project size
- Check for monorepo structure
- Assign: Simple / Medium / Complex

---

### Step 2: Information Classification

For each substantial section, classify:

- **[P] Project-Specific**: Unique to this codebase ✓ Keep
- **[F] Framework Standard**: Part of framework defaults (keep only if overridden)
- **[G] Generic**: Standard best practice across all projects ✗ Should remove

**Calculate ratio**:

```
Information Ratio = P / (P + F + G)

Excellent: >80% project-specific
Good: 60-80%
Poor: <60%
```

---

### Step 3: Score Each Dimension

For each of the 7 dimensions:

1. **Find evidence** — Quote relevant lines from AGENTS.md
2. **Assign score** — Use the scoring table
3. **Write justification** — One-line explanation
4. **Note improvements** — If score < max, what's missing?

---

### Step 4: Calculate Total & Grade

```
Total = D1 + D2 + D3 + D4 + D5 + D6 + D7
Max = 100 points

Grade Scale:
- A: 90+ (Excellent, production-ready)
- B: 80-89 (Good, minor improvements needed)
- C: 70-79 (Adequate, clear improvement path)
- D: 60-69 (Below average, significant issues)
- F: <60 (Poor, needs redesign)
```

---

### Step 5: Generate Report

Print to console:

```markdown
# AGENTS.md Evaluation Report

## Summary
- **File**: /path/to/AGENTS.md
- **Project Type**: [Detected type, e.g., "Node.js monorepo"]
- **Complexity Tier**: Simple / Medium / Complex
- **File Length**: X lines (Target: Y-Z for this tier)
- **Information Ratio**: X% project-specific
- **Total Score**: XX/100
- **Grade**: [A/B/C/D/F]

## Dimension Scores

| Dimension | Score | Max | Status |
|-----------|-------|-----|--------|
| D1: Information Delta | XX | 30 | ✓/⚠/✗ |
| D2: Actionability | XX | 20 | ✓/⚠/✗ |
| D3: Enforcement Clarity | XX | 15 | ✓/⚠/✗ |
| D4: Scope Appropriateness | XX | 15 | ✓/⚠/✗ |
| D5: Organization | XX | 10 | ✓/⚠/✗ |
| D6: Specificity | XX | 5 | ✓/⚠/✗ |
| D7: Completeness | XX | 5 | ✓/⚠/✗ |

## Verdict
[One-sentence assessment of overall quality]

## What's Excellent
[Highlight 2-3 sections that provide genuine value]

## Critical Issues (if any)
[Must-fix problems, if present]

## Top 3 Improvements
1. [Highest impact change with specific guidance]
2. [Second priority improvement]
3. [Third priority improvement]

## Detailed Analysis

### Dimension: Information Delta
**Evidence**: [Quote relevant lines]
**Assessment**: [Why this score]
**Improvement**: [What's needed, if score < 28]

### Dimension: Actionability
[Same format]

[Continue for all low-scoring dimensions]
```

---

## NEVER Do When Evaluating

- **NEVER** give high scores because it's "well-formatted" or professional-looking
- **NEVER** ignore redundancy with config files — check .eslintrc, package.json, etc.
- **NEVER** let length impress you — a concise 35-line AGENTS.md can score higher than 150-line one
- **NEVER** score D1 high just because content is good general advice — ask "is this project-specific?"
- **NEVER** allow generic best practices to pass as project-specific content
- **NEVER** forget the adaptive scoring — expectations change based on complexity tier
- **NEVER** assume all procedures are valuable — distinguish project-specific from generic
- **NEVER** skip checking if rules already exist in config files
- **NEVER** give high completeness score if critical commands are missing

---

## Common Failure Patterns

### Pattern 1: The Framework Tutorial

```
Symptom: "React hooks are functions that let you use state in functional components..."
Root Cause: Author assumes agent doesn't know the framework
Fix: Delete all framework basics. Focus on how THIS project uses the framework.
```

### Pattern 2: The Config File Duplicate

```
Symptom: Rules from .eslintrc repeated in AGENTS.md
Root Cause: Author copied linting rules instead of referencing config
Fix: Delete redundant rules. Write: "See .eslintrc for complete linting config"
     Only add project-specific deviations if any
```

### Pattern 3: The Generic Manifesto

```
Symptom: "Write clean code", "Handle errors properly", "Use TypeScript"
Root Cause: Author conflating general software practices with project-specific ones
Fix: Delete all generic advice. Keep only project-unique patterns.
     Example: "This project uses TypeScript strict mode with noImplicitAny"
```

### Pattern 4: The Missing Commands

```
Symptom: "Test your code regularly" with no actual test command
Root Cause: Author wrote principles but skipped procedures
Fix: Add exact commands: "npm run test -- --coverage"
```

### Pattern 5: The Encyclopedia

```
Symptom: 500+ lines covering everything from architecture to deployment
Root Cause: Author treated it like documentation
Fix: Keep only project context. Move reference material to README or /docs.
     AGENTS.md is a context hint, not comprehensive documentation.
```

### Pattern 6: The Vague Enforcement

```
Symptom: Everything is "prefer", "consider", "typically"
Root Cause: Author unsure what's mandatory vs optional
Fix: Use clear enforcement language. "MANDATORY", "prefer", "consider"
```

---

## Quick Reference Checklist

```
INFORMATION DELTA:
[ ] No framework tutorials or basics
[ ] No language convention explanations
[ ] No generic "write good code" advice
[ ] Project-specific patterns present
[ ] Mandatory project rules present

ACTIONABILITY:
[ ] Build/test commands are exact (with flags)
[ ] Code style rules are specific, not vague
[ ] Examples provided where helpful
[ ] Decision trees for multi-option scenarios
[ ] No ambiguous guidance

ENFORCEMENT CLARITY:
[ ] Mandatory rules use ALWAYS/NEVER/MUST
[ ] Preferences use "prefer"/"consider"
[ ] Language is consistent throughout

SCOPE APPROPRIATENESS:
[ ] Length matches project complexity
[ ] Not an encyclopedia
[ ] Not a stub

ORGANIZATION:
[ ] Commands first
[ ] Code style grouped by category
[ ] Clear sections with headers
[ ] Easy to scan

SPECIFICITY:
[ ] No rules already in .eslintrc/.prettierrc
[ ] No language conventions (PEP 8, etc.)
[ ] Only project-specific content

COMPLETENESS:
[ ] Build command present
[ ] Test command present
[ ] Critical code patterns documented
[ ] No obvious gaps for project type
```

---

## The Meta-Question

When evaluating any AGENTS.md, always return to this fundamental question:

> **"Would an engineer new to this project, reading AGENTS.md, say:**
> **'Ah, that's what's specific about THIS codebase'?"**

If yes → the file has genuine value.
If no → it's either generic advice or missing essential context.

The best AGENTS.md files are **project context distilled** — they answer the question "What do I need to know that's unique to this project?" and nothing more.

---

## Self-Evaluation Note

This skill (agents-md-judge) should itself pass evaluation principles:

- **Knowledge Delta**: Provides specific evaluation criteria agents wouldn't generate
- **Actionability**: Clear protocol with concrete steps and report template
- **Enforcement Clarity**: Uses NEVER/should/may appropriately
- **Scope**: Self-contained, no external references needed
- **Organization**: Clear sections, easy to navigate
- **Specificity**: Focused on AGENTS.md evaluation, not generic code review
- **Completeness**: Full protocol included

Use this Skill to evaluate other AGENTS.md files with confidence.
