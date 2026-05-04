# TypeScript Code Patterns

Type system best practices, functions, and async patterns.

## Type System Best Practices

### Use Type Inference

Let TypeScript infer types when obvious:

```typescript
// Good - inference works fine
const name = 'Alice';
const count = 42;
const items = ['a', 'b', 'c'];

// Bad - redundant annotations
const name: string = 'Alice';
const count: number = 42;
```

### Be Explicit for Public APIs

```typescript
// Good - explicit for function signatures
function calculateTotal(items: CartItem[], taxRate: number): number {
  return items.reduce((sum, item) => sum + item.price, 0) * (1 + taxRate);
}

// Good - explicit for class properties
class UserService {
  private readonly cache: Map<string, User>;
  
  constructor(private api: ApiClient) {
    this.cache = new Map();
  }
}
```

### Interface vs Type Alias

**Use `interface` for:**
- Object shapes that can be extended
- Public API contracts
- Declaration merging needs

```typescript
interface User {
  id: string;
  name: string;
}

interface Admin extends User {
  permissions: string[];
}
```

**Use `type` for:**
- Unions and intersections
- Tuples
- Mapped types
- Primitive aliases

```typescript
type Status = 'pending' | 'approved' | 'rejected';
type Point = [number, number];
type ReadonlyUser = Readonly<User>;
```

### Avoid `any` - Use `unknown` with Type Guards

```typescript
// Bad - defeats type checking
function process(data: any) {
  return data.toUpperCase(); // No error, but might crash
}

// Good - use unknown with type guards
function process(data: unknown): string {
  if (typeof data === 'string') {
    return data.toUpperCase();
  }
  throw new Error('Expected string');
}

// Good - use generics for flexibility
function identity<T>(value: T): T {
  return value;
}
```

## Functions Best Practices

### Explicit Parameter Types

```typescript
// Good - clear contract
function greet(name: string, greeting = 'Hello'): string {
  return `${greeting}, ${name}!`;
}

// Good - use rest parameters for variable arguments
function sum(...numbers: number[]): number {
  return numbers.reduce((a, b) => a + b, 0);
}
```

### Single Responsibility

```typescript
// Bad - function does too much
function processUser(user: User) {
  // validates, transforms, saves, and sends email
}

// Good - split into focused functions
function validateUser(user: User): ValidationResult { ... }
function transformUser(user: User): TransformedUser { ... }
function saveUser(user: TransformedUser): Promise<void> { ... }
function sendWelcomeEmail(user: User): Promise<void> { ... }
```

### Guard Clauses for Early Returns

```typescript
// Good - guard clauses
function processOrder(order: Order | null): ProcessedOrder {
  if (!order) throw new Error('Order required');
  if (order.items.length === 0) throw new Error('Order must have items');
  if (order.status !== 'pending') throw new Error('Order already processed');
  
  // Main logic here - no nesting
  return { ...order, status: 'processed' };
}
```

## Async/Await Patterns

### Always Handle Errors

```typescript
// Good - explicit error handling
async function fetchUser(id: string): Promise<User> {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    if (error instanceof NotFoundError) {
      throw new UserNotFoundError(id);
    }
    throw error;
  }
}
```

### Use AggregateError for Multiple Errors

When multiple operations can fail, use `AggregateError` to preserve all errors:

```typescript
// Bad - loses error context, only message passed
const errors = response.errors;
if (errors) {
  throw new Error(JSON.stringify(errors)); // Wrapping in JSON loses structure
}

// Good - AggregateError preserves all errors
if (errors?.length) {
  throw new AggregateError(errors, 'Failed to place order');
}
```

### Promise.all vs Sequential Awaits

**Use `Promise.all` for independent async operations:**

```typescript
// Bad - sequential when parallel is possible
const user = await fetchUser(id);
const orders = await fetchOrders(id);
const preferences = await fetchPreferences(id);

// Good - parallel execution
const [user, orders, preferences] = await Promise.all([
  fetchUser(id),
  fetchOrders(id),
  fetchPreferences(id),
]);
```

**Sequential awaits are OK when operations depend on each other:**

```typescript
// This is fine - second call needs result from first
const user = await createUser(userData);
const profile = await createProfile(user.id, profileData);
```

### Unnecessary async Functions

Remove `async` keyword when the function doesn't use `await`:

```typescript
// Bad - async with no await
async function getDisplayName(user: User) {
  return user.firstName + ' ' + user.lastName;
}

// Good - no async needed
function getDisplayName(user: User) {
  return user.firstName + ' ' + user.lastName;
}
```

### Flatten Async Chains

```typescript
// Bad - callback hell with async
async function bad() {
  return fetchUser().then(user => {
    return fetchOrders(user.id).then(orders => {
      return processOrders(orders).then(result => {
        return result;
      });
    });
  });
}

// Good - flat async/await
async function good() {
  const user = await fetchUser();
  const orders = await fetchOrders(user.id);
  return processOrders(orders);
}
```