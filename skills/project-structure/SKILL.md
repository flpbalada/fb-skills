---
name: project-structure
description: Organize React, Next.js, or TypeScript projects with feature-based architecture. Use when starting or reorganizing an app, deciding where files belong, separating app/features/shared layers, preventing cross-feature imports, designing module boundaries, or applying Bulletproof React-style structure. For high-level architecture tradeoffs use architecture-review; for single-component splitting use decompose.
---

# Project Structure

Use feature-based architecture for React, Next.js, and TypeScript.
Organize by domain, not file type.

## When to Use

- Starting React or Next.js project
- Deciding where new code belongs
- Reorganizing large codebase
- Preventing cross-feature imports

## Goal

Keep features independent.
Keep shared code truly shared.
Compose features at app layer.

## Rules

- Code flows one way: shared → features → app.
- Features cannot import other features.
- App can compose multiple features.
- Shared code cannot import app or features.
- Add only folders needed now.
- Move one-feature code into that feature.

## Base Structure

```text
src/
  app/          routing, layouts, providers
  components/   shared UI
  features/     domain modules
  hooks/        shared hooks
  lib/          library clients and wrappers
  types/        shared types
  utils/        shared utilities
```

Feature:

```text
src/features/users/
  api/
  components/
  hooks/
  types/
  utils/
```

Create only folders used by that feature.

## Placement

- Route/page: `src/app/`
- Shared UI: `src/components/`
- Feature UI: `src/features/[feature]/components/`
- Feature API: `src/features/[feature]/api/`
- Feature type: `src/features/[feature]/types/`
- Feature utility: `src/features/[feature]/utils/`
- Shared utility: `src/utils/`

## Flow

1. Identify domain or feature.
2. Check if code is used by one feature or many.
3. Put one-feature code inside feature.
4. Put reused code in shared folders.
5. Compose cross-feature screens in app layer.
6. Add lint rules for import boundaries.

## References

- [Bulletproof React](https://github.com/alan2207/bulletproof-react)
- [Feature-Sliced Design](https://feature-sliced.design/)
- [Next.js Project Organization](https://nextjs.org/docs/app/getting-started/project-structure)

## Output

```md
## Project Structure Decision

Code: [thing being placed]
Scope: [feature-specific / shared / app]
Location: [path]
Reason: [why]
Import boundary:
- Can import from: [allowed]
- Must not import from: [blocked]
```
