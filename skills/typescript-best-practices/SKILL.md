---
name: typescript-best-practices
description: Guides TypeScript best practices for type safety, code organization, and maintainability. Use this skill when configuring TypeScript projects, deciding on typing strategies, writing async code, or reviewing TypeScript code quality.
---

# TypeScript Best Practices

## When to use

- Reviewing TypeScript code quality.
- Choosing typing strategy.
- Configuring strictness.
- Writing async or error-handling code.
- Refactoring unsafe or hard-to-read types.

## Goal

Make code safer and easier to change.
Use TypeScript to model real constraints without adding noise.

## Rules

- Prefer `unknown` over `any`.
- Let inference work for local values.
- Add explicit types at boundaries: exports, API input/output, public functions.
- Enable strict compiler options when project allows.
- Use discriminated unions for state variants.
- Narrow unknown data before use.
- Prefer `interface` for object shapes.
- Prefer `type` for unions and utility types.
- Avoid type assertions unless crossing a known boundary.
- Keep runtime validation near external input.

## Common Fixes

- Replace `any` with `unknown` plus guards.
- Replace boolean state pairs with a discriminated union.
- Replace broad `string` with a union when valid values are finite.
- Infer types from schemas instead of duplicating them.
- Move reusable complex types to named aliases.

## Avoid

- Non-null assertions used to silence real uncertainty.
- Large anonymous object types repeated in many places.
- `as` chains.
- Deep conditional types for app-level code.
- Types that are stricter than runtime validation.

## References

- `context/async-error-handling.md`: async and error patterns.
- `context/strict-config.md`: strict compiler options.
- `context/review-checklist.md`: review checklist.

## Output

- Type safety issue.
- Simpler type model.
- Boundary validation plan.
- Compiler or lint check when relevant.
