---
name: prompt-simplifier
description: Simplify prompts, system instructions, workflows, rules, and agent playbooks while preserving behavior. Use when logic has too many branches, nested conditions, contradictions, repeated rules, vague failure paths, or inconsistent outputs. Do not rewrite product requirements; use to-prd for PRD conversion.
---

# Prompt Simplifier

Preserve intent.
Reduce logic complexity.
Make instructions easier to follow.

## When to Use

- Prompt has many rules or branches
- Workflow feels hard to execute
- Conditions conflict or overlap
- Agent output is inconsistent
- Instructions need shorter structure

## Goal

Keep behavior.
Remove unnecessary complexity.
Expose ambiguity.

## Rules

- Parse before changing.
- Preserve core behavior.
- Do not guess missing intent.
- Flag ambiguity.
- Prefer headings, bullets, and short paragraphs.
- Flatten nested logic.
- Remove redundant rules.
- Tie issues to locations when reviewing.

## Flow

1. Parse conditions, actions, states, dependencies, assumptions.
2. Map key logic.
3. Find contradictions, dead paths, missing branches, repetition.
4. Check edge cases.
5. Rewrite with simpler sections.
6. Verify behavior is preserved.

## Complexity Checks

- Dead paths.
- Missing branches.
- Contradictions.
- Impossible transitions.
- Redundant rules.
- Nesting over 3 levels.
- Order dependence.
- Unclear failure path.

## Rewrite Pattern

Prefer:

- When to use
- Goal
- Rules
- Flow
- Output
- Checks

Avoid deep tables, large diagrams, repeated examples, mixed policy/examples, and long paragraphs.

## Output

```md
## Prompt Simplification

Target: [prompt/section]
Preserved intent:
- [intent]

Problems:
- [location]: [issue]

Changes:
- [simplification]

Open questions:
- [ambiguity or none]

Risk:
- [behavior that may need review]
```
