---
name: architecture-review
description: Review software architecture before editing. Use when asked to assess module boundaries, interfaces, layering, ownership, seams, adapters, locality, coupling, shallow modules, or refactor candidates. Produces ranked architecture candidates and waits for explicit approval before changing code. For normal code review use code-reviewer; for approved behavior-preserving edits use refactoring.
---

# Architecture Review

Review architecture.
Refactor only after explicit approval.

## When to Use

- User asks for architecture review.
- Code structure, module boundaries, or interfaces feel wrong.
- Refactor candidates need ranking.
- Existing changes need architectural review.

## Goal

Find structural friction.
Explain impact.
Offer small refactor candidates.
Wait for approval before edits.

## Rules

- Review only the requested path or file set.
- If no target is provided, review thread changes.
- If thread changes are unclear, use current git diff.
- If scope is still unclear, ask.
- Do not broaden scope without asking.
- Preserve behavior unless user approves behavior change.
- Approval for one candidate does not approve other edits.
- Respect ADRs in `docs/adr/` when present.

## Concepts

Use these terms when useful:

- Module.
- Interface.
- Implementation.
- Depth.
- Seam.
- Adapter.
- Leverage.
- Locality.

Prefer project terms from `CONTEXT.md` when present.

## Flow

1. Inspect target scope.
2. Read relevant context and ADRs.
3. Find architectural friction.
4. Apply deletion test to shallow modules.
5. Look for deeper modules, smaller interfaces, clearer seams, and better locality.
6. Present up to 5 candidates.
7. Wait for explicit approval.
8. Refactor only approved candidate.
9. Verify when feasible.
10. Report changes, checks, and risks.

## Candidate Format

```md
## Candidate N: [short title]
Files: `[path]`
Problem: [friction]
Solution: [plain English change]
Benefits: [locality, leverage, testability]
Risk: [behavior, churn, ADR conflict, or None]
```

## Output After Edits

```md
## Changes
- [file]: [what changed and why]

## Verification
- [command]: [result]

## Notes
- [risk, assumption, follow-up, or None]
```
