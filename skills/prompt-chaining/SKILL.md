---
name: prompt-chaining
description: Break a task into fixed sequential LLM steps with checks between steps. Use when work has clear stages, intermediate outputs, or step-specific prompts.
---

# Prompt Chaining

Anthropic canonical agent pattern.
Linear flow.
One step feeds next step.

## What It Is

Split one task into ordered stages.
Each stage has one job.
Pass output forward.
Check output before next step.

## When to Use

- Task has clear sequence
- Later step needs cleaned output from earlier step
- Need traceable intermediate state
- Need step-specific prompt, tool set, or model
- Need cheap guardrails between stages

## When Not to Use

- One prompt solves task well
- Order does not matter
- Work can run in parallel
- Steps depend on dynamic branching more than fixed flow
- Handoff cost bigger than quality gain

## Core Flow

```text
input
  → step 1: extract / classify / plan
  → validate
  → step 2: transform / expand
  → validate
  → step 3: format / finalize
  → output
```

## Simple Implementation Outline

1. Define end output.
2. Split into small steps.
3. Give each step one job.
4. Lock schema for each handoff.
5. Validate after each step.
6. Retry or stop on bad output.
7. Log step input, output, cost, latency.

## Good Step Boundaries

- Extract facts
- Summarize facts
- Draft answer
- Check answer against facts
- Format for target system

## Failure Modes

- Too many steps. Slow. Fragile.
- Vague handoff format. Drift.
- Later step redoes earlier step.
- Bad early output poisons rest.
- No validation. Errors compound.
- Full context copied every step. Cost spike.

## Practical Checklist

- Steps fixed and ordered
- One responsibility per step
- Input/output schema per step
- Validation between steps
- Retry rule per step
- Stop rule on hard fail
- Logs for each handoff
- Baseline against single prompt

## Decision Rule

Use prompt chaining when decomposition lowers error more than handoff adds cost.
If not, use one prompt.
