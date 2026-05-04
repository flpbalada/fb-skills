---
name: evaluator-optimizer
description: Generate outputs, score them, and iterate until quality passes a bar. Use when clear evaluation criteria exist and refinement is cheaper than failure.
---

# Evaluator-Optimizer

Anthropic canonical agent pattern.
Generate.
Judge.
Revise.
Repeat until good enough.

## What It Is

One component makes candidate output.
Another component evaluates it.
Feedback drives revision.
Loop ends on pass, budget, or max rounds.

## When to Use

- Quality bar is clear
- Output can improve with feedback
- Eval criteria can be written or coded
- Failure is costly
- Extra loop cost is acceptable

## When Not to Use

- No reliable eval signal
- Feedback vague or subjective
- Fast answer matters more than polished answer
- Output space huge and revisions drift
- Humans should review instead of model judge

## Core Flow

```text
candidate
  → evaluator scores against rubric
  → pass ? return
  → optimizer revises using feedback
  → re-evaluate
```

## Simple Implementation Outline

1. Define pass/fail rubric.
2. Separate generator and evaluator prompts.
3. Keep evaluator stricter than generator.
4. Return score + reasons + fix hints.
5. Limit revision rounds.
6. Stop on plateau.
7. Save failing examples for rubric tuning.

## Good Eval Signals

- Schema validity
- Test pass rate
- Grounding to source facts
- Style or policy compliance
- Ranking score

## Failure Modes

- Evaluator too soft. Bad outputs pass.
- Evaluator and optimizer share same blind spots.
- Feedback vague. Revisions random.
- Loop overfits rubric, hurts real quality.
- No stop rule. Cost climbs.
- Generator never sees concrete failure examples.

## Practical Checklist

- Rubric explicit
- Pass threshold set
- Generator and evaluator separated
- Feedback actionable
- Max rounds set
- Plateau stop rule set
- Offline eval set exists
- Human review path for high-risk cases

## Decision Rule

Use evaluator-optimizer when you can state quality bar clearly and iterate cheaply.
If you cannot judge quality well, do not build this loop.
