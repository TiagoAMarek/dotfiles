---
name: pr-review
description: Fetch and analyze GitHub Pull Requests using gh CLI read-only commands. Auto-detects PR from current branch, retrieves metadata, changed files, diffs, CI status, and existing comments. Includes safety gates (CI checks, PR size). Delegates to code-review skill for comprehensive code analysis. Generates structured review report with option to save to file. Use when reviewing GitHub PRs.
license: MIT
compatibility: opencode
requires:
  - gh: "GitHub CLI must be installed and authenticated (https://cli.github.com)"
  - code-review: "code-review skill for code analysis"
keywords:
  - github
  - pull-request
  - pr
  - code-review
  - ci-cd
---

# PR Review

## Core Philosophy

Effective PR review combines context and code quality:

**Context First:**
- Understand the PR's purpose from description
- Check what changed and why
- Review existing feedback to avoid duplication
- Verify CI passes before investing time in deep review

**Safety Gates:**
- Don't review PRs with failing CI (fix CI first)
- Don't review massive PRs without user confirmation (>1000 lines)
- Don't proceed without gh CLI authentication

**Structured Process:**
- Fetch PR data systematically
- Delegate code analysis to code-review skill (don't duplicate logic)
- Generate actionable, structured reports

## When to Use This Skill

**Use pr-review when:**
- Reviewing GitHub PRs (open, closed, or merged)
- Getting comprehensive PR context before diving into code
- Checking CI/CD status across all checks
- Understanding what others have already said in reviews
- Need structured PR review reports to share

**Don't use pr-review when:**
- Reviewing local uncommitted code (use code-review skill directly)
- Repository is not on GitHub (use git commands + code-review skill)
- gh CLI is not available or can't be installed

## Prerequisites Check

Before starting a PR review, verify prerequisites:

### 1. Check gh CLI Installation

```bash
gh --version
```

**If not installed:**
- **macOS:** `brew install gh`
- **Linux:** See https://github.com/cli/cli/blob/trunk/docs/install_linux.md
- **Windows:** `winget install --id GitHub.cli`
- **Manual:** Download from https://cli.github.com

### 2. Check gh Authentication

```bash
gh auth status
```

**If not authenticated:**
```bash
gh auth login
```

Follow prompts to authenticate with GitHub.

### 3. Verify Repository Context

```bash
gh repo view
```

This should display the current repository. If it fails, you're not in a git repository with a GitHub remote.

**If prerequisites fail:**
- Show clear error message with setup instructions
- Link to gh CLI documentation: https://cli.github.com
- STOP (do not proceed with review)

## The PR Review Workflow

### Phase 1: Auto-detect PR (or use specified PR)

**Default: Auto-detect from current branch**
```bash
gh pr view
```

This automatically finds the PR associated with the current branch.

**Alternative: Specify PR**
```bash
gh pr view 123                          # By PR number
gh pr view feature-branch               # By branch name
gh pr view https://github.com/...       # By URL
gh pr view 123 -R owner/repo            # Different repository
```

**Handle errors:**
- If no PR found: "No pull request found for current branch. Create one with `gh pr create` or specify a PR number."
- If PR doesn't exist: "PR #123 not found. Check the number and try again."

### Phase 2: Fetch PR Metadata

```bash
gh pr view --json \
  title,number,url,state,isDraft,\
  author,baseRefName,headRefName,\
  additions,deletions,changedFiles,\
  createdAt,updatedAt,mergedAt,\
  labels,assignees,reviewRequests,\
  body
```

**Extract and format:**
```
📊 PR #123: [Title]
├─ Author: @username
├─ Status: [Open|Closed|Merged] [Draft|Ready]
├─ Branch: feature-branch → main
├─ Size: +234 -56 (3 files changed)
├─ Created: 2024-03-15
├─ Labels: enhancement, needs-review
└─ Assignees: @reviewer1, @reviewer2
```

### Phase 3: Check CI/CD Status (Safety Gate)

```bash
gh pr checks
```

**Parse results:**
- ✅ All checks passed (total: 5/5)
- ⏳ Checks pending (3/5 complete, 2 pending)
- ❌ Checks failing (3/5 passed, 2 failed)

**If checks failing:**
```
⚠️ CI/CD Checks Failing

Failed checks:
- ❌ test-suite: Exit code 1
- ❌ lint: ESLint errors found

Recommendation: Fix failing checks before code review.
Run `gh pr checks [PR] --watch` to monitor check progress.

STOPPING REVIEW. Retry after CI passes.
```

**STOP if required checks fail.** Do not proceed to code review.

### Phase 4: Check PR Size (Safety Gate)

**Calculate total changes:**
```
Total lines changed: additions + deletions
```

**Size categories:**
- Small: <200 lines (quick review)
- Medium: 200-500 lines (standard review)
- Large: 500-1000 lines (thorough review needed)
- Too Large: >1000 lines (consider splitting)

**If >1000 lines:**
```
⚠️ Large PR Detected

This PR changes 1,234 lines across 12 files.

Large PRs are harder to review thoroughly and more likely to contain bugs.

Options:
1. Proceed with full review (may take significant time)
2. Review specific files only
3. Suggest splitting the PR into smaller focused PRs

Proceed with full review? (y/n)
```

**Wait for user confirmation.** If "n", STOP.

### Phase 5: Fetch Changed Files

```bash
gh pr view --json files -q '.files[] | "\(.path) +\(.additions) -\(.deletions) [\(.status)]"'
```

**Organize by type:**
```
📁 Changed Files (12 files, +567 -234)

Modified (8):
├─ src/components/Button.tsx (+45 -12)
├─ src/utils/validation.ts (+23 -5)
├─ src/hooks/useAuth.ts (+34 -18)
└─ ... (show all)

Added (3):
├─ src/components/Button.test.tsx (+166 -0)
├─ src/types/user.ts (+45 -0)
└─ ... (show all)

Deleted (1):
└─ src/legacy/oldButton.tsx (+0 -89)
```

### Phase 6: Fetch Full Diff

```bash
gh pr diff
```

**For large diffs:**
- Store diff for passing to code-review skill
- Don't display entire diff in chat (too verbose)
- Will analyze file-by-file with code-review skill

**Note file priorities:**
- High priority: Core source files (src/core, src/api, src/components)
- Medium priority: Tests, utilities
- Low priority: Config files, docs

### Phase 7: Fetch Existing Reviews & Comments

```bash
# Get reviews and comments summary
gh pr view --json reviews,comments

# Get detailed review comments with file positions
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

**Summarize:**
```
💬 Existing Discussion

Reviews: 3 total
├─ ✅ 2 approvals (@reviewer1, @reviewer2)
└─ 🔄 1 changes requested (@reviewer3)

Comments: 5 total
├─ 2 resolved conversations
└─ 3 unresolved:
    ├─ Button.tsx:45 - "Consider using useMemo here" (@reviewer3)
    ├─ validation.ts:23 - "Add error handling" (@reviewer1)
    └─ useAuth.ts:67 - "Security concern: token exposure" (@reviewer2) ⚠️
```

**Flag critical unresolved comments** (security, breaking changes)

### Phase 8: Present PR Summary

Display comprehensive summary using the Output Format Template (see below).

### Phase 9: Delegate to code-review Skill

Load the code-review skill and provide context:

```markdown
Now loading code-review skill to analyze the changed code...

Context for code-review:
- PR Purpose: [from description]
- Changed Files: [prioritized list]
- Existing Concerns: [unresolved comments to address]
- Size: [small/medium/large]
```

The code-review skill will:
1. Discover AGENTS.md project standards
2. Analyze security, performance, maintainability
3. Check framework-specific patterns (Next.js, React, TypeScript)
4. Generate findings (Critical, Important, Minor, Positive)

### Phase 10: Generate Final Report

Combine:
1. PR context (metadata, size, CI status)
2. Changed files summary
3. Existing discussion summary
4. Code review findings (from code-review skill)
5. Overall recommendation

Use structured Output Format Template below.

### Phase 11: Offer to Save Report

```
📄 Review Complete

[Display report in chat]

Save review to file? 
Suggested filename: pr-{number}-review.md

Options:
- y: Save to suggested filename
- [filename]: Specify custom filename
- n: Don't save (chat only)
```

If user wants to save, write report to file using Write tool.

## PR Context Checklist

Before proceeding with code review, verify:

**Must Have:**
- [ ] PR title clearly describes the change
- [ ] Description explains WHAT and WHY
- [ ] Base branch is correct (main/develop/etc)
- [ ] CI/CD checks are passing
- [ ] No merge conflicts

**Should Have:**
- [ ] PR size is reasonable (<500 lines preferred)
- [ ] Scope is focused (not trying to do too much)
- [ ] Breaking changes are documented
- [ ] Testing approach is documented

**Red Flags (Stop and Address):**
- 🚩 All CI checks failing → Fix CI first
- 🚩 No description or "fix" → Request context
- 🚩 Direct commits to main → Should use branch + PR
- 🚩 Massive PR (>1000 lines) → Suggest splitting
- 🚩 Draft PR marked ready too early → Check if actually ready
- 🚩 "WIP" or "DO NOT MERGE" in title → Why is it ready?

## Common PR Anti-Patterns

### NEVER Accept These

**Scope Creep:**
```
❌ PR includes: bug fix + refactor + new feature + dependency updates
✅ Split into 4 focused PRs
```

**Poor Description:**
```
❌ Description: "fix"
✅ Description: "Fix authentication bug where tokens expired prematurely
   - Changed token expiry from 1h to 24h
   - Added refresh token logic
   - Updated tests
   Fixes #123"
```

**CI/CD Violations:**
```
❌ Disabling tests to make CI pass
❌ Skipping linters: "will fix later"
❌ Ignoring security scan warnings
✅ Fix the root cause, don't silence the alarm
```

**Risky Git Practices:**
```
❌ Force-push after reviews (loses context)
❌ Squashing commits before approval (hard to review iterations)
❌ Committing directly to main/master
✅ Use proper PR workflow with branch protection
```

### WATCH FOR These

**Size Issues:**
- 500-1000 lines: Harder to review thoroughly, but sometimes necessary
- >1000 lines: Strong candidate for splitting
- Single file >300 lines changed: Consider if refactor belongs in separate PR

**Review Process Issues:**
- Multiple unresolved conversations (address feedback first)
- Stale PR (no updates >2 weeks, may have conflicts)
- Many rounds of "Request Changes" (consider pairing/discussion)
- Approvals from PR authors (should recuse themselves)

**Content Red Flags:**
- Commented-out code blocks (remove, don't comment)
- console.log() debugging statements (remove before merge)
- TODO comments without issue tracking (create issue or fix now)
- Hardcoded values that should be config (env vars, constants)

## Output Format Template

Use this structured format for the final PR review report:

```markdown
# PR Review: #{number} - {title}

## 📊 PR Overview

**Metadata:**
- **Author:** @username
- **Status:** Open (Ready for review)
- **Branch:** feature-branch → main
- **Size:** +234 -56 (3 files changed) [Small/Medium/Large]
- **Created:** 2024-03-15 | **Updated:** 2024-03-18
- **Labels:** enhancement, needs-review
- **Assignees:** @reviewer1

**CI/CD Status:** ✅ All 5 checks passed
- ✅ test-suite (3m 24s)
- ✅ lint (45s)
- ✅ type-check (1m 12s)
- ✅ build (2m 45s)
- ✅ security-scan (1m 05s)

**Purpose:**
{From PR description - what and why}

---

## 📁 Changed Files

**Modified ({count}):**
1. `path/to/file.tsx` (+45 -12)
2. `path/to/another.ts` (+23 -5)

**Added ({count}):**
3. `path/to/new.test.tsx` (+166 -0)

**Deleted ({count}):**
4. `path/to/old.tsx` (+0 -89)

---

## 💬 Existing Discussion

**Reviews:** {count} total
- ✅ {count} approvals (@reviewer1, @reviewer2)
- 🔄 {count} changes requested (@reviewer3)

**Comments:** {count} total
- ✅ {count} resolved conversations
- 🔄 {count} unresolved:
  - `file.tsx:45` - "Comment text" (@reviewer)

---

## 🔍 Code Review Analysis

{Findings from code-review skill}

### 🔴 Critical Issues
{From code-review skill}

### 🟡 Important Suggestions
{From code-review skill}

### 🟢 Minor Suggestions
{From code-review skill}

### ✅ Positive Feedback
{From code-review skill}

---

## ✅ Overall Recommendation

**Decision:** [APPROVE | COMMENT | REQUEST CHANGES]

**Summary:**
{Based on code review findings + PR context}

**Action Items:**
1. {Critical items to address}
2. {Important feedback to respond to}
3. {Optional improvements}

**Confidence:** [High|Medium|Low]
{Based on test coverage, CI status, review thoroughness}

---

*Review generated by OpenCode pr-review + code-review skills*
*Generated: {timestamp}*
```

## Error Handling

### gh CLI not installed

```
❌ GitHub CLI (gh) not found

The pr-review skill requires GitHub CLI to fetch PR data.

Install gh CLI:
- macOS: brew install gh
- Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
- Windows: winget install --id GitHub.cli

After installation, run: gh auth login

Documentation: https://cli.github.com

STOPPING REVIEW.
```

### gh CLI not authenticated

```
❌ GitHub CLI not authenticated

Run: gh auth login

Follow the prompts to authenticate with your GitHub account.

STOPPING REVIEW.
```

### No PR found

```
❌ No pull request found for current branch

Create a PR:
  gh pr create

Or specify an existing PR:
  "Review PR #123"
  "Review PR https://github.com/owner/repo/pull/123"

STOPPING REVIEW.
```

### CI checks failing

```
⚠️ CI/CD Checks Failing

{count} checks failed:
- ❌ {check-name}: {failure reason}

View details: gh pr checks --web

Recommendation: Fix CI before code review to avoid reviewing code that will change.

STOPPING REVIEW.
```

### Very large PR

```
⚠️ Large PR: {lines} lines changed

Consider:
1. Splitting into smaller, focused PRs (recommended)
2. Reviewing file-by-file (specify files)
3. Proceeding with full review (may take 15-20 minutes)

Proceed with full review? (y/n)
```

## Reference Files

**Load `references/gh-commands-guide.md` when:**
- Need advanced gh CLI patterns or GraphQL queries
- Troubleshooting gh CLI authentication or errors
- Need to filter/transform JSON output with jq
- Want comprehensive command reference

**Load `references/pr-patterns.md` when:**
- Establishing PR guidelines for a team
- Reviewing complex/large PRs and need best practices
- Teaching PR review methodology
- Need detailed anti-pattern examples
