---
name: parallelization
description: Run independent LLM subtasks at same time, then combine results. Use when work can split into isolated parts or multiple judges can score in parallel.
---

# Parallelization

Anthropic canonical agent pattern.
Split work.
Run branches at same time.
Join later.

## What It Is

Break a task into independent units.
Run units concurrently.
Aggregate outputs into one result.

Two common forms:

- Sectioning: each branch handles different slice
- Voting: multiple branches score same thing

## When to Use

- Subtasks independent
- Latency matters
- Task naturally splits by item or section
- Need ensemble scoring or ranking
- Join step is simple and deterministic

## When Not to Use

- Branches need shared evolving context
- One branch output changes another
- Coordination cost high
- Model rate limits kill concurrency gains
- Merge logic too complex

## Core Flow

```text
input
  → split
  → run branch A || branch B || branch C
  → collect outputs
  → merge / vote / rank
  → output
```

## Simple Implementation Outline

1. Find independent units.
2. Define stable input per unit.
3. Run branches concurrently.
4. Set timeout and retry rules.
5. Normalize branch outputs.
6. Merge with deterministic code when possible.
7. Log per-branch failures.

## Good Split Patterns

- One document chunk per branch
- One candidate answer per judge
- One tool query per source
- One test case per worker

## Failure Modes

- Hidden dependency between branches
- Merge step uses brittle prompt
- Duplicate work across branches
- Long-tail branch dominates latency
- Partial failures ignored
- Cost balloons with branch count

## Practical Checklist

- Work units truly independent
- Shared schema across branches
- Timeout per branch
- Retry and partial-fail policy
- Merge logic clear
- Concurrency fits rate limits
- Cost cap set
- Baseline against serial run

## Decision Rule

Use parallelization when independence is real and join logic is cheap.
If branches talk to each other, use another pattern.
