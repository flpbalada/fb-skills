---
name: effort-estimator
description: Estimate development effort for tasks and features. Use when sizing work, planning sprints, or comparing approaches.
---

# Effort Estimator

Estimate work from scope, risk, and verification cost.

## When to use

- User asks for effort, sizing, sprint planning, or approach comparison.
- Work has enough detail to estimate roughly.
- Scope may need splitting.

## Goal

- Give useful size.
- State confidence.
- Expose risk.
- Recommend proceed or split.

## Size bands

- XS: `<30 LOC`, `<=1h`, high confidence.
- S: `30-100 LOC`, `0.5d`, high confidence.
- M: `100-200 LOC`, `<=1d`, medium confidence.
- L: `200-400 LOC`, `2-3d`, low confidence, split recommended.
- XL: `>400 LOC`, must split.

## Modifiers

- New tech or pattern: `+50%`.
- External dependency: `+30%`.
- Unclear requirements: `+50%`.
- Complex testing: `+30%`.

Formula:

```text
final = base x (1 + sum(modifiers))
```

## Flow

1. Define scope.
2. Estimate changed files and LOC.
3. Check reusable patterns.
4. Apply modifiers.
5. Identify verification cost.
6. Split `L` or `XL`.

## Common splits

- Foundation.
- API layer.
- UI.
- Integration.
- Tests and hardening.

## Output

```md
## Effort Estimate
- Size: [XS/S/M/L/XL]
- Base: [time]
- Final: [adjusted time]
- Confidence: [high/medium/low]

## Why
- Scope: [summary]
- Files: [likely files]
- Modifiers: [applied]
- Verification: [checks/tests]

## Recommendation
- [Proceed or split]
```
