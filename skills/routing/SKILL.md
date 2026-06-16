---
name: routing
description: Classify inputs into specialized prompts, tools, models, agents, or workflows using route labels, confidence, fallback, and misroute review. Use when clear request categories need different handling for cost, latency, safety, quality, or domain. Do not use for sequential steps; use prompt-chaining. Do not use for dynamic decomposition; use orchestrator-workers.
---

# Routing

## When to use

- Inputs fall into clear request categories.
- Categories need different prompts, tools, models, or agents.
- Classification is cheaper than using one large path.
- Cost, latency, safety, or quality differs by route.

## Goal

Classify first.
Send work to the best specialist path.

## Rules

- Start with few routes.
- Make route definitions low-overlap.
- Return route label and confidence.
- Add fallback for low confidence.
- Track misroutes.
- Review route quality, cost, and latency.
- Do not route when categories are fuzzy.
- Do not make router logic harder than the task.

## Flow

1. Define route set.
2. Write route criteria.
3. Classify input.
4. Pick route by label and confidence.
5. Use fallback when confidence is low.
6. Send input to specialist.
7. Return result.
8. Save misroute examples.

## Routing Axes

- Intent type.
- Task complexity.
- Safety level.
- Domain.
- Required tool access.
- Response format.

## Failure Modes

- Too many routes.
- Overlapping route definitions.
- No low-confidence fallback.
- Router prompt leaking to specialists.
- Uneven traffic leaving routes untested.
- No eval set.

## Output

- Route taxonomy.
- Criteria for each route.
- Fallback route.
- Classification format.
- Misroute review plan.
