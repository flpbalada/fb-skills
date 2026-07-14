---
name: explain-yesterday-changes
description: Explain changes made yesterday as a simple list. Use when user asks what changed yesterday, what was implemented yesterday, or needs a non-technical change summary from recent git work.
---

# Explain Yesterday Changes

Summarize yesterday's work.

## Goal

Return a simple list of what changed or was implemented.
Avoid developer-only details.

## Flow

1. Verify current directory is a git repository.
2. If today is Monday, ask the user whether to use Friday instead of yesterday.
3. Inspect commits from the target day using local git history.
4. If commits are missing or unclear, inspect diffs for files changed on the target day when available.
5. Group related changes into user-visible outcomes.
6. Translate technical changes into editor/admin language.
7. Mention uncertainty when git history cannot prove the change.

## Commands

```bash
git rev-parse --git-dir
git log --since="yesterday 00:00" --until="today 00:00" --stat --oneline
git log --since="yesterday 00:00" --until="today 00:00" --patch
git log --since="last friday 00:00" --until="last saturday 00:00" --stat --oneline
git log --since="last friday 00:00" --until="last saturday 00:00" --patch
```

## Rules

- Keep output short.
- Use plain language.
- Focus on screens, content, settings, workflows, permissions, publishing, data, and admin actions.
- Do not list internal refactors, dependency bumps, linting, or formatting unless they changed editor/admin behavior.
- Do not invent intent beyond commits or diffs.
- If today is Monday, do not inspect Sunday by default; ask first whether the user means Friday.
- If there were no commits on the target day, say no committed changes found.

## Output

Use `EXAMPLES.md` as style reference.

```md
- [Changed or implemented editor/admin-facing outcome]
- [Changed or implemented editor/admin-facing outcome]
```
