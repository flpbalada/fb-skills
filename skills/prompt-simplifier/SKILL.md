---
name: prompt-simplifier
description: Review prompts and instructions for logic complexity. Use when simplifying workflows, rules, conditions, or agent prompts.
---

# Prompt Simplifier

Analyze prompt logic.
Preserve intent.
Reduce complexity.

## Rules

- Parse before mapping.
- Map before fixes.
- Flag ambiguity.
- Do not guess.
- Tie every issue to a location.
- Prefer high-impact, low-effort fixes.
- Do not change core behavior.

## Flow

1. Parse conditions, actions, states, dependencies, and assumptions.
2. Map nodes as condition, action, state, or decision.
3. Map edges as then, else, depends on, or leads to.
4. Find dead paths, missing branches, contradictions, impossible transitions, and redundant logic.
5. Check edge cases.
6. Propose simpler alternatives.

## Map Format

```text
A: If X
-> B: Do Y
-> else C: Error
```

## Issue Checks

- Dead paths.
- Missing branches.
- Unhandled edge cases.
- Contradictions.
- Impossible transitions.
- Redundant logic.
- Nesting over 3 levels.
- Logic that can be inverted or flattened.

## Edge Cases

- Empty or null input.
- Boundary input.
- State combinations.
- Order dependence.
- Failure paths.

## Output

```md
## Prompt Analysis: [name]

## Map Summary
- Nodes: [count]
- Edges: [count]
- Max depth: [depth]
- Decisions: [count]

## Complexity
- Score: [1-10]
- Summary: [one line]

## Issues
- [type] [location] - [problem]

## Fixes
- Type: [structural/logical/quality]
- Location: [reference]
- Current: [current logic]
- Proposed: [simpler logic]
- Benefit: [why]
- Confidence: [high/medium/low]

## Questions
- [question or none]
```
