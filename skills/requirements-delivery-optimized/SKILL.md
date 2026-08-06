---
name: requirements-delivery-optimized
description: Deliver a defined goal through orchestrated implementation and independent QA. Use when work should be delegated, tested against Given/When/Then requirements, and repaired until it passes.
---

# Requirements Delivery Optimized

## Goal

Deliver the requested work through a simple loop: define requirements, delegate implementation, run independent QA, and repair any issues.

## Roles

### Orchestrator

The orchestrator coordinates the work and formats the user's agreed scope as requirements. It does not edit implementation files or invent requirements.

It must:

- Read the user's agreed scope and relevant project context.
- Ask the user to resolve missing or ambiguous scope before implementation.
- Translate only the agreed scope into clear Given/When/Then requirements.
- Give relevant requirements to every agent.
- Delegate implementation and repairs.
- Send completed work to QA.
- Repeat the implementation and QA cycle until QA passes.

### Implementation Agents

Implementation agents make the required changes. Give each agent focused scope and the relevant Given/When/Then requirements.

Each agent must return:

- What it changed.
- Which requirements it addressed.
- Verification it ran.
- Any blockers or assumptions.

### QA Agent

The QA agent independently tests the completed output against all Given/When/Then requirements. It must not edit implementation files.

The QA agent returns:

- Passed requirements.
- Failed requirements with clear issues and reproduction details.
- Verification performed.
- A final pass or fail result.

## Requirements Format

The user must provide and agree to the scope before implementation starts. The orchestrator translates that scope into observable scenarios without adding inferred behavior, constraints, or outcomes:

```text
Requirement: [short outcome]
Given [starting context]
When [action or event]
Then [observable result]
```

Split requirements when one scenario contains unrelated outcomes. If the scope appears incomplete or conflicts with project constraints, ask the user instead of adding requirements.

## Workflow

1. The orchestrator confirms that the user has provided and agreed to the scope.
2. The orchestrator translates the agreed scope into Given/When/Then requirements without expanding it.
3. The orchestrator delegates the requirements to implementation agents.
4. Implementation agents complete and verify the work.
5. The orchestrator gives the requirements and completed output to an independent QA agent.
6. If QA finds issues, the orchestrator sends the failed requirements and QA details to implementation agents for repair.
7. QA tests the repaired output again.
8. Repeat steps 6 and 7 until QA passes or a blocker requires user input.

## Completion

Finish only when QA passes every requirement.

The final response includes:

- A short summary of the delivered work.
- The Given/When/Then requirements.
- Verification performed.
- The QA result.
- Any remaining blockers or risks.
