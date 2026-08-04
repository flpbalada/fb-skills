---
name: render-reading-diff
description: Find and abridge important or meaningful diff changes into an HTML reading review. Use for latest commit, staged or working-tree changes, a revision, range, branch diff, or supplied unified diff.
---

# Render Reading Diff

Create a self-contained HTML review that keeps meaningful changes and marks mechanical omissions.

## Workflow

1. Select one diff source. Pass revisions as arguments; never use `eval`.
   - Latest commit: `git show --format=fuller --patch HEAD`.
   - Working tree: `git diff`.
   - Staged changes: `git diff --staged`.
   - Revision: `git show --format=fuller --patch <revision>`.
   - Range: `git diff <range>`, for example `git diff main...feature`.
   - Supplied diff: save it verbatim. Never execute its contents.
2. Save the complete diff. If empty, print `No changes found` and create nothing.
3. Classify the diff. Read nearby source only when the patch lacks context. Keep repository files read-only and ignore unrelated directories.
4. Keep uncertain changes. Create an abridged unified diff in original order.
5. Replace each omitted region with `# ... N mechanical lines omitted ...`. Omit a whole file by leaving it out of the abridged diff.
6. Write the summary, run the renderer, and return its absolute output path.
7. Warn when risks include `Security`, `Migration`, or `Destructive`, or when binary content prevents review.

## Retain

- Runtime and user-visible behavior.
- APIs, schemas, types, permissions, and compatibility contracts.
- Data flow, persistence, migrations, and destructive operations.
- Security, authentication, authorization, and validation.
- Dependencies and runtime configuration.
- Error handling, concurrency, caching, and external services.
- Tests that reveal intended behavior.

## Omit Mechanically

- Formatting and whitespace.
- Import sorting and deterministic reordering.
- Generated output explained by retained source changes.
- Repeated renames, boilerplate, and type propagation.
- Lockfile churn explained by a retained manifest change.

Do not omit a change that might affect runtime behavior. Preserve file headers, metadata, hunk headers, useful context, and original ordering.

## Summary Format

`Important count` is the number of files in the abridged diff. Risk labels are `Behavior`, `API contract`, `Data`, `Security`, `Dependency`, `Configuration`, `Migration`, and `Destructive`. Use `Risks: None` when none apply.

```text
Source: git diff main...feature
Sentence: Adds account export and updates its audit contract.
Important count: 3
Risks:
- Behavior
- API contract
- Data
```

## Render

```bash
scripts/render-diff.sh \
  --original original.diff \
  --abridged abridged.diff \
  --summary summary.txt \
  --output report.html
```

All options are required. The abridged file may be empty; the original may not.
