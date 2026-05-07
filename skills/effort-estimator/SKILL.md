---
name: effort-estimator
description: Estimate development effort for tasks and features. Use when sizing work, planning sprints, or comparing approaches.
---

# Effort Estimator

Estimate development effort from scope, changed files, risk, and testing cost.

## Size Bands

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

Formula: `final = base x (1 + sum(modifiers))`.

## Process

1. Scope work.
2. Estimate LOC.
3. List likely files touched.
4. Check existing patterns to reuse.
5. Apply modifiers.
6. Split `L` or `XL` work.

## Common Splits

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
- Confidence: [high/medium/low]

## Modifiers
- [x] New tech (+50%)
- [ ] External dependency (+30%)
- [x] Unclear requirements (+50%)
- [ ] Complex testing (+30%)

## Final
- [adjusted time]

## Recommendation
- Proceed or split into [parts]
```
