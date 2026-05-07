---
name: requirements-analyzer
description: Analyze feature requirements for clarity, scope, risk, and testability. Use before building features or splitting ambiguous work.
---

# Requirements Analyzer

Check clarity, scope, feasibility, and risk before implementation.

## Depth

- Quick: bug fix or small change.
- Standard: feature or medium change.
- Deep: large feature or architecture change.

## Scope Rules

- Target `50-200 LOC` per PR.
- Split work over `400 LOC`.
- Common splits: foundation, API/data, UI, integration.

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

## Validation

- Requirements must be specific.
- Requirements must be testable.
- Requirements must be independent where possible.
- Requirements must be measurable where useful.

## Edge Cases

- Empty input.
- Null or missing data.
- Boundary values.
- Invalid input.
- Concurrent actions.
- Expected errors.
- Unexpected user actions.

## Tech Check

- Change type: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, or `perf`.
- Data source, transform, state, and destination.
- Existing patterns to reuse.
- New code paths.
- Refactor needed before feature work.
- Non-functional needs: accessibility, performance, security, reliability, i18n.

## Risk Check

- Technical risk.
- Scope risk.
- Schedule risk.
- Quality risk.
- Scope creep signs: `while we're at it`, `nice to have`, blurry boundaries.

## Skill Hints

- Requirements: `user-story-fundamentals`, `jobs-to-be-done`, `theme-epic-story`.
- Analysis: `five-whys`, `hypothesis-tree`, `graph-thinking`.
- Product: `making-product-decisions`.
- UX: `cognitive-load`, `hicks-law`, `progressive-disclosure`.
- React: `react-use-state`, `react-key-prop`, `react-use-client-boundary`.
- TypeScript: `typescript-interface-vs-type`, `typescript-advanced-types`, `typescript-satisfies-operator`.
- Structure: `project-structure`, `naming-cheatsheet`.

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
