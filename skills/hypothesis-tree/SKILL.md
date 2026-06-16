---
name: hypothesis-tree
description:
  Structure complex questions into testable hypotheses. Use when validating
  product ideas, debugging problems, planning experiments, or breaking down
  ambiguous challenges into actionable research.
---

# Hypothesis Tree

Break a broad question into testable branches.
Use MECE where practical.

## When to use

- Product idea validation.
- Metric diagnosis.
- Experiment planning.
- User research planning.
- Ambiguous strategic question.
- Debugging cause categories.

## Goal

- Turn vague problem into clear question.
- Generate possible explanations.
- Make hypotheses testable.
- Prioritize what to test first.

## Rules

- Start with a specific measurable question.
- Branches should not overlap.
- Branches should cover likely causes.
- Stop decomposing when hypothesis can be tested.
- Prefer 2-3 levels deep.
- Update tree when evidence arrives.
- Avoid proving favorite hypothesis.

## Strong hypothesis

- Specific.
- Testable.
- Falsifiable.
- Actionable.
- Has clear evidence needed.

## Flow

1. Convert vague concern into central question.
2. Create first-level cause categories.
3. Check for overlap and gaps.
4. Decompose each category into testable hypotheses.
5. List current evidence.
6. Prioritize by impact, effort, and uncertainty.
7. Define test plan.

## Example

```text
Question: Why is signup conversion below 30%?
- Awareness: users do not understand value.
- Motivation: benefit does not outweigh effort.
- Ability: signup is too hard.
- Technical: bugs block completion.
```

## Resources

- [The Pyramid Principle - Barbara Minto](https://www.amazon.com/Pyramid-Principle-Logic-Writing-Thinking/dp/0273710516)
- [Bulletproof Problem Solving - Charles Conn](https://www.amazon.com/Bulletproof-Problem-Solving-Changes-Everything/dp/1119553024)

## Output

```md
## Hypothesis Tree

Question: [specific question]

## Branches
- H1: [hypothesis]
  - H1.1: [testable sub-hypothesis]
- H2: [hypothesis]
  - H2.1: [testable sub-hypothesis]

## Priority Tests
- [hypothesis]: [test], [effort], [impact], [owner if known]

## Evidence
- [known evidence]
- [unknowns]
```
