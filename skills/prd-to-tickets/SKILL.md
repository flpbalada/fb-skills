---
name: prd-to-tickets
description: Break a user-provided PRD into ordered, independently verifiable implementation tickets returned directly in the response.
---

# To Tickets

Convert a PRD into implementation tickets.

## Input

The user must provide a PRD or a reference to one.

If no PRD is available, ask the user to provide it and stop. Do not infer a PRD from the conversation.

Read the PRD and any referenced material before creating tickets. Do not ask for information already present.

## Workflow

1. Extract the PRD's required behaviour, constraints, acceptance criteria, dependencies, and unresolved assumptions.
2. Inspect relevant code when it materially improves accuracy. Use only verified project terminology, architecture, patterns, domain concepts, ADRs, and conventions.
3. Give the PRD, relevant context, ticket rules, and output format to exactly two subagents with fixed roles:
   - **Ticket author:** drafts and revises the tickets and task tree.
   - **Coverage reviewer:** independently checks the draft against every PRD requirement. It returns `PASS` or `REVISE` with missing, partial, speculative, or unverifiable coverage and specific correction instructions. It does not rewrite tickets.
4. Run up to five author-review rounds:
   1. The ticket author submits a complete draft.
   2. The coverage reviewer maps every PRD requirement to concrete ticket acceptance criteria.
   3. On `PASS`, stop and return the approved draft.
   4. On `REVISE`, relay the review unchanged to the same ticket author, then send the revision to the same coverage reviewer.
5. Do not replace either subagent or reset its context during the loop.
6. If round five returns `REVISE`, stop and return the last reviewed draft as best effort. State its unresolved coverage gaps in the summary; never claim it passed.

The reviewer may return `PASS` only when:

- every PRD requirement maps to at least one concrete acceptance criterion
- constraints, edge cases, and required verification are covered
- tickets are narrow vertical slices rather than technical-layer tasks
- dependencies are necessary and valid
- the ticket list and task tree agree
- no speculative scope was added

Each ticket must be small enough for one focused coding-agent session, independently implementable after its blockers, and leave the repository valid.

Identify prefactoring that makes the requested change safer or easier, but do not invent architecture. For a wide mechanical refactor, use separate expand, migrate, and contract tickets so the repository remains valid between stages.

## Dependencies

Assign sequential IDs: `T01`, `T02`, `T03`.

Declare `Blocked by: None` or list only tickets that must be completed first.

Return tickets in dependency order.

## Output

Use [OUTPUT.md](OUTPUT.md).
