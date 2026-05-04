---
name: typescript-best-practices
description: Guides TypeScript best practices for type safety, code organization, and maintainability. Use this skill when configuring TypeScript projects, deciding on typing strategies, writing async code, or reviewing TypeScript code quality.
---

# TypeScript Best Practices

Comprehensive guide to writing clean, type-safe, and maintainable TypeScript code.

## When to Use

- Configuring a new TypeScript project
- Deciding between interface vs type alias
- Writing async/await code
- Reviewing TypeScript code quality
- Avoiding common TypeScript pitfalls

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

## Common Mistakes

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

---

## Progressive Disclosure

| Topic | File | When to Use |
|-------|------|-------------|
| Type system & functions | [context/code-patterns.md](context/code-patterns.md) | Interface vs type, async patterns, guard clauses |
| Project structure | [context/organization.md](context/organization.md) | File naming, barrel files, configuration |
| Testing & performance | [context/testing-performance.md](context/testing-performance.md) | DI, type guards, null handling, performance |

## Key Principles

1. **Type inference when obvious** - Let TypeScript infer simple types
2. **Explicit for public APIs** - Document function signatures clearly
3. **Unknown over any** - Use `unknown` with type guards instead of `any`
4. **Guard clauses** - Early returns reduce nesting
5. **Type-only imports** - Better tree-shaking with `import type`

## References

- [W3Schools TypeScript Best Practices](https://www.w3schools.com/typescript/typescript_best_practices.php)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [TypeScript Performance Wiki](https://github.com/microsoft/TypeScript/wiki/Performance)