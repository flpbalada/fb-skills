---
name: naming-cheatsheet
description: Apply language-agnostic naming conventions using the A/HC/LC pattern. Use when naming variables, functions, or reviewing code for naming consistency.
---

# Naming Cheatsheet

Use names that are short, intuitive, and descriptive.

## When to Use

- Naming variables, functions, classes, files, or modules
- Reviewing code names
- Refactoring unclear identifiers

## Goal

Make code read naturally.
Reduce ambiguity.
Keep names consistent.

## Rules

- Use English.
- Follow project convention.
- Avoid contractions and made-up words.
- Avoid duplicated context.
- Match singular/plural to value shape.
- Name booleans by expected truth.
- Reserve React `use` prefix for hooks.

## Function Pattern

```text
prefix? + action + high context + low context?
```

Examples:

- `getUser`
- `getUserMessages`
- `handleClickOutside`
- `shouldDisplayMessage`

## Actions

- `get`: read or fetch data.
- `set`: assign next value.
- `reset`: restore initial state.
- `add` / `remove`: collection changes.
- `create` / `delete`: entity lifecycle.
- `compose` / `build`: create value from values.
- `handle`: respond to event.

## Boolean Prefixes

- `is`: state, like `isActive`.
- `has`: possession, like `hasItems`.
- `should`: condition plus action, like `shouldRender`.
- `can`: capability, like `canEdit`.

```ts
// Bad
const isProductsExist = products.length > 0

// Good
const hasProducts = products.length > 0
```

## React and Errors

- Use `useX` only for hooks.
- Event handlers: `handleX`.
- Props callbacks: `onX`.
- Factory functions need verbs: `createErrorResult`.
- `error`: `Error` instance.
- `errorMessage`: string.
- `errors`: list.

## Output

```md
## Naming Review

Identifier: [current name]
Issue: [unclear / inconsistent / too broad / wrong shape]
Better name: [new name]
Reason: [why]
Pattern: [action/context/boolean/boundary]
```
