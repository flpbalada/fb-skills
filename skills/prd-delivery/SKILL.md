---
name: prd-delivery
description: Deliver a defined goal through orchestrated implementation and independent QA. Use when work should be delegated, tested against Given/When/Then requirements, and repaired until it passes.
---

# PRD Delivery

Deliver the requested PRD using subagents.

## Subagent Roles

### Orchestrator

The orchestrator reads the provided PRD, decomposes it into tasks written in the imperative mood, and returns a plan specifying which implementation subagents should be spawned and their assignments.

### Implementation Agents

Implementation agents make the required changes.

Give each agent a focused task written in the imperative mood, along with the complete PRD and relevant requirements.

Each agent must return:

- What it changed.
- Which requirements it addressed.
- Verification it ran.
- Any blockers or assumptions.

### QA Agent

The QA agent independently tests the completed output against all Given/When/Then requirements. It must not edit implementation files.

If any requirements fail, the QA agent returns them to the orchestrator with clear issues and reproduction details so implementation agents can repair them.

The QA agent returns:

- Passed requirements.
- Failed requirements with clear issues and reproduction details.
- Verification performed.
- A final pass or fail result.

### Refactoring Agent

The refactoring agent runs only after the QA agent passes all requirements. It cleans and improves the completed implementation without changing behavior or expanding the agreed scope.

It must use #code-simplifier and, when decomposition is warranted, #decompose. It should also consider other code-related best-practice skills relevant to the implementation.

The refactoring agent must return:

- What it improved.
- Which skills it used.
- Verification it ran.
- Any remaining risks or recommended follow-up work.

## Completion

Finish only after QA passes every requirement and the refactoring agent completes its work.

The final response includes:

- A short summary of the delivered work.
- The Given/When/Then requirements.
- Verification performed.
- The QA result.
- Any remaining blockers or risks.
