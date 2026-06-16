---
name: code-reviewer
description: Review code for concrete defects and ranked risk. Use when asked to review diffs, pull requests, changed files, snippets, or implementation plans for bugs, security, performance, UX, API contracts, tests, concurrency, error handling, state/data hazards, accessibility, dependencies, or observability. Produces findings first with file:line evidence. For discussion without full review depth use discuss-code; for architecture-only review use architecture-review.
---

# Code Reviewer

## Overview

Review like a senior engineer.
Assume real issues may exist.
Find evidence, rank risk, and stay concise.

## Rules

- Review before suggesting fixes.
- Findings first.
- Highest risk first.
- Maximum 5 findings.
- No praise unless there are no findings.
- No speculative issues without code evidence.
- Use exact `file:line` references when possible.
- Prefer small fixes over broad rewrites.
- Mention missing tests only when changed behavior needs coverage.

## Priority

Rank in this order:

1. Security.
2. Performance.
3. Broken UX.
4. Bugs.
5. Nits.

## Flow

1. Analyze diff, changed files, or provided snippet.
2. Detect file types, frameworks, and risky code patterns.
3. Select relevant smell groups.
4. Apply general code review.
5. Deep-dive top 5 risks.
6. Output what, where, and why.

## Smell Groups

Security:
- Auth gaps.
- IDOR.
- Injection.
- Weak crypto or random values.
- Secrets in code or logs.
- SSRF.
- Weak input validation.

Performance:
- N+1 queries.
- Missing indexes.
- Blocking sync I/O or API calls.
- Unbounded lists.
- Missing pooling or rate limits.

Architecture:
- SRP or OCP violations.
- God objects.
- Anemic models.
- Shotgun surgery.
- Feature envy.

Code quality:
- High complexity.
- Nested conditionals.
- Long functions.
- Harmful duplication.
- Weak error handling.
- Poor names.
- `any` abuse.

Testing:
- Changed paths untested.
- Missing edge cases.
- Missing failure cases.

API:
- Breaking contract.
- Missing schema validation.
- Inconsistent errors.

Concurrency:
- Races.
- Deadlocks.
- Missed async errors.
- Leaks.
- Unhandled rejections.
- Shared mutable async state.

Error handling:
- Swallowed exceptions.
- Generic catches.
- Low-context errors.
- Silent failures.
- Missing cleanup.

Data and state:
- Global mutable state.
- Argument mutation.
- Magic values.
- Null or undefined hazards.
- Stale cache.

Accessibility:
- Missing labels.
- Keyboard gaps.
- Color-only signals.
- Missing alt text.
- Focus bugs.
- Low contrast.
- Unlabeled inputs.
- Missing skip links.

Dependencies:
- Unused dependencies or imports.
- Known vulnerable packages.
- Duplicate libraries.
- Import side effects.

Observability:
- Missing logs on critical paths.
- No metrics or tracing.
- Hardcoded config.
- Unstructured logs.

## Context Triggers

Adjust review focus by evidence:

- Tests changed or missing: testing, error paths.
- Async, promises, queues, workers: concurrency, errors, performance.
- React, JSX, TSX: accessibility, state, rendering performance.
- Database code: injection, N+1, transactions, indexes.
- API routes: security, contracts, errors, observability.
- `try` / `catch`: error handling, logging, cleanup.
- Config or environment code: secrets, dependency risk, hardcoded values.
- `any`: type safety and contract erosion.
- Tailwind or CSS: accessibility, responsive behavior, visual regressions.
- Refactor signs: wrong abstraction, shotgun surgery, behavior drift.

## Related Skills

Load these only when the reviewed code makes them relevant:

- `.ts`, `.tsx`: `typescript-interface-vs-type`, `typescript-advanced-types`, `typescript-best-practices`.
- `.tsx`, `.jsx`: `react-key-prop`, `react-useeffect-avoid`, `react-use-state`.
- CSS or SCSS: `css-container-queries`.
- Tailwind: `code-architecture-tailwind-v4-best-practices`.
- Refactor or abstraction concerns: `code-architecture-wrong-abstraction`.
- Architecture-wide concerns: `architecture-review`.

## Output

For each finding:

```md
## Finding N: [short title]
What: [concrete issue]
Where: `[file:line]`
Why: [impact or risk]
Fix: [smallest useful fix]
```

If no findings:

```md
No findings.
Residual risk: [missing context, unrun checks, or test gap]
```
