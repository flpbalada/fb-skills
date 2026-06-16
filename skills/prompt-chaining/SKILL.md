---
name: prompt-chaining
description: Break known LLM work into fixed sequential steps with handoff schemas, validation checks, retries, and final formatting. Use when later steps depend on earlier outputs or staged review reduces errors. Do not use for independent branches; use parallelization. Do not use when tasks must be discovered at runtime; use orchestrator-workers.
---

# Prompt Chaining

Break work into fixed ordered steps.
Validate each handoff.

## When to Use

- Task has clear sequence
- Later step needs earlier output
- Intermediate state should be inspected
- Steps need different prompts, tools, or models
- Guardrails between stages reduce errors

## Goal

Reduce error by making each prompt do one job.
Keep handoffs explicit.

## Rules

- Use only for fixed sequences.
- Define final output first.
- Give each step one responsibility.
- Use strict handoff schema.
- Validate before next step.
- Stop or retry on bad output.
- Log cost, latency, input, and output when useful.

## Flow

1. Define final output.
2. Split work into ordered steps.
3. Write job and schema for each step.
4. Run step 1.
5. Validate output.
6. Continue or retry.
7. Final step formats result.

## Good Step Boundaries

- Extract facts.
- Classify input.
- Summarize evidence.
- Draft answer.
- Check answer against facts.
- Format for target system.

## Avoid

- Too many steps.
- Vague handoff format.
- Later step redoing earlier work.
- No validation.
- Copying full context every step.
- Using chaining when one prompt is enough.

## Output

```md
## Prompt Chain

Final output: [target]

Steps:
1. [job], input [schema], output [schema], validation [check]
2. [job], input [schema], output [schema], validation [check]

Failure rule:
- [retry / stop / escalate]
```

## Decision Rule

Use prompt chaining when stepwise validation lowers errors more than handoff cost.
If steps are independent, use parallelization.
