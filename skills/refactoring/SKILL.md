---
name: refactoring
description: Plan and apply behavior-preserving code refactors. Use when restructuring code or improving maintainability without changing behavior.
---

# Refactoring

Improve structure.
Keep behavior same.
Avoid breaking changes.

## Use When

- Restructure code.
- Cut complexity.
- Improve maintainability.
- Apply framework or language best practices.
- Improve types or organization.
- Preserve existing behavior.

## Inputs

- Target files, components, modules, or changed code.
- Desired outcome or pain point.
- Constraints and behavior that must not change.

## Flow

1. Analyze target code.
2. Identify goal, constraints, patterns, and anti-patterns.
3. Load relevant skills only when they materially improve the refactor.
4. Define smallest safe steps.
5. Apply changes incrementally.
6. Verify behavior is unchanged.

## Skill Hints

- Naming issues: `naming-cheatsheet`.
- Abstraction issues: `code-architecture-wrong-abstraction`.
- React: `react-use-state`, `react-useeffect-avoid`, `react-use-client-boundary`.
- TypeScript: `typescript-best-practices`, `typescript-interface-vs-type`, `typescript-satisfies-operator`.
- Project layout: `project-structure`.

## Rules

- Preserve behavior.
- Make incremental changes.
- Follow project conventions.
- Keep changes minimal.
- Avoid over-refactoring.
- Do not change behavior without request.
- Do not refactor for little gain.
- Do not skip verification when verification is available.

## Output

```md
## Refactor
- [changed area]

## Behavior
- [behavior preserved]

## Verification
- [check run or reason not run]
```
