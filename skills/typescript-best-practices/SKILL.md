---
name: typescript-best-practices
description: Improve TypeScript safety, readability, and maintainability. Use when reviewing TypeScript code, choosing typing strategy, configuring strictness, handling async errors, replacing any with unknown, narrowing external data, modeling state with unions, placing runtime validation, or organizing types. For complex reusable type utilities use typescript-advanced-types; for interface vs type decisions use typescript-interface-vs-type.
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

- `context/code-patterns.md`: type system, functions, async patterns, and guard clauses.
- `context/organization.md`: file naming, barrel files, and project configuration.
- `context/testing-performance.md`: DI, type guards, null handling, and performance.
- [W3Schools TypeScript Best Practices](https://www.w3schools.com/typescript/typescript_best_practices.php)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [TypeScript Performance Wiki](https://github.com/microsoft/TypeScript/wiki/Performance)

## Output

- Type safety issue.
- Simpler type model.
- Boundary validation plan.
- Compiler or lint check when relevant.
