---
name: user-story-fundamentals
description: Write clear user stories with user, capability, benefit, and testable acceptance criteria. Use when creating or improving backlog items, Given/When/Then criteria, INVEST checks, and user-centered requirements; avoid for roadmap hierarchy, broad requirement audits, or effort sizing.
---

# User Story Fundamentals

## When to use

- Writing backlog items.
- Turning requirements into user-centered work.
- Defining acceptance criteria.
- Splitting oversized product work.

## Goal

Describe who needs what and why.
Make completion testable.

## Story Format

```md
As a [user type],
I want [capability],
so that [benefit].
```

## Rules

- Name a real user or actor.
- Describe capability, not implementation.
- State value in the `so that` clause.
- Add acceptance criteria.
- Keep stories small enough for one sprint.
- Split stories that are too large, vague, or dependency-heavy.
- Separate acceptance criteria from definition of done.

## INVEST Check

- Independent: can be delivered separately.
- Negotiable: details can change.
- Valuable: clear user or business value.
- Estimable: team can size it.
- Small: fits a sprint.
- Testable: clear pass/fail criteria.

## Acceptance Criteria

Use concrete Given/When/Then statements:

```md
Given [context],
when [action],
then [outcome].
```

Cover:

- Happy path.
- Empty or missing data.
- Invalid input.
- Permission or role differences.
- Error states.

## Splitting Methods

- Workflow step.
- User role.
- Data operation: create, read, update, delete.
- Happy path then edge cases.
- Platform or channel.
- Permission level.
- Release slice.

## Resources

- [User Stories Applied - Mike Cohn](https://www.mountaingoatsoftware.com/books/user-stories-applied)
- [User Story Mapping - Jeff Patton](https://www.jpattonassociates.com/user-story-mapping/)
- [Writing Effective User Stories - Scrum Alliance](https://www.scrumalliance.org/)

## Output

```md
As a [user],
I want [capability],
so that [benefit].

- Given [context], when [action], then [outcome].

- Dependencies:
- Non-goals:
- Estimate:
```
