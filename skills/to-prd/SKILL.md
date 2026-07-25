---
name: to-prd
description: Convert a discussion into a concise PRD covering users, the problem, acceptance criteria or requirements, and constraints. Use when the user asks to turn a discussion into a PRD.
---

# Convert Discussion to PRD

- Read the full conversation first.
- Preserve its intent without inventing decisions.
- Write requirements in Given/When/Then format.
- Use only the sections in the template.
- Prefer short bullets.

## Output

```md
# PRD: [Title]

## Users (who)

- [User group]

## Problem (why)

- [Problem]

## Acceptance Criteria / Requirements (what)

- Given [context], when [action], then [outcome].

## Constraints

- [Constraint]
```
