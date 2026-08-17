# Interview

## Coverage

Build decision branches for material uncertainty about:

- Goal, trigger, affected users, and desired outcome.
- Scope and non-goals.
- Actors, domain terms, behavior, and state transitions.
- Hidden assumptions, constraints, dependencies, and trade-offs.
- Risks, edge cases, failure behavior, and recovery.
- Success, failure, and done criteria.
- Verification commands or behavior checks.
- Delivery path and next action.

A gap is material when its answer could change scope, design, risk, success, or verification. Do not pursue immaterial branches.

## Facts and Decisions

- Inspect relevant files, docs, errors, examples, commands, data, and state before asking.
- Investigate discoverable facts instead of asking the user.
- Ask the user for product, scope, preference, and trade-off decisions.
- If the user delegates a decision, settle it with the recommended answer and record the reason.
- When repository evidence contradicts an answer, surface the conflict as a frontier decision.

## Rounds

1. Mark each decision as settled, frontier, blocked, or discarded.
2. Ask frontier decisions together up to the structured question tool's limit.
3. Put the recommended option first and give one short reason.
4. Keep decisions blocked when they depend on an unresolved answer or investigation.
5. Recompute the tree after every round.
6. Stop when no material frontier or blocked decision remains.

## Root Cause

Ask when the task may need root-cause analysis:

- Is this a recurring problem, incident, churn, delay, unclear bug, process failure, or unexplained outcome?
- Is the problem specific enough to investigate?
- What evidence, cause chain, fixes, or success metrics are missing?

Use [five-whys](../five-whys/SKILL.md) when answers show the task needs cause-chain analysis.
Return to discuss-task only if scope, constraints, done state, or next action is still unclear.
