---
name: explain-diff
description: Explain code diffs in Markdown, one changed file at a time. Use when user asks to explain unstaged changes, staged changes, a commit, commit range, branch diff, PR diff, or pasted diff. Ask for diff source when missing.
---

# Explain Diff

Explain what changed in each changed file.

## Flow

1. Use user-provided diff source.
2. If source is missing, use unstaged changes.
3. If unstaged changes are empty, ask for source: staged, commit, range, branch, PR, or pasted diff.
4. Read diff.
5. Read surrounding code only when diff lacks context.
6. Explain every changed file.
7. Mention other files affected by each change.
8. Separate facts from inferred intent.

## Sort Files

Sort by dependency flow:

1. Contracts, API, schemas, types.
2. Data, services, server actions.
3. State, context, hooks, cache.
4. UI, routes, pages, components, styles.
5. Tests, mocks, docs, config.

Within same layer, explain files that clarify other files first.
If still tied, use path order.

## Diff Commands

- Unstaged: `git diff`
- Staged: `git diff --staged`
- Commit: `git show --stat --patch <commit>`
- Range or branch: `git diff <base>...<head>`

## Output

Use `TEMPLATE.md`.
