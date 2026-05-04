# TypeScript Testing, Performance, and Null Handling

Best practices for testing, performance optimization, and handling null/undefined.

## Testing and Quality

### Dependency Injection for Testability

```typescript
interface PaymentGateway {
  charge(amount: number): Promise<boolean>;
}

class PaymentProcessor {
  constructor(private gateway: PaymentGateway) {}
  
  async processPayment(amount: number): Promise<boolean> {
    if (amount <= 0) throw new Error('Amount must be positive');
    return this.gateway.charge(amount);
  }
}

// Easy to test with mock
const mockGateway: PaymentGateway = {
  charge: jest.fn().mockResolvedValue(true),
};
const processor = new PaymentProcessor(mockGateway);
```

### Type Guards for Runtime Checking

```typescript
interface Cat {
  meow(): void;
}

interface Dog {
  bark(): void;
}

function isCat(pet: Cat | Dog): pet is Cat {
  return 'meow' in pet;
}

function makeSound(pet: Cat | Dog) {
  if (isCat(pet)) {
    pet.meow(); // TypeScript knows it's Cat
  } else {
    pet.bark(); // TypeScript knows it's Dog
  }
}
```

## Performance Considerations

### Type-Only Imports

```typescript
// Good - type stripped at compile time, better tree-shaking
import type { User, Order } from './types';
import { fetchUser } from './api';

// Also good for re-exports
export type { User, Order };
```

### Const Assertions for Literal Types

```typescript
// Creates readonly tuple with literal types
const colors = ['red', 'green', 'blue'] as const;
type Color = typeof colors[number]; // "red" | "green" | "blue"

// Works for objects too
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
} as const;
```

### Avoid Excessive Type Complexity

```typescript
// Bad - deeply nested mapped types slow compilation
type DeepReadonly<T> = {
  readonly [K in keyof T]: T[K] extends object
    ? DeepReadonly<T[K]>
    : T[K];
};

// Consider simpler alternatives or use sparingly
```

## Handle Null/Undefined Properly

### Optional Chaining and Nullish Coalescing

```typescript
// Good - safe property access
function getLength(str: string | null): number {
  return str?.length ?? 0;
}

// Good - safe method calls
const result = user?.getProfile?.()?.name ?? 'Anonymous';

// Good - default values only for null/undefined
const port = config.port ?? 3000; // 0 is valid, won't use default
```

### Discriminated Unions for State

```typescript
type AsyncState<T> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: Error };

function renderState<T>(state: AsyncState<T>) {
  switch (state.status) {
    case 'idle':
      return 'Ready';
    case 'loading':
      return 'Loading...';
    case 'success':
      return state.data; // TypeScript knows data exists
    case 'error':
      return state.error.message; // TypeScript knows error exists
  }
}
```

## Infer Types from Zod Schemas

Avoid duplicating type definitions when using Zod for validation:

```typescript
// Bad - duplicate type definition
interface User {
  id: string;
  name: string;
  email: string;
}

const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
});

// Good - infer type from schema
const userSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
});

type User = z.infer<typeof userSchema>;

// Benefit: single source of truth, schema and type always in sync
```

**Why it matters:** 
- Eliminates duplicate definitions
- Ensures runtime validation and TypesScript types stay synchronized
- Reduces maintenance burden when schemas change

## Error cause Must Be Error Instance

When using `Error` options, the `cause` property must be an `Error` instance:

```typescript
// Bad - cause is not an Error
throw new Error('Failed', { 
  cause: JSON.stringify(response.errors) 
});

// Good - cause is an Error instance
throw new Error('Failed', { 
  cause: new AggregateError(response.errors, 'GraphQL errors') 
});

// Good - cause chain
const originalError = new Error('Network failed');
throw new Error('API call failed', { cause: originalError });
```

## Common Mistakes to Avoid

| Mistake | Problem | Solution |
|---------|---------|----------|
| Overusing `any` | Defeats type checking | Use `unknown`, generics, or proper types |
| Not using strict mode | Misses many errors | Enable `"strict": true` |
| Redundant annotations | Clutters code | Trust type inference |
| Ignoring union types | Runtime errors | Use type guards |
| Not handling null | Crashes | Use `?.` and `??` operators |
| Nested conditionals | Hard to read | Use guard clauses |
| Duplicate types with Zod | Maintenance burden | Infer from `z.infer<typeof schema>` |
| Sequential awaits for independent ops | Slower execution | Use `Promise.all` |
| Non-Error cause | Breaks error chains | Always use Error instance for cause |

## Quick Reference

```typescript
// Type inference - let TS do the work
const name = 'Alice';

// Explicit for APIs
function greet(name: string): string { ... }

// Unknown over any
function safe(data: unknown) { ... }

// Type-only imports
import type { User } from './types';

// Const assertions
const tuple = [1, 2] as const;

// Null safety
const len = str?.length ?? 0;

// Guard clauses
if (!valid) throw new Error();
// main logic...
```

## References

- [W3Schools TypeScript Best Practices](https://www.w3schools.com/typescript/typescript_best_practices.php)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [TypeScript Performance Wiki](https://github.com/microsoft/TypeScript/wiki/Performance)