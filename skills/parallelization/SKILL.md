---
name: parallelization
description: Split independent LLM work into concurrent branches, then merge, vote, rank, or compare outputs with a simple schema. Use when subtasks are isolated by item, source, section, test, or judge and latency or judgment quality matters. Do not use when one branch depends on another; use prompt-chaining.
---

# Parallelization

Split independent work.
Run branches at same time.
Merge results.

## When to Use

- Subtasks are independent
- Latency matters
- Work splits by item, source, section, or test
- Need multiple judges or rankings
- Merge step is simple

## Goal

Reduce wall-clock time or improve judgment quality without adding merge risk.

## Rules

- Only parallelize independent work.
- Give each branch stable input.
- Use same output schema for branches.
- Set timeout and retry rules.
- Allow partial-failure policy.
- Merge with deterministic code when possible.
- Cap branch count and cost.

## Patterns

- Sectioning: each branch handles different slice.
- Voting: branches judge same item independently.
- Retrieval: branches query different sources.
- Testing: branches run separate checks.

## Flow

1. Identify independent units.
2. Define branch input and schema.
3. Run branches concurrently.
4. Collect outputs.
5. Normalize results.
6. Merge, vote, or rank.
7. Report branch failures.

## Avoid

- Hidden dependencies between branches.
- Branch output needed by another branch.
- Vague merge logic.
- Duplicate work.
- Ignored partial failures.
- Branch count larger than value.

## Output

```md
## Parallel Plan

Task: [goal]
Split: [sectioning / voting / retrieval / testing]
Branches:
- [branch]: [input], output [schema]

Merge:
- Method: [merge / vote / rank]
- Failure policy: [retry / skip / stop]
- Cost cap: [limit]
```

## Decision Rule

Use parallelization when independence is real and merge is cheap.
If steps depend on each other, use prompt chaining.
