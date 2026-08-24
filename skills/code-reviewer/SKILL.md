---
name: code-reviewer
description: Review code for concrete defects and ranked risk. Use when asked to review diffs, pull requests, changed files, snippets, or implementation plans for bugs, security, performance, UX, API contracts, tests, concurrency, error handling, state/data hazards, accessibility, dependencies, or observability. Produces findings first with file:line evidence. For factual diff explanation use explain-diff; for architecture-only review use architecture-review.
---

# Code Reviewer

## Goal

Report concrete, actionable defects in the reviewed code.

## Rules

- Report findings before summaries.
- Report at most 5 findings, ordered by risk.
- Require code evidence for every finding.
- Use exact `file:line` references when possible.
- Suggest the smallest useful fix.
- Report missing tests only for changed behavior that lacks coverage.

## Priority

Rank in this order:

1. Security.
2. Data loss or corruption.
3. Broken behavior or UX.
4. Performance.
5. Maintainability, only when it is likely to cause defects.

## Flow

1. Inspect the diff, changed files, or provided snippet.
2. Check only smell groups supported by the code and change context.
3. Verify the highest-risk candidates against the code.
4. Report confirmed findings.

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

Code quality:
- Complexity that obscures a defect.
- Harmful duplication.
- Weak error handling.
- `any` that permits an invalid value or contract violation.

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

- Behavior changed without tests: testing, error paths.
- Async, promises, queues, workers: concurrency, errors, performance.
- React, JSX, TSX: accessibility, state, rendering performance.
- Database code: injection, N+1, transactions, indexes.
- API routes: security, contracts, errors, observability.
- `try` / `catch`: error handling, logging, cleanup.
- Config or environment code: secrets, dependency risk, hardcoded values.
- `any`: type safety and contract erosion.
- Tailwind or CSS: accessibility, responsive behavior, visual regressions.
- Refactor signs: behavior drift or a wrong abstraction.

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
