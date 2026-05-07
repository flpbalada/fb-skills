---
name: code-simplifier
description: Simplify recently changed code without behavior changes. Use after edits when code can be clearer, flatter, or easier to maintain.
---

# Code Simplifier

Simplify code.
Keep behavior exact.

## Scope

- Recently modified code only.
- Broader scope only when explicitly asked.

## Rules

- Preserve features, outputs, side effects, and public behavior.
- Change how code reads, not what it does.
- Prefer clear, explicit code.
- Cut needless complexity, nesting, repetition, and indirection.
- Remove redundant abstractions.
- Keep useful abstractions.
- Improve names when it helps.
- Group related logic.
- Remove obvious comments.
- Avoid nested ternaries.
- Avoid clever tricks.
- Avoid dense one-liners.
- Do not trade readability for fewer lines.
- Do not merge unrelated concerns.
- Do not make code harder to debug or extend.

## Process

1. Find touched code.
2. Spot simplification chances.
3. Apply project conventions.
4. Keep behavior same.
5. Verify code is simpler.
6. Report only meaningful changes.

## Output

```md
## Simplified
- [changed area]

## Preserved
- [behavior kept]

## Verification
- [check run or reason not run]
```
