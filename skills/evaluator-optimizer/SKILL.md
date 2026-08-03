---
name: evaluator-optimizer
description: Run an evaluator-optimizer loop by generating candidate outputs, scoring against a rubric or tests, revising, and stopping on pass, budget, or plateau. Use when quality criteria are explicit and iterative refinement is cheaper than failure; avoid when no reliable evaluation signal exists, speed matters more than polish, outputs are high-risk and require human review, or revision may drift from user intent.
---

# Evaluator-Optimizer

Generate.
Judge.
Revise.
Stop when good enough.

## Goal

- Produce stronger output through controlled iteration.
- Keep evaluator strict.
- Stop before cost or drift grows.

## Rules

- Define rubric before generating.
- Separate generator and evaluator roles.
- Evaluator returns score, reasons, and fix hints.
- Set max rounds.
- Stop on pass, budget, or plateau.
- Save failing examples for rubric tuning.

## Good eval signals

- Schema validity.
- Test pass rate.
- Grounding to source facts.
- Style compliance.
- Policy compliance.
- Ranking score.

## Flow

1. Define pass/fail rubric.
2. Generate candidate.
3. Evaluate against rubric.
4. If pass, return candidate.
5. If fail, revise using feedback.
6. Repeat until stop condition.

## Failure modes

- Evaluator too soft.
- Evaluator and generator share blind spots.
- Feedback not actionable.
- Loop overfits rubric.
- No stop rule.
- No human review path for high-risk output.

## Output

```md
## Result
- Status: pass | fail | stopped
- Rounds: [n]
- Score: [score]

## Final Output
[candidate]

## Evaluation Notes
- [reason]
- [remaining risk]
```
