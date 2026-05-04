---
name: routing
description: Send inputs to specialized prompts, tools, or models based on input type. Use when different request classes need different handling paths.
---

# Routing

Anthropic canonical agent pattern.
Classify first.
Then send work to best path.

## What It Is

Use a router to choose among specialists.
Specialist can be prompt, model, tool chain, or agent.
Goal: better fit per request.

## When to Use

- Requests fall into clear categories
- Different categories need different prompts or tools
- Cheap classifier can pick path well
- Specialist path beats one general path
- Need cost or latency control by request type

## When Not to Use

- Categories fuzzy or overlapping
- Generalist path already works
- Misroute cost high
- Too few examples to define routes
- Router logic harder than task

## Core Flow

```text
input
  → classify
  → pick route
    → specialist A
    → specialist B
    → specialist C
  → return result
```

## Simple Implementation Outline

1. Define route set.
2. Write route criteria.
3. Start with few routes.
4. Make router output label + confidence.
5. Add fallback path.
6. Track route accuracy.
7. Review misroutes. Refine criteria.

## Good Routing Axes

- Intent type
- Task complexity
- Safety level
- Domain
- Required tool access
- Response format

## Failure Modes

- Too many routes. Hard to maintain.
- Route definitions overlap.
- No fallback for low confidence.
- Router prompt leaks to specialists.
- Uneven traffic. Some routes rot.
- No eval set. Misroutes stay hidden.

## Practical Checklist

- Clear route taxonomy
- Low-overlap route definitions
- Confidence or abstain option
- Fallback path exists
- Per-route prompts tested
- Misroute examples saved
- Metrics by route: quality, cost, latency
- Periodic route review

## Decision Rule

Use routing when specialization wins and classification is cheap enough.
If cases blur together, keep one path.
