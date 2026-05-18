---
name: orchestrator-workers
description: Use a central planner to break dynamic tasks into worker jobs and combine results. Use when task shape is unknown upfront and subtasks must be assigned at runtime.
---

# Orchestrator-Workers

Central planner.
Specialized workers.
Dynamic task assignment.

## When to Use

- Task shape is unknown upfront
- Work needs runtime decomposition
- Workers need different tools or skills
- Results reveal more work
- One fixed chain is too rigid

## Goal

Let orchestrator plan, assign, inspect, replan, and synthesize.
Keep workers narrow and outputs easy to merge.

## Rules

- Use only when dynamic planning adds value.
- Give each worker one clear job.
- Define worker output schema.
- Store shared state outside prompts.
- Cap replan rounds.
- Keep trace of jobs and results.
- Ground final synthesis in worker outputs.

## Flow

1. Orchestrator reads task.
2. Orchestrator creates first worker jobs.
3. Workers execute independently.
4. Orchestrator reviews outputs.
5. Orchestrator assigns follow-up jobs if needed.
6. Orchestrator synthesizes final answer.

## Good Worker Types

- Research worker
- Retrieval worker
- Code worker
- Test worker
- Critique worker
- Summarizer worker

## Avoid

- Workers with overlapping scope.
- Infinite replanning.
- Vague shared state.
- Verbose outputs.
- Hidden uncertainty.
- Orchestrator doing all worker work.

## Output

```md
## Orchestrator Plan

Task: [goal]
Shared state: [source of truth]
Max rounds: [n]

Workers:
- [worker]: [job], output [schema]

Review:
- Gaps: [missing info]
- Follow-up jobs: [if needed]

Final synthesis:
- [combined result grounded in worker outputs]
```

## Decision Rule

Use orchestrator-workers when decomposition must happen during execution.
If job graph is known upfront, use prompt chaining or parallelization.
