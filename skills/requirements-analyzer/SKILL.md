---
name: requirements-analyzer
description: Analyze feature requirements for clarity, scope, risk, assumptions, and testability before implementation. Use when specs are vague, acceptance criteria are missing, edge cases are unclear, or work needs splitting; avoid for writing full user stories or estimating effort only.
---

# Requirements Analyzer

## When to use

- Before building features.
- Before splitting ambiguous work.
- When scope, success criteria, or risks are unclear.
- When requirements need to become testable tasks.

## Goal

Check clarity, scope, feasibility, and risk before implementation.
Turn vague asks into testable requirements.

## Rules

- Match depth to change size.
- Keep requirements specific and testable.
- Separate user need from solution.
- Mark assumptions.
- Identify out-of-scope items.
- Split work over `400 LOC`.
- Prefer `50-200 LOC` per PR.

## Discovery

- Who is the user?
- What goal should be reached?
- Why now?
- What triggers the behavior?
- What happens before and after?
- What means success?
- What means failure?
- What is out of scope?
- What must not change?
- What assumptions exist?
- What needs product answer?

## Flow

1. Identify user, goal, and trigger.
2. Define success and failure.
3. List requirements as testable statements.
4. Check edge cases.
5. Check technical impact.
6. Identify risks and unknowns.
7. Split scope if needed.

## Checks

- Edge cases: empty, null, boundary, invalid, concurrent, expected error.
- Tech impact: data source, transform, state, destination, patterns, new paths.
- Non-functional needs: accessibility, performance, security, reliability, i18n.
- Risks: technical, scope, schedule, quality.
- Scope creep: "while we're at it", "nice to have", blurry boundaries.

## Output

```md
## Who
- [user persona]

## What
- [change summary]

## Why
- [problem solved]

## Requirements
- Given [precondition], when [action], then [outcome].

## Definition Of Done
- [ ] [testable item]

## Risks
- [risk, likelihood, impact, mitigation]
```
