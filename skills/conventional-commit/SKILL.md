---
name: conventional-commit
description: Draft or review Conventional Commits messages with type, optional scope, imperative summary, body, footer, and breaking-change notes. Use when user asks for a commit message, commit title and body, changelog-safe wording, or commit-format review. Do not use for PR descriptions; use summarize-branch.
---

# Conventional Commits

Write machine-readable commit messages.

## When to Use

- Drafting commit messages.
- Reviewing commit message quality.
- Preparing release notes or changelogs.
- Creating consistent team conventions.

## Goal

Use Conventional Commits format.
Make intent clear.
Support automated tooling.

## Format

```text
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

## Types

- `feat`: new feature.
- `fix`: bug fix.
- `docs`: documentation only.
- `style`: formatting or code style only.
- `refactor`: code change without feature or bug fix.
- `perf`: performance improvement.
- `test`: tests added or changed.
- `build`: build system or dependency change.
- `ci`: CI change.
- `chore`: maintenance.
- `revert`: revert previous commit.

## Header Rules

- Use imperative present tense: `add`, not `added` or `adds`.
- Start description lowercase.
- Do not end with a period.
- Keep concise.
- Add scope only when useful: `fix(auth): remove stale token`.

## Body and Footer Rules

- Use body when context matters.
- Explain what and why.
- Use bullets for multiple changes.
- Wrap lines around 72 characters.
- Use `BREAKING CHANGE: ...` for breaking changes.
- Reference issues when useful: `Closes #123`.

```text
feat(ui): add dark mode toggle

fix(auth): remove blocking overlay on login button

- adjust overlay z-index so it sits behind the button
- keep pointer events available for the login CTA

feat(api): migrate to REST v2 endpoints

BREAKING CHANGE: All API endpoints are now prefixed with /api/v2.
```

## Output

```md
## Commit Message
[message]

## Notes
- Type: [type]
- Scope: [scope or none]
- Breaking change: [yes/no]
```
