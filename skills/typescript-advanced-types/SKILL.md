---
name: typescript-advanced-types
description: Master TypeScript's advanced type system including generics, conditional types, mapped types, template literals, and utility types for building type-safe applications. Use when implementing complex type logic, creating reusable type utilities, or ensuring compile-time type safety in TypeScript projects.
---

# TypeScript Advanced Types

## When to use

- Creating reusable type utilities.
- Building typed libraries, API clients, configs, or state helpers.
- Modeling complex type relationships.
- Replacing unsafe `any` or duplicated runtime/schema types.
- Debugging inference, narrowing, or generic constraints.

## Goal

Use advanced types to improve safety without making code unreadable.
Prefer simple types until complexity pays for itself.

## Rules

- Use `unknown` instead of `any` when input is not trusted.
- Let TypeScript infer simple types.
- Add generics only when a type must connect multiple positions.
- Prefer unions and discriminated unions for variants.
- Prefer `interface` for object shapes.
- Use `type` for unions, conditionals, mapped types, and aliases.
- Avoid deeply nested conditional or recursive types.
- Add type tests for reusable utilities when the project supports them.

## Core Tools

- Generics: reuse logic across related types.
- Conditional types: choose a type from a type condition.
- Mapped types: transform object properties.
- Template literal types: constrain string patterns.
- Utility types: use `Pick`, `Omit`, `Partial`, `Required`, `Readonly`, `Record`.
- `infer`: extract inner types from arrays, promises, functions, or objects.
- Type guards: narrow `unknown` at runtime.
- Assertion functions: throw when runtime validation fails.
- Branded types: distinguish validated strings or IDs.

## Generic Rule

If a type parameter appears only once, it is probably unnecessary.

## Useful Patterns

```ts
type StrictOmit<T, K extends keyof T> = Omit<T, K>;
```

```ts
type ElementType<T> = T extends (infer U)[] ? U : never;
```

```ts
type UserId = string & { readonly __brand: "UserId" };
```

```ts
type User = z.infer<typeof userSchema>;
```

## Avoid

- `any` as a shortcut.
- Type assertions when a guard is possible.
- Overly clever types that hide intent.
- Unbounded generic parameters.
- Duplicating types already available from schema or API definitions.
- Recursive types that slow the compiler.

## Output

- Type approach.
- Simplest type shape.
- Generic constraints if needed.
- Runtime validation boundary when input is unknown.
