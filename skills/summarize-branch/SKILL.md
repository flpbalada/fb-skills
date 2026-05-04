---
name: summarize-branch
description: Generate a concise PR description from branch commits. Use when a branch needs a clear summary for review or pull request text.
---

# Summarize Branch

Create a clear, concise PR description by analyzing the branch commit history.

## What You Get

A short, well-structured paragraph that describes the changes and determines whether they fix or implement something based on commit messages.

## Optional Context

Use any extra user-provided context when:

- Commits do not tell the full story.
- Specific aspects should be highlighted.
- Intent or scope needs clarification.

## Prerequisites

Run these checks:

```bash
git rev-parse --git-dir
git branch --show-current
git log main..HEAD --pretty=format:"%s"
```

## Process

1. Verify the current directory is a git repository.
2. Use `main` as the comparison point.
3. Get all commit messages between `main` and `HEAD`.
4. Exit if no branch commits exist.
5. Detect change type by scanning for fix keywords such as `fix`, `fixup`, and `bugfix`.
6. Use `fixes` when fix keywords are found; otherwise use `implements`.
7. Generate a paragraph starting with `This PR ${TYPE}...`.
8. Incorporate optional user context when provided.

## Error Handling

| Error | What It Means |
| ----- | ------------- |
| Not in git repo | Run from within a git repository |
| No commits on branch | Make at least one commit before summarizing |
| Base branch not found | Ensure `main` branch exists or choose another base |
