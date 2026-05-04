# TypeScript Advanced Types - Core Examples

Detailed code examples for generics, conditional types, mapped types, and template literal types.

## Generics

### Basic Generic Function

```typescript
function identity<T>(value: T): T {
  return value;
}

const num = identity<number>(42);        // Type: number
const str = identity<string>("hello");    // Type: string
const auto = identity(true);              // Type inferred: boolean
```

### Generic Constraints

```typescript
interface HasLength {
  length: number;
}

function logLength<T extends HasLength>(item: T): T {
  console.log(item.length);
  return item;
}

logLength("hello");           // OK: string has length
logLength([1, 2, 3]);         // OK: array has length
logLength({ length: 10 });    // OK: object has length
// logLength(42);             // Error: number has no length
```

### Multiple Type Parameters

```typescript
function merge<T, U>(obj1: T, obj2: U): T & U {
  return { ...obj1, ...obj2 };
}

const merged = merge(
  { name: "John" },
  { age: 30 }
);
// Type: { name: string } & { age: number }
```

## Conditional Types

### Basic Conditional Type

```typescript
type IsString<T> = T extends string ? true : false;

type A = IsString<string>;    // true
type B = IsString<number>;    // false
```

### Extracting Return Types

```typescript
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

function getUser() {
  return { id: 1, name: "John" };
}

type User = ReturnType<typeof getUser>;
// Type: { id: number; name: string; }
```

### Distributive Conditional Types

```typescript
type ToArray<T> = T extends any ? T[] : never;

type StrOrNumArray = ToArray<string | number>;
// Type: string[] | number[]
```

### Nested Conditions

```typescript
type TypeName<T> =
  T extends string ? "string" :
  T extends number ? "number" :
  T extends boolean ? "boolean" :
  T extends undefined ? "undefined" :
  T extends Function ? "function" :
  "object";

type T1 = TypeName<string>;     // "string"
type T2 = TypeName<() => void>; // "function"
```

## Mapped Types

### Basic Mapped Type

```typescript
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

interface User {
  id: number;
  name: string;
}

type ReadonlyUser = Readonly<User>;
// Type: { readonly id: number; readonly name: string; }
```

### Optional Properties

```typescript
type Partial<T> = {
  [P in keyof T]?: T[P];
};

type PartialUser = Partial<User>;
// Type: { id?: number; name?: string; }
```

### Key Remapping

```typescript
type Getters<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K]
};

interface Person {
  name: string;
  age: number;
}

type PersonGetters = Getters<Person>;
// Type: { getName: () => string; getAge: () => number; }
```

### Filtering Properties

```typescript
type PickByType<T, U> = {
  [K in keyof T as T[K] extends U ? K : never]: T[K]
};

interface Mixed {
  id: number;
  name: string;
  age: number;
  active: boolean;
}

type OnlyNumbers = PickByType<Mixed, number>;
// Type: { id: number; age: number; }
```

## Template Literal Types

### Basic Template Literal

```typescript
type EventName = "click" | "focus" | "blur";
type EventHandler = `on${Capitalize<EventName>}`;
// Type: "onClick" | "onFocus" | "onBlur"
```

### String Manipulation

```typescript
type UppercaseGreeting = Uppercase<"hello">;  // "HELLO"
type LowercaseGreeting = Lowercase<"HELLO">;  // "hello"
type CapitalizedName = Capitalize<"john">;    // "John"
type UncapitalizedName = Uncapitalize<"John">; // "john"
```

### Path Building

```typescript
type Path<T> = T extends object
  ? { [K in keyof T]: K extends string
      ? `${K}` | `${K}.${Path<T[K]>}`
      : never
    }[keyof T]
  : never;

interface Config {
  server: {
    host: string;
    port: number;
  };
  database: {
    url: string;
  };
}

type ConfigPath = Path<Config>;
// Type: "server" | "database" | "server.host" | "server.port" | "database.url"
```

## Utility Types

```typescript
// Partial<T> - Make all properties optional
type PartialUser = Partial<User>;

// Required<T> - Make all properties required
type RequiredUser = Required<PartialUser>;

// Readonly<T> - Make all properties readonly
type ReadonlyUser = Readonly<User>;

// Pick<T, K> - Select specific properties
type UserName = Pick<User, "name" | "email">;

// Omit<T, K> - Remove specific properties
type UserWithoutPassword = Omit<User, "password">;

// Exclude<T, U> - Exclude types from union
type T1 = Exclude<"a" | "b" | "c", "a">;  // "b" | "c"

// Extract<T, U> - Extract types from union
type T2 = Extract<"a" | "b" | "c", "a" | "b">;  // "a" | "b"

// NonNullable<T> - Exclude null and undefined
type T3 = NonNullable<string | null | undefined>;  // string

// Record<K, T> - Create object type with keys K and values T
type PageInfo = Record<"home" | "about", { title: string }>;
```

## The Golden Rule of Generics

**If a type parameter appears only in the function signature, it's likely unnecessary.**

```typescript
// Bad - T only appears in signature, not in return or body
function getRelationName<T extends 'department' | 'location'>(
  data: Career['data'],
  field: T
): string | null {
  // T is never used in implementation
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

**Why it matters:** Generics should flow through the function - appearing in input AND output. If they don't add type inference value, they add complexity without benefit.

## StrictOmit for Safer Property Exclusion

```typescript
// Problem: Omit doesn't validate key exists
interface User {
  id: string;
  name: string;
  email: string;
}

// No error - 'passwrod' typo silently accepted
type UserWithoutPassword = Omit<User, 'passwrod'>;

// Solution: StrictOmit validates the key exists
type StrictOmit<T, K extends keyof T> = Omit<T, K>;

// Error: 'passwrod' does not exist in User
type SafeUser = StrictOmit<User, 'passwrod'>; // TypeScript error!

// Correct usage
type UserPublic = StrictOmit<User, 'email'>; // OK
```

## Branded Types for Nominal Typing

TypeScript uses structural typing - types with the same shape are compatible. Branded types add a "brand" to create nominal typing:

```typescript
type UniformResourceLocator = string & { _brand: 'url' };

const isURL = (candidate: unknown): candidate is UniformResourceLocator => {
  const schema = z.url();
  return schema.safeParse(candidate).success;
};

// Now you can't accidentally pass a regular string where URL is expected
function fetchFromAPI(url: UniformResourceLocator) {
  // ...
}

const url = 'https://example.com';
// fetchFromAPI(url); // Error! Not a branded URL

if (isURL(url)) {
  fetchFromAPI(url); // OK - type guard validated it
}
```

**Use case:** When you need to guarantee a string is validated (URLs, IDs, email addresses) before using it in type-sensitive contexts.