---
name: discuss-code
description: Critically discuss code issues with compact findings. Use when code needs review for logic, simplicity, structure, naming, or maintainability.
---

# Discuss Code

Review code critically.
Focus on real issues.
Keep output compact.

## When to use

- User asks to review code, diff, snippet, or design.
- Code may have logic, naming, structure, or maintainability issues.
- User wants discussion before or instead of edits.

## Goal

- Find concrete problems.
- Explain impact plainly.
- Suggest smallest useful fix.
- Avoid praise unless there are no findings.

## Rules

- Findings first.
- Highest impact first.
- Max 5 findings.
- No speculative issues without evidence.
- Reference file and line when possible.
- Show code only when it clarifies fix.

## Check

- Correctness.
- Unneeded logic.
- Duplication.
- Weak abstraction.
- Nesting and complexity.
- Naming.
- Dead code.
- Missed simple pattern.

## Flow

1. Read user-provided code or target.
2. Identify behavior and intent.
3. Check for bugs and maintainability risks.
4. Rank findings by impact.
5. Suggest minimal fixes.

## Output

```md
Verdict: good | mixed | bad

## Finding N: short title
What: concrete issue
Why: impact or risk
Suggestion: smallest useful fix
Reference: `file:line` or snippet
```

If no findings:

```md
Verdict: good
No findings.
Residual risk: [missing context or test gap]
```

## Related skills

- `code-architecture-wrong-abstraction`
- `typescript-best-practices`
- `react-useeffect-avoid`
- `naming-cheatsheet`
