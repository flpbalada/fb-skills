---
name: typescript-advanced-types
description: Master TypeScript's advanced type system including generics, conditional types, mapped types, template literals, and utility types for building type-safe applications. Use when implementing complex type logic, creating reusable type utilities, or ensuring compile-time type safety in TypeScript projects.
---

# TypeScript Advanced Types

Comprehensive guidance for mastering TypeScript's advanced type system including generics, conditional types, mapped types, template literal types, and utility types for building robust, type-safe applications.

## When to Use This Skill

- Building type-safe libraries or frameworks
- Creating reusable generic components
- Implementing complex type inference logic
- Designing type-safe API clients
- Building form validation systems
- Creating strongly-typed configuration objects
- Implementing type-safe state management
- Migrating JavaScript codebases to TypeScript

## Core Concepts

### 1. Generics

Create reusable, type-flexible components while maintaining type safety.

```typescript
function identity<T>(value: T): T {
  return value;
}

const num = identity<number>(42);        // Type: number
const str = identity<string>("hello");   // Type: string
const auto = identity(true);              // Type inferred: boolean
```

### 2. Conditional Types

Create types that depend on conditions.

```typescript
type IsString<T> = T extends string ? true : false;

type A = IsString<string>;    // true
type B = IsString<number>;    // false
```

### 3. Mapped Types

Transform existing types by iterating over their properties.

```typescript
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

type Partial<T> = {
  [P in keyof T]?: T[P];
};
```

### 4. Template Literal Types

Create string-based types with pattern matching.

```typescript
type EventName = "click" | "focus" | "blur";
type EventHandler = `on${Capitalize<EventName>}`;
// Type: "onClick" | "onFocus" | "onBlur"
```

### 5. Utility Types

Built-in utility types for common transformations:

```typescript
Partial<T>      // Make all properties optional
Required<T>     // Make all properties required
Readonly<T>     // Make all properties readonly
Pick<T, K>      // Select specific properties
Omit<T, K>      // Remove specific properties
```

## The Golden Rule of Generics

**If a type parameter appears only in the function signature, it's likely unnecessary.**

```typescript
// Bad - T only appears in signature, not in return or body
function getRelationName<T extends 'department' | 'location'>(
  data: Career['data'],
  field: T
): string | null {
  return data?.[field]?.name ?? null
}

// Good - no unnecessary generic, use union directly
function getRelationName(
  data: Career['data'],
  field: 'department' | 'location' | 'employmentType'
): string | null {
  return data?.[field]?.name ?? null
}
```

## Progressive Disclosure

This skill provides detailed examples through context files. Load them when needed:

| Context File                      | When to Load                                    |
| --------------------------------- | ----------------------------------------------- |
| `context/core-examples.md`       | Need generics, conditionals, mapped types examples |
| `context/patterns.md`            | Implementing real-world patterns (EventEmitter, API client, Builder) |
| `context/techniques.md`          | Type inference, guards, assertions, testing     |

## Type Inference Techniques

### Infer Keyword

```typescript
type ElementType<T> = T extends (infer U)[] ? U : never;
type PromiseType<T> = T extends Promise<infer U> ? U : never;
type Parameters<T> = T extends (...args: infer P) => any ? P : never;
```

### Type Guards

```typescript
function isString(value: unknown): value is string {
  return typeof value === "string";
}

function isArrayOf<T>(
  value: unknown,
  guard: (item: unknown) => item is T
): value is T[] {
  return Array.isArray(value) && value.every(guard);
}
```

### Assertion Functions

```typescript
function assertIsString(value: unknown): asserts value is string {
  if (typeof value !== "string") {
    throw new Error("Not a string");
  }
}
```

## StrictOmit for Safer Property Exclusion

```typescript
// Problem: Omit doesn't validate key exists
type UserWithoutPassword = Omit<User, 'passwrod'>; // No error for typo

// Solution: StrictOmit validates the key exists
type StrictOmit<T, K extends keyof T> = Omit<T, K>;
type SafeUser = StrictOmit<User, 'passwrod'>; // TypeScript error!
```

## Branded Types for Nominal Typing

```typescript
type UniformResourceLocator = string & { _brand: 'url' };

const isURL = (candidate: unknown): candidate is UniformResourceLocator => {
  return z.url().safeParse(candidate).success;
};

function fetchFromAPI(url: UniformResourceLocator) { /* ... */ }

const url = 'https://example.com';
// fetchFromAPI(url); // Error! Not branded

if (isURL(url)) {
  fetchFromAPI(url); // OK - type guard validated
}
```

## Best Practices

1. **Use `unknown` over `any`**: Enforce type checking
2. **Prefer `interface` for object shapes**: Better error messages
3. **Use `type` for unions and complex types**: More flexible
4. **Leverage type inference**: Let TypeScript infer when possible
5. **Create helper types**: Build reusable type utilities
6. **Use const assertions**: Preserve literal types
7. **Avoid type assertions**: Use type guards instead
8. **Document complex types**: Add JSDoc comments
9. **Use strict mode**: Enable all strict compiler options
10. **Test your types**: Use type tests to verify type behavior

## Common Pitfalls

1. **Over-using `any`**: Defeats the purpose of TypeScript
2. **Ignoring strict null checks**: Can lead to runtime errors
3. **Too complex types**: Can slow down compilation
4. **Not using discriminated unions**: Misses type narrowing opportunities
5. **Forgetting readonly modifiers**: Allows unintended mutations
6. **Circular type references**: Can cause compiler errors
7. **Not handling edge cases**: Like empty arrays or null values
8. **Unused generic parameters**: Violate the Golden Rule

## Performance Considerations

- Avoid deeply nested conditional types
- Use simple types when possible
- Cache complex type computations
- Limit recursion depth in recursive types
- Use build tools to skip type checking in production

## Infer Types from Zod Schemas

```typescript
// Avoid duplication
const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
});

type User = z.infer<typeof userSchema>;
```

## References

- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [Type Challenges](https://github.com/type-challenges/type-challenges)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
- [Effective TypeScript](https://effectivetypescript.com/2020/08/12/generics-golden-rule/)