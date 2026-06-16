---
name: code-simplifier
description: Simplify recently changed code without changing behavior. Use after implementation when working code has excess nesting, repetition, indirection, unclear names, redundant branches, or needless abstraction. Scope stays near touched code and favors guard clauses and readability. For larger planned restructuring use refactoring; for extracting component pieces use decompose.
---

# Code Simplifier

Simplify code.
Preserve behavior.

## When to Use

- Code was recently edited.
- Logic works but reads harder than needed.
- Nesting, repetition, or indirection grew during implementation.
- User asks for cleanup without behavior change.

## Goal

Make code easier to read, debug, and maintain.
Do not change outputs, side effects, APIs, or user behavior.

## Scope

- Recently modified code only.
- Broader scope only when explicitly requested.

## Rules

- Preserve features, outputs, side effects, and public behavior.
- Prefer guard clauses over nested branches.
- Prefer clear names over comments.
- Remove redundant abstraction.
- Keep useful abstraction.
- Cut needless nesting, repetition, and indirection.
- Avoid nested ternaries and clever one-liners.
- Do not merge unrelated concerns.
- Do not trade readability for fewer lines.

## Flow

1. Find touched code.
2. Identify high-friction logic.
3. Flatten control flow where safe.
4. Remove duplication when it clearly helps.
5. Rename unclear locals when useful.
6. Keep behavior identical.
7. Run relevant checks when feasible.

## Output

```md
## Simplified
- [changed area]

## Preserved
- [behavior kept]

## Verification
- [check run or reason not run]
```
