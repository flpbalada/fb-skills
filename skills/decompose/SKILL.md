---
name: decompose
description: Split an oversized component into focused helpers, hooks, and sub-components. Use when React/UI code mixes rendering, state, effects, handlers, data shaping, and repeated sections, or when a file is hard to scan. Preserve behavior and avoid generic abstractions. For general code restructuring use refactoring; for abstraction decisions beyond one component use code-architecture-wrong-abstraction.
---

# Decompose Component

Split a component into focused units.
Keep behavior unchanged.

## When to Use

- Component mixes rendering, state, effects, and data shaping.
- File is hard to scan.
- Repeated logic belongs in a helper.
- UI sections can become clear sub-components.
- Hook extraction would improve locality or testing.

## Goal

Improve readability and ownership.
Do not create needless abstractions.

## Rules

- Preserve behavior unless user approves behavior change.
- Prefer smallest correct split.
- Extract only when readability, reuse, or locality improves.
- Keep state near the code that owns it.
- Keep side effects explicit.
- Avoid moving code only to reduce file length.
- Do not create generic helpers for one unclear use.

## Flow

1. Read component and identify responsibilities.
2. Mark state, effects, data transforms, handlers, and UI sections.
3. Choose extraction candidates.
4. Extract pure helpers first when obvious.
5. Extract hooks only for cohesive state/effects.
6. Extract sub-components for stable UI sections.
7. Verify behavior and imports.

## Output

```md
## Decomposition
- Extracted: [helper/hook/component]
- Reason: [responsibility isolated]
- Preserved: [behavior]
- Verification: [check run or reason not run]
```
