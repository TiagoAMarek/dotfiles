# GitHub CLI Commands Guide

Complete reference for gh CLI commands used in PR review workflows. This guide covers read-only operations for fetching PR data, CI status, and review information.

## Complete gh pr Command Reference

### Viewing PRs

**Basic view:**
```bash
gh pr view                    # Current branch PR
gh pr view 123               # By PR number
gh pr view feature-branch    # By branch name
gh pr view https://...       # By URL
```

**View in browser:**
```bash
gh pr view --web
gh pr view 123 --web
```

**View with comments:**
```bash
gh pr view --comments        # Include comment threads
```

### Listing PRs

```bash
gh pr list                   # All open PRs in current repo
gh pr list --state closed    # Closed PRs
gh pr list --state merged    # Merged PRs
gh pr list --state all       # All PRs
gh pr list --author @me      # Your PRs
gh pr list --assignee @me    # Assigned to you
gh pr list --label bug       # With specific label
gh pr list --limit 50        # Limit results
```

### PR Status

```bash
gh pr status                 # PRs relevant to you
                            # - Your PRs
                            # - PRs requesting your review
                            # - PRs mentioning you
```

### Viewing Diffs

```bash
gh pr diff                   # Full diff for current branch PR
gh pr diff 123              # Diff for specific PR
gh pr diff --name-only      # Only show changed file names
gh pr diff --patch          # Patch format
gh pr diff --color=always   # Force color output
```

### Checking CI Status

```bash
gh pr checks                 # All checks for current PR
gh pr checks 123            # Checks for specific PR
gh pr checks --required     # Only required checks
gh pr checks --watch        # Watch until complete
gh pr checks --web          # Open checks in browser
```

### Cross-Repository Operations

```bash
gh pr view 123 -R owner/repo           # Different repo
gh pr list -R owner/repo               # List PRs in repo
gh pr checks 123 -R owner/repo         # Check CI in repo
```

## JSON Field Reference

All available fields for `gh pr view --json`:

### Metadata Fields

```bash
gh pr view --json \
  title,              # PR title
  number,             # PR number
  url,                # PR URL
  state,              # open, closed, merged
  isDraft,            # true/false
  author,             # Author info {login, name}
  baseRefName,        # Base branch (e.g., main)
  headRefName,        # Head branch (e.g., feature-branch)
  repository,         # Repo info {name, owner}
  createdAt,          # ISO timestamp
  updatedAt,          # ISO timestamp
  closedAt,           # ISO timestamp (if closed)
  mergedAt,           # ISO timestamp (if merged)
  mergedBy            # User who merged {login, name}
```

### Change Statistics

```bash
gh pr view --json \
  additions,          # Lines added
  deletions,          # Lines deleted
  changedFiles,       # Number of files changed
  files               # Array of file objects
```

### Review & Discussion

```bash
gh pr view --json \
  reviews,            # Array of review objects
  comments,           # Array of comment objects
  reviewRequests,     # Pending review requests
  latestReviews,      # Latest review from each reviewer
  reviewDecision      # APPROVED, CHANGES_REQUESTED, etc
```

### PR Attributes

```bash
gh pr view --json \
  labels,             # Array of label objects
  assignees,          # Array of assigned users
  milestone,          # Milestone object
  projectCards,       # Project board cards
  body,               # PR description
  statusCheckRollup   # All status checks
```

### Advanced Fields

```bash
gh pr view --json \
  isCrossRepository,  # PR from fork?
  maintainerCanModify,# Maintainer can edit?
  mergeable,          # MERGEABLE, CONFLICTING, UNKNOWN
  mergeStateStatus,   # Detailed merge status
  commits             # Array of commit objects
```

## jq Filtering Examples

### Extract Specific Data

**Get just file paths:**
```bash
gh pr view --json files -q '.files[].path'
```

**Get files with changes:**
```bash
gh pr view --json files -q '.files[] | "\(.path) +\(.additions) -\(.deletions)"'
```

**Get failing checks:**
```bash
gh pr checks --json | jq '.[] | select(.state != "SUCCESS") | {name, conclusion}'
```

**Count unresolved comments:**
```bash
gh pr view --json comments -q '[.comments[] | select(.isResolved == false)] | length'
```

**Get review status summary:**
```bash
gh pr view --json reviews -q '
  group_by(.state) | 
  map({state: .[0].state, count: length}) | 
  from_entries
'
```

**List approvers:**
```bash
gh pr view --json reviews -q '
  [.reviews[] | select(.state == "APPROVED") | .author.login] | 
  unique
'
```

### Complex Queries

**Get large files (>100 lines changed):**
```bash
gh pr view --json files -q '
  .files[] | 
  select((.additions + .deletions) > 100) | 
  {path, changes: (.additions + .deletions)}
'
```

**Get unresolved security comments:**
```bash
gh pr view --json comments -q '
  .comments[] | 
  select(.isResolved == false and (.body | contains("security"))) |
  {file: .path, line: .line, body: .body, author: .author.login}
'
```

**Check if PR is ready to merge:**
```bash
gh pr view --json isDraft,mergeable,reviewDecision -q '
  if .isDraft then "Draft - not ready"
  elif .mergeable != "MERGEABLE" then "Has conflicts"
  elif .reviewDecision != "APPROVED" then "Needs approval"
  else "Ready to merge"
  end
'
```

## Using gh api for Advanced Queries

The `gh api` command provides direct access to GitHub REST API and GraphQL.

### REST API Examples

**Get PR files with full details:**
```bash
gh api repos/{owner}/{repo}/pulls/{number}/files
```

