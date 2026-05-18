---
name: making-product-decisions
description:
  Framework for structured product decision-making. Use when facing complex
  tradeoffs, aligning stakeholders, documenting decisions, or choosing between
  multiple valid approaches.
---

# Making Product Decisions

Make product decisions explicit.
Separate decision quality from outcome.

## When to Use

- Multiple valid options exist
- Stakes are high
- Tradeoffs are unclear
- Stakeholders disagree
- Decision should be reviewed later

## Goal

Choose option with rationale, owner, success criteria, and review date.

## Rules

- Define decision before debating options.
- Include status quo.
- Avoid binary framing.
- Create at least 3 options.
- Decide faster for reversible choices.
- Slow down for irreversible choices.
- Set criteria before scoring.
- Capture dissent.

## Decision Types

- Type 1: hard to reverse, high stakes, decide carefully.
- Type 2: reversible, lower stakes, decide quickly.

## Flow

1. State exact decision.
2. Name decision maker.
3. Identify deadline and reversibility.
4. Generate options.
5. Define criteria and weights.
6. Compare options.
7. Choose.
8. Record rationale, risks, dissent, metrics.
9. Set review date.

## Output

```md
## Product Decision Record

Decision: [what is decided]
Owner: [decision maker]
Date: [date]
Status: [proposed / approved / implemented]
Type: [Type 1 / Type 2]

Context:
- Problem: [problem]
- Constraints: [constraints]
- Deadline: [date]

Options:
- Status quo: [summary]
- Option A: [summary]
- Option B: [summary]

Criteria:
- [criterion]: weight [1-5]

Decision:
- Chosen: [option]
- Rationale: [why]
- Risks: [main risks]
- Dissent: [concerns]

Success:
- Metric: [metric]
- Target: [value]
- Review date: [date]
```
