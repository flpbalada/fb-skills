---
name: code-architecture-wrong-abstraction
description: Guides when to abstract vs duplicate code. Use this skill when creating shared utilities, deciding between DRY/WET approaches, or refactoring existing abstractions.
---

# Avoid Wrong Abstractions

Prefer duplication over wrong abstraction.
Wait for real patterns.

## When to Use

- Creating shared utilities or components.
- Deciding whether duplication is acceptable.
- Reviewing a bloated helper or facade.
- Refactoring code with many options, flags, or conditionals.

## Goal

Keep code easy to change.
Use abstractions only when they reduce real complexity.

## Rules

- Do not abstract before 3 real uses unless there is strong domain reason.
- Similar shape is not enough; behavior must match.
- Prefer clear duplication over parameter-heavy helpers.
- Avoid abstractions that need new flags for every caller.
- Inline bad abstractions before designing new ones.
- Test concrete behavior, not abstraction cleverness.

## Abstract When

- Same behavior appears in 3+ places.
- Requirements are stable.
- Callers need the same change together.
- Name and API are obvious.
- Abstraction removes more complexity than it adds.

## Do Not Abstract When

- There are only 1-2 uses.
- Requirements are still changing.
- Callers need different behavior.
- API needs many optional parameters.
- Junior developers must learn the wrapper and the underlying tool.
- Manual edits across files would be simpler.

## Facade Rule

Use a facade when it hides real complexity or enforces a useful constraint.

Good facade examples:

- Date picker hiding calendar, localization, keyboard, and accessibility logic.
- Button enforcing design system variants.

Skip facades for simple HTML or one-off styling.

## Fixing Wrong Abstractions

1. Inline the abstraction into each caller.
2. Delete unused branches in each caller.
3. Keep temporary duplication.
4. Compare current use cases.
5. Re-extract only stable shared behavior.

## Review Questions

- What are the actual callers?
- Do they change for the same reason?
- Which parameters exist only to satisfy one caller?
- Would duplication be clearer?
- Can we delete the abstraction and make code easier?

## References

- [The Wrong Abstraction - Sandi Metz](https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction)
- [The Wet Codebase - Dan Abramov](https://www.deconstructconf.com/2019/dan-abramov-the-wet-codebase)
- [AHA Programming - Kent C. Dodds](https://kentcdodds.com/blog/aha-programming)

## Output

```md
## Abstraction Review
- Decision: [keep/duplicate/inline/re-extract]
- Evidence: [callers and behavior]
- Risk: [coupling, churn, or none]
- Change: [smallest safe next step]
```