**Get review comments with line positions:**
```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

**Get specific file content from PR:**
```bash
gh api repos/{owner}/{repo}/pulls/{number}/files \
  --jq '.[] | select(.filename == "src/App.tsx") | .patch'
```

**Get PR timeline events:**
```bash
gh api repos/{owner}/{repo}/issues/{number}/timeline
```

### GraphQL Examples

**Custom PR query:**
```bash
gh api graphql -f query='
  query($owner: String!, $repo: String!, $number: Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        title
        author { login }
        reviews(first: 10) {
          nodes {
            author { login }
            state
            body
          }
        }
      }
    }
  }
' -f owner=OWNER -f repo=REPO -F number=123
```

**Get PR with commit details:**
```bash
gh api graphql -f query='
  query($owner: String!, $repo: String!, $number: Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        commits(first: 100) {
          nodes {
            commit {
              message
              additions
              deletions
              changedFiles
            }
          }
        }
      }
    }
  }
' -f owner=OWNER -f repo=REPO -F number=123
```

## Handling Edge Cases

### Draft PRs

Draft PRs may not have all checks running or may not be ready for review.

**Check if draft:**
```bash
gh pr view --json isDraft -q '.isDraft'
```

**Handle in workflow:**
```bash
if gh pr view --json isDraft -q '.isDraft' | grep -q true; then
  echo "⚠️ This is a draft PR - may not be ready for review"
fi
```

### Closed/Merged PRs

**Check PR state:**
```bash
gh pr view --json state,mergedAt -q 'if .state == "MERGED" then "Merged" elif .state == "CLOSED" then "Closed without merge" else "Open" end'
```

**Get merge information:**
```bash
gh pr view --json mergedAt,mergedBy -q 'if .mergedAt then "Merged by \(.mergedBy.login) at \(.mergedAt)" else "Not merged" end'
```

### Cross-Repository PRs (Forks)

PRs from forks have different permissions and behaviors.

**Check if from fork:**
```bash
gh pr view --json isCrossRepository -q '.isCrossRepository'
```

**Handle fork PRs:**
```bash
if gh pr view --json isCrossRepository -q '.isCrossRepository' | grep -q true; then
  echo "Note: This PR is from a fork - some operations may be restricted"
fi
```

### Large PRs with Pagination

For PRs with many files or comments, you may need pagination.

**Get all files (paginated):**
```bash
gh api repos/{owner}/{repo}/pulls/{number}/files \
  --paginate \
  --jq '.[] | .filename'
```

**Get all comments (paginated):**
```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments \
  --paginate \
  --jq '.[] | {file: .path, body: .body}'
```

## Troubleshooting

### Authentication Issues

**Error: "gh: To get started with GitHub CLI, please run: gh auth login"**

Solution:
```bash
gh auth login
```

Follow prompts to authenticate. Choose HTTPS or SSH, and authorize.

**Error: "HTTP 401: Bad credentials"**

Solution: Re-authenticate
```bash
gh auth logout
gh auth login
```

**Check current auth status:**
```bash
gh auth status
```

### Repository Access Issues

**Error: "GraphQL: Could not resolve to a Repository"**

Causes:
- Repository doesn't exist
- You don't have access
- Repository name is misspelled

Solution: Verify repository and your access
```bash
gh repo view owner/repo
```

**Error: "HTTP 404: Not Found"**

The PR number doesn't exist. Verify with:
```bash
gh pr list -R owner/repo
```

### Rate Limiting

**Error: "API rate limit exceeded"**

GitHub has rate limits (5000 requests/hour for authenticated users).

Check rate limit status:
```bash
gh api rate_limit
```

Solution: Wait for rate limit reset or authenticate if you weren't.

### JSON Parsing Errors

**Error: "parse error: Invalid numeric literal"**

Cause: jq syntax error or invalid JSON from gh

Solutions:
- Test jq filter separately: `echo '{"test": 1}' | jq '.test'`
- Validate JSON output: `gh pr view --json title | jq .`
- Check field names: Some fields may be null

### Command Not Found

**Error: "command not found: gh"**

Solution: Install gh CLI (see Prerequisites section)

**Verify installation:**
```bash
which gh
gh --version
```

## Performance Tips

**Fetch only needed fields:**
```bash
# Slow (fetches everything):
gh pr view --json

# Fast (fetches only what's needed):
gh pr view --json title,number,state
```

**Use jq for filtering instead of fetching all:**
```bash
# Better: Filter with jq
gh pr view --json files -q '.files[] | select(.additions > 50)'

# Worse: Fetch all then filter in bash
gh pr view --json files | jq ... (then multiple bash commands)
```

**Cache PR metadata:**
If reviewing same PR multiple times, store metadata:
```bash
PR_DATA=$(gh pr view --json title,author,files)
# Reuse $PR_DATA instead of fetching again
```

## Command Combinations

**Full PR context in one command:**
```bash
gh pr view --json \
  title,number,author,state,isDraft,\
  baseRefName,headRefName,additions,deletions,\
  reviews,comments,labels,statusCheckRollup
```

**Quick PR health check:**
```bash
echo "PR: $(gh pr view --json number,title -q '"\(.number): \(.title)"')"
echo "State: $(gh pr view --json state,isDraft -q 'if .isDraft then "Draft" else .state end')"
echo "Size: $(gh pr view --json additions,deletions -q '"+\(.additions) -\(.deletions)"')"
echo "CI: $(gh pr checks | grep -c "pass") passed"
```

**Find PRs needing review:**
```bash
gh pr list --search "review-requested:@me is:open"
```

**Find stale PRs:**
```bash
gh pr list --search "is:open updated:<2024-01-01"
```
