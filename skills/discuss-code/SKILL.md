---
name: discuss-code
description: Critically discuss code issues with compact findings. Use when code needs review for logic, simplicity, structure, naming, or maintainability.
---

# Discuss Code

Discuss code critically, clearly, and compactly.

## Input

- Target file, diff, snippet, or code area provided by the user.

## Goal

- Find real issues in logic, simplicity, structure, and naming.
- Explain each issue in plain language.
- Suggest the smallest useful improvement.
- Avoid praise unless there are no findings.

## Check

- Correctness
- Unnecessary logic
- Duplication
- Abstraction quality
- Complexity and nesting
- Naming
- Dead code
- Missed simpler patterns

## Skill Hints

- Refactor or abstraction: `code-architecture-wrong-abstraction`
- TypeScript: `typescript-best-practices`, `typescript-interface-vs-type`, `typescript-advanced-types`, `typescript-satisfies-operator`
- React: `react-useeffect-avoid`, `react-use-state`, `react-use-client-boundary`, `react-key-prop`
- Naming: `naming-cheatsheet`

## Output

- Start with `Verdict: good | mixed | bad`.
- Then list findings, highest impact first.
- Max 5 findings.
- Use this format for each finding:

```md
## Finding N: short title
What: concrete issue in code
Why: impact or risk in one short line
Suggestion: smallest useful fix
Reference: `file:line` or quoted snippet
```

- If no findings, say `No findings.` then mention residual risk or missing context.
- Show code only when it makes the suggestion much clearer.
- List only relevant skills at the end.
- Keep the whole reply compact and easy to scan.
