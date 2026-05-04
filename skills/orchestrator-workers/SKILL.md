---
name: orchestrator-workers
description: Use a central planner to break dynamic tasks into worker jobs and combine results. Use when task shape is unknown upfront and subtasks must be assigned at runtime.
---

# Orchestrator-Workers

Anthropic canonical agent pattern.
Planner in middle.
Workers do pieces.
Orchestrator decides next jobs.

## What It Is

One orchestrator decomposes task at runtime.
It assigns jobs to workers.
Workers return outputs.
Orchestrator reviews, adds jobs, then combines result.

## When to Use

- Task shape not known upfront
- Need dynamic decomposition
- Different workers have different tools or skills
- Need iterative task assignment
- Work is too big for one fixed chain

## When Not to Use

- Flow is fixed and simple
- Workers do not add real specialization
- Planner overhead bigger than work
- Need strict predictability over flexible search
- Shared state design is weak

## Core Flow

```text
input
  → orchestrator plans
  → assign worker jobs
  → workers execute
  → orchestrator reviews gaps
  → assign more jobs or finish
  → synthesize output
```

## Simple Implementation Outline

1. Define orchestrator role.
2. Define worker types and contracts.
3. Store shared task state outside prompts.
4. Give workers narrow jobs.
5. Make orchestrator inspect worker outputs.
6. Allow replan, but cap loops.
7. Synthesize with citations to worker results.

## Good Worker Types

- Research worker
- Code worker
- Test worker
- Retrieval worker
- Critique worker

## Failure Modes

- Orchestrator micromanages every detail
- Workers overlap and duplicate effort
- No shared state contract
- Replan loop never ends
- Worker outputs too verbose to combine
- Orchestrator hides uncertainty

## Practical Checklist

- Dynamic planning actually needed
- Worker roles distinct
- Input/output contract per worker
- Shared state store defined
- Max rounds set
- Escalation rule for stuck state
- Synthesis step grounded in worker outputs
- Trace of plan, tasks, results kept

## Decision Rule

Use orchestrator-workers when task decomposition must happen during execution.
If job graph is known upfront, prefer chaining or parallelization.
