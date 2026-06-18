---
name: prd-goal-delivery
description: Drive PRD implementation through a durable /goal, scoped parallel implementation agents, independent QA ownership, acceptance evidence, and persona-based test instructions. Use when a PRD must be delivered end-to-end and every acceptance criterion must be verified before marking the goal complete.
---

# PRD Goal Delivery

## Goal

Create new `/goal` for this PRD:

> Deliver every acceptance criterion successfully.

## First Pass

- Read PRD.
- Extract scope.
- Extract acceptance criteria.
- Define evidence required for each criterion.
- Identify target personas affected by new functionality.

## Agent Setup

Spawn parallel agents for independent workstreams.
Use as many agents as useful, no more.

Give each agent:

- Dedicated `/goal`.
- Clear scope.
- Expected output.
- Evidence required.

### Required Agents

| Agent | Responsibility |
| --- | --- |
| **Implementation agents** | Build independent pieces. |
| **QA agent** | Own independent quality verification. |

## QA Responsibilities

QA agent must:

- Build acceptance checklist from PRD.
- Verify each criterion with precise evidence.
- Run or request tests/checks.
- Reject incomplete or unverified work.
- Report gaps, risks, regressions.

## Completion Gate

Do not mark `/goal` complete until:

- [ ] All implementation results are synthesized.
- [ ] QA confirms every acceptance criterion passes.
- [ ] Final answer includes acceptance checklist with status and evidence.
- [ ] Final answer includes persona-based test instructions.

## Final Answer Format

### Acceptance Checklist

| Criterion | Status | Evidence |
| --- | --- | --- |
| [criterion] | pass / fail | [command, output, screenshot, file, or behavior proof] |

### Persona Test Instructions

For each affected persona, include:

- **Persona name / role:** [name and role]
- **Goal:** [goal user wants to achieve]
- **Steps:** [steps to test new functionality]
- **Expected result:** [expected result per step]
- **Edge cases / failure states:** [states user should try]

## Failure Loop

If any criterion fails:

- Keep `/goal` active.
- Dispatch follow-up fix agent.
- Re-run QA on failed criteria.
