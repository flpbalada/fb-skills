---
name: evaluator-optimizer
description: Generate outputs, score them, and iterate until quality passes a bar. Use when clear evaluation criteria exist and refinement is cheaper than failure.
---

# Evaluator-Optimizer

Generate.
Judge.
Revise.
Stop when good enough.

## When to use

- Quality bar is clear.
- Output can improve from feedback.
- Evaluation criteria can be written or coded.
- Failure is costly.
- Extra loop cost is acceptable.

## Do not use

- No reliable eval signal.
- Feedback would be vague or subjective.
- Fast answer matters more than polished answer.
- Output is high-risk and needs human review.
- Revision loops may drift from user intent.

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
