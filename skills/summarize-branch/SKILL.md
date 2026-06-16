---
name: summarize-branch
description: Write a concise PR description from branch commit messages, using `fixes` for fix commits and `implements` otherwise. Use when user needs pull request text, branch summary, or review-ready description from git history. Do not draft commit messages; use conventional-commit.
---

# Summarize Branch

## When to use

- Branch needs PR text.
- Commit history should drive summary.
- User wants a short review-ready description.

## Goal

Create one concise PR paragraph from branch commits.
Use `fixes` when commits indicate a fix.
Use `implements` otherwise.

## Rules

- Use commit messages as source of truth.
- Include user context only when it clarifies intent or scope.
- Keep output short.
- Do not invent changes not shown by commits or context.
- Stop if branch has no commits over base.

## Commands

```bash
git rev-parse --git-dir
git branch --show-current
git log main..HEAD --pretty=format:"%s"
```

## Flow

1. Verify current directory is a git repository.
2. Use `main` as comparison point.
3. Get commits between `main` and `HEAD`.
4. Stop if no branch commits exist.
5. Scan commit messages for `fix`, `fixup`, or `bugfix`.
6. Use `fixes` when fix keywords are found.
7. Otherwise use `implements`.
8. Write one paragraph starting with `This PR ${TYPE}...`.

## Errors

- Not in git repo: report missing repository.
- No branch commits: report nothing to summarize.
- Base branch missing: ask for base branch or use known project default.

## Output

```md
This PR fixes/implements [short summary from commits].
```
