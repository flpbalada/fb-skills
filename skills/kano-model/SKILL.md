---
name: kano-model
description: Prioritize product features with the Kano model of customer satisfaction. Use when sorting feature ideas, roadmap items, requirements, or service attributes into must-haves, performance drivers, delighters, low-value work, and reverse effects; use to decide what to protect, improve, add, defer, remove, or validate.
---

# Kano Model

Classify features by satisfaction impact.
Separate basics, performance drivers, delighters, low-value work, and reverse effects.

## Goal

Help users decide feature priority.
Classify each feature by customer satisfaction impact.

## Categories

- Must-be: expected baseline. Missing causes dissatisfaction. Presence prevents complaints.
- One-dimensional: more or better increases satisfaction; less or worse decreases satisfaction.
- Attractive: unexpected delight. Presence increases satisfaction. Absence does not hurt.
- Indifferent: little satisfaction impact either way.
- Reverse: more of the feature reduces satisfaction for some users.
- Questionable: contradictory response. Exclude or inspect.

## Rules

- Use behavior, support tickets, churn reasons, sales objections, interviews, or survey data.
- Treat stakeholder guesses as hypotheses.
- Split segments when categories conflict.
- Re-check old classifications; delighters can become basics.
- Do not treat delighters as a substitute for broken must-haves.
- Do not overbuild must-haves unless they support positioning.
- Keep survey design optional. Most users need priority advice first.

## Flow

1. Clarify user segment and product context.
2. Rewrite feature ideas as user-visible outcomes.
3. Classify each feature.
4. Pick action from category.
5. Rank within each action group by evidence strength and strategic fit.
6. Name unknowns and fastest validation.

## Actions

- Must-be: protect baseline.
- One-dimensional: improve when strategic.
- Attractive: add selectively for differentiation.
- Indifferent: cut, defer, or de-scope.
- Reverse: remove, segment, or make optional.
- Questionable: inspect before deciding.

## Optional Validation

Use lightweight research when evidence is weak:

- Ask what users expect as baseline.
- Ask what absence would block, annoy, or not matter.
- Ask what presence would delight, help, or feel like clutter.

## Resources

- `references/sources.md`: load only for formal Kano surveys, answer mapping, satisfaction coefficients, source citations, or deeper method checks.

## Output

```md
## Kano Analysis

Segment:
Context:

## Features
- [Feature]
  - Category: [category]
  - Evidence: [signal]
  - Confidence: [low / medium / high]
  - Action: [action]

## Priority
- Protect:
- Improve:
- Add:
- Cut or defer:
- Segment conflicts:

## Next Validation
- Unknowns:
- Fastest check:
- Re-check date:
```
