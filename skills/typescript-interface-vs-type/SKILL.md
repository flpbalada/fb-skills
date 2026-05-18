---
name: typescript-interface-vs-type
description: Guides when to use interface vs type in TypeScript. Use this skill when defining object types, extending types, or choosing between interface and type aliases.
---

# TypeScript: Interface vs Type

## When to use

- Defining object shapes.
- Extending or composing types.
- Choosing between `interface`, `type`, and intersections.
- Reviewing TypeScript type style.

## Goal

Use `interface` until `type` features are needed.
Prefer readable errors and compiler performance.

## Rules

- Use `interface` for object type definitions.
- Use `interface extends` for extending object shapes.
- Use `interface` for class contracts.
- Use `type` for unions, tuples, primitives, mapped types, conditional types, and function aliases.
- Prefer `interface extends` over object intersections.
- Avoid intersections when properties may conflict.

## Examples

```ts
interface User {
  name: string;
}

interface Admin extends User {
  permissions: string[];
}
```

```ts
type Status = "pending" | "approved" | "rejected";
type Point = [number, number];
type Handler = (event: Event) => void;
```

## Why Prefer Extends

- Conflicting properties fail at the definition.
- Error messages are clearer.
- Named interfaces are cached by TypeScript.
- Intersections can be recomputed and harder to debug.

## Avoid

```ts
type Admin = User & {
  permissions: string[];
};
```

Use this only when intersection semantics are intentional.

## Output

- Recommended declaration form.
- Reason: object shape, union, tuple, conditional, mapped type, or extension.
- Any intersection risk.
