---
name: typescript-satisfies-operator
description: Guides proper usage of TypeScript's satisfies operator vs type annotations. Use this skill when deciding between type annotations (colon) and satisfies, validating object shapes while preserving literal types, or troubleshooting type inference issues.
---

# TypeScript `satisfies`

## When to use

- Validating object shape while preserving literal types.
- Defining config objects, route maps, locale maps, or handler maps.
- Choosing between `: Type`, `satisfies Type`, `as const`, and `as Type`.
- Fixing widened types caused by annotations.

## Goal

Validate that a value matches a type without replacing the value's inferred type.

## Rules

- Use `satisfies` when value specificity should win.
- Use `: Type` when the variable should have the wider type.
- Use `as const satisfies` for readonly literal config.
- Avoid `as Type` unless it is a deliberate escape hatch.
- Use `Record<Union, Value>` with `satisfies` for exhaustive maps.

## Mental Model

- `: Type`: type wins, value may widen.
- `satisfies Type`: value wins, shape is checked.
- `as Type`: tells TypeScript to trust you.
- no annotation: inference only.

## Pattern

```ts
type Locale = "en" | "cs";

const localeIds = {
  en: "1",
  cs: "2",
} as const satisfies Record<Locale, string>;
```

## Object Validation

```ts
type Colors = "red" | "green" | "blue";
type RGB = [number, number, number];

const palette = {
  red: [255, 0, 0],
  green: "#00ff00",
  blue: [0, 0, 255],
} satisfies Record<Colors, string | RGB>;

palette.green.toUpperCase();
```

## Use Cases

- Route maps.
- Locale maps.
- Feature flag config.
- Status labels.
- Event handler maps.
- Design token objects.

## Avoid

- Annotating config objects so all literals widen.
- Using `satisfies` when later reassignment needs wider type.
- Using `as const` after a type annotation and expecting literals to survive.

## References

- [TypeScript 4.9 Release Notes](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html#the-satisfies-operator)
- [Matt Pocock - Clarifying the satisfies Operator](https://www.totaltypescript.com/clarifying-the-satisfies-operator)
- [GitHub Issue #47920 - Original Proposal](https://github.com/microsoft/TypeScript/issues/47920)

## Output

- Whether to use annotation, `satisfies`, `as const satisfies`, or inference.
- Reason tied to widening or validation.
- Example replacement when useful.
