# TypeScript Code Organization

Project configuration, file naming, and code structure best practices.

## Project Configuration

Always enable `strict` mode for maximum type safety:

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "alwaysStrict": true
  }
}
```

**Why strict mode matters:**
- Catches bugs at compile time instead of runtime
- Forces explicit handling of null/undefined
- Prevents implicit `any` types from sneaking in

## File Naming Convention

Use lowercase with dots for clarity:

```
src/
├── user/
│   ├── user.service.ts
│   ├── user.model.ts
│   ├── user.controller.ts
│   └── index.ts          # Barrel file
├── auth/
│   ├── auth.service.ts
│   └── index.ts
└── types/
    └── index.ts
```

## Barrel Files for Clean Exports

```typescript
// user/index.ts
export { UserService } from './user.service';
export { User, CreateUserDto } from './user.model';
export { UserController } from './user.controller';
```

```typescript
// Consumer imports cleanly
import { UserService, User } from './user';
```