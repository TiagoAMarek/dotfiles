# Project Standards Guide

This guide provides detailed instructions for discovering and interpreting project-specific standards from AGENTS.md files.

## Discovery Workflow

### Step 1: Locate AGENTS.md Files

Search in priority order:

**1. Project-specific OpenCode config:**
```bash
ls .opencode/AGENTS.md 2>/dev/null
```

**2. Root-level project standards:**
```bash
ls AGENTS.md 2>/dev/null
```

**3. Package-specific (monorepos):**
```bash
find packages -name "AGENTS.md" -type f 2>/dev/null
```

**4. Broader search if needed:**
```bash
find . -name "AGENTS.md" -type f -maxdepth 3 2>/dev/null | head -20
```

### Step 2: Read ALL Discovered Files

For each AGENTS.md file found:

**1. Read the complete file:**
```bash
cat .opencode/AGENTS.md
cat AGENTS.md
cat packages/ui/AGENTS.md
```

**2. Record metadata:**
- File path (for citations)
- Line count
- Scope (root-level vs package-specific)

**3. Extract critical information:**
- NEVER/ALWAYS/MUST rules (non-negotiable)
- SHOULD/IMPORTANT/RECOMMENDED guidelines (strong suggestions)
- PREFER/CONSIDER/OPTIONAL preferences (nice-to-have)
- Common anti-patterns to avoid
- Tech stack details (frameworks, versions)
- Testing requirements
- Build/lint/test commands

## Severity Parsing

### Keyword-Based Classification

**🔴 Critical (MUST fix before merge):**

Keywords: `NEVER`, `ALWAYS`, `MUST`, `REQUIRED`, `CRITICAL`, `DO NOT`

Examples:
```markdown
NEVER use `any` type in TypeScript
ALWAYS use named exports
CRITICAL: Verify accessibility compliance
DO NOT commit .env files
```

These are non-negotiable standards. Violations should be reported as Critical Issues (🔴).

**🟡 Important (SHOULD fix):**

Keywords: `SHOULD`, `IMPORTANT`, `RECOMMENDED`, `AVOID`, `DO NOT USE`

Examples:
```markdown
SHOULD use Server Components by default
IMPORTANT: Add tests for new features
RECOMMENDED: Use Result<T> for error handling
AVOID inline styles
```

These should be followed in most cases. Deviations should be reported as Important Suggestions (🟡).

**🟢 Minor (Nice to have):**

Keywords: `PREFER`, `CONSIDER`, `OPTIONAL`, `TRY`, `COULD`, `MIGHT`

Examples:
```markdown
PREFER interfaces over type aliases
CONSIDER adding error boundaries
OPTIONAL: Add JSDoc comments
TRY to keep components under 200 lines
```

These are guidance and suggestions. Report as Minor Suggestions (🟢).

### Context Matters

Look at surrounding context, not just keywords:

```markdown
❌ "You SHOULD NEVER use `any` type"
   → This is CRITICAL, not just "should"

✅ "You should prefer `const` over `let` when possible"
   → This is Minor, keyword alone doesn't determine severity
```

## Monorepo Handling

### Rule Merging Strategy

When multiple AGENTS.md files are found:

**1. Root AGENTS.md**: General project-wide standards
- Applied to all packages
- Lower specificity

**2. Package AGENTS.md**: Package-specific overrides and additions
- Applied only to that package
- Higher specificity

**Conflict Resolution**: Package-specific rules override general root rules when there's a conflict.

### Example: Turborepo Monorepo

```
Project structure:
/cx-monorepo/
├── AGENTS.md (342 lines)
├── packages/
│   ├── ui/
│   │   ├── AGENTS.md (741 lines)
│   │   └── src/Button.tsx
│   └── api/
│       ├── AGENTS.md (234 lines)
│       └── src/routes.ts
```

**Reviewing `/cx-monorepo/packages/ui/src/Button.tsx`:**

1. Read `/cx-monorepo/AGENTS.md` (root standards)
   - General TypeScript rules
   - Testing patterns
   - Import ordering
   - Basic component rules

2. Read `/cx-monorepo/packages/ui/AGENTS.md` (package standards)
   - Radix UI component patterns
   - Design system usage
   - Accessibility requirements
   - UI component conventions

3. Apply both sets of rules:
   - If root says "Use Server Components by default"
   - And UI package says "Client Components for interactive UI with Radix"
   - Both apply (no conflict - they're complementary)

4. Resolve conflicts:
   - If root says "Use interfaces for types"
   - And UI package says "Use type for React component props"
   - UI package rule takes precedence for Button.tsx

### Determining Package Scope

**Identify which package you're reviewing:**
```bash
# Get package name from file path
echo "/cx-monorepo/packages/ui/src/Button.tsx" | grep -oP 'packages/\K[^/]+'
# Output: ui

# Find package-specific AGENTS.md
ls packages/ui/AGENTS.md 2>/dev/null
```

**In your review output:**
```markdown
### 📚 Project Context

**AGENTS.md files found**:
1. `/cx-monorepo/AGENTS.md` (342 lines) - Root project standards
2. `/cx-monorepo/packages/ui/AGENTS.md` (741 lines) - UI library specific

**Package Context**: UI Library (`packages/ui`)
- Must follow Atomic Design patterns
- All components require Storybook documentation
- Accessibility (WCAG AA) is mandatory
```

## Fallback: No AGENTS.md Found

When no AGENTS.md files exist, detect tech stack from project files:

### 1. Read package.json

```bash
cat package.json
```

**Look for:**
- Framework: `"next"`, `"react"`, `"vue"`, `"express"`, etc.
- Monorepo indicators: `"workspaces"`, `"turbo"`, `"nx"`
- Key dependencies and versions
- Scripts that reveal build tools

### 2. Check Framework Config Files

```bash
ls next.config.js next.config.ts 2>/dev/null    # Next.js
ls nuxt.config.ts 2>/dev/null                   # Nuxt
ls vite.config.ts vite.config.js 2>/dev/null    # Vite
cat tsconfig.json                                # TypeScript
```

### 3. Analyze Code Imports

Look at the code being reviewed:

```typescript
// Indicators:
import { useState } from 'react'              // React
import type { NextPage } from 'next'          // Next.js
'use client'                                  // Next.js App Router
import { defineComponent } from 'vue'         // Vue
```

### 4. Apply General Best Practices

Without AGENTS.md, apply framework-specific and industry-standard best practices:
- OWASP security standards
- WCAG accessibility guidelines
- Framework official documentation patterns
- Language best practices (TypeScript strict mode, etc.)

**In your review output:**
```markdown
### 📚 Project Context

**Fallback note**: No AGENTS.md found. Detected Next.js 14+ with TypeScript 5+ project based on package.json and imports. Applied Next.js App Router best practices and TypeScript strict mode patterns.
```

## Citation Format

When referencing AGENTS.md in reviews, always cite properly:

### Format

```markdown
📖 AGENTS.md Reference (filepath:line):
> [Direct quote from AGENTS.md showing the rule]

Explanation: [Why this rule exists in the project]
```

### Example

```markdown
⚠️ Type Safety: Using `any` type

The `handleSubmit` function parameter uses `data: any`, which bypasses TypeScript type checking and violates the project's strict type safety standards.

📖 AGENTS.md Reference (.opencode/AGENTS.md:124):
> NEVER use `any` type. If you're unsure of a type, use `unknown` with type guards, or define a proper interface. Using `any` defeats the purpose of TypeScript and can hide bugs.

✅ Suggested Fix:
```typescript
// Define a proper interface instead
interface FormData {
  username: string;
  email: string;
}

// Use the interface
const handleSubmit = (data: FormData) => {
  console.log(data.username, data.email);
};
```
```

### Finding Line Numbers

If you need to cite a specific rule but don't have line numbers:

```bash
# Find line number for a specific rule
grep -n "NEVER use \`any\` type" AGENTS.md
# Output: 124:NEVER use `any` type. If you're unsure...
```

## Edge Cases

### Multiple Projects in Same Directory

```bash
# You might find:
./project-a/AGENTS.md
./project-b/AGENTS.md
./shared/AGENTS.md
```

**Solution**: Determine which project the file being reviewed belongs to based on path, then only apply that project's AGENTS.md.

### Conflicting Rules in Same File

```markdown
# In AGENTS.md:
ALWAYS use named exports.
...
(500 lines later)
...
For utility functions, default exports are acceptable.
```

**Solution**: Later rules refine earlier rules. Apply the most specific rule. In reviews, cite both and explain the nuance.

### AGENTS.md References Another File

```markdown
# In AGENTS.md:
For TypeScript conventions, see TYPESCRIPT_STYLE.md
```

**Solution**: Read the referenced file as well. Treat it as an extension of AGENTS.md and cite it appropriately.

### Package-Specific Rule Conflicts with Root

```markdown
# Root AGENTS.md:
NEVER use default exports.

# packages/ui/AGENTS.md:
Default exports are required for UI components to support tree-shaking.
```

**Solution**: Package-specific rule wins for files in that package. In your review, explain the override:

```markdown
Note: While root AGENTS.md prohibits default exports, packages/ui/AGENTS.md explicitly requires them for UI components due to tree-shaking requirements.
```

## Quick Reference

**Discovery commands:**
```bash
ls .opencode/AGENTS.md AGENTS.md 2>/dev/null
find packages -name "AGENTS.md" -type f 2>/dev/null
```

**Severity keywords:**
- Critical: NEVER, ALWAYS, MUST, REQUIRED, CRITICAL
- Important: SHOULD, IMPORTANT, RECOMMENDED, AVOID
- Minor: PREFER, CONSIDER, OPTIONAL, TRY

**Monorepo rule**: Package-specific overrides root

**Fallback**: Read package.json, detect framework, apply best practices

**Citation format**: filepath:line with direct quote
