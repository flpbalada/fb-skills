---
name: prd-delivery
description: Deliver a PRD through orchestrated task decomposition, implementation agents, and independent QA. Use when every acceptance criterion must be verified before completion.
---

# PRD Delivery

## Goal

Deliver complete PRD scope. Success requires QA to independently pass every acceptance criterion with concrete evidence. Failed, blocked, or unverified criteria keep delivery active.

## Roles

### Orchestrator

- Own planning, delegation, synthesis, and completion.
- Extract PRD scope and acceptance criteria before delegation.
- Define tasks with the Task tool and spawn implementation agents.
- Resolve dependencies, conflicts, and integration gaps.
- Send synthesized delivery to QA.
- Retain responsibility until the success condition is met.

### Implementation Agent

- Own and deliver one defined task.
- Stay within assigned scope.
- Verify delivered behavior.
- Return completed work, changed files, evidence, and blockers.
- Request orchestrator approval before expanding scope.

### QA Agent

- Own independent verification of the synthesized delivery.
- Build the acceptance checklist from the PRD.
- Run relevant tests and checks.
- Record pass or fail with evidence for every criterion.
- Report defects, gaps, regressions, and unverified claims.
- Reject incomplete or unsupported delivery.

## Workflow

### 1. Extract and Decompose

Orchestrator extracts scope, non-goals, acceptance criteria, dependencies, risks, and required evidence. It then creates independent tasks suitable for parallel execution.

Each task defines:

- Goal
- Scope
- Dependencies
- Acceptance criteria
- Expected output
- Required evidence
- Verification commands

### 2. Delegate

Orchestrator uses the Task tool to spawn one implementation agent per independent task. Spawn no more agents than useful.

### 3. Deliver and Synthesize

Implementation agents return their delivery reports. Orchestrator combines the results and resolves conflicts, missing dependencies, and integration gaps.

### 4. Verify

Orchestrator spawns an independent QA agent to verify the synthesized delivery.

### 5. Repair

If any criterion fails:

1. Keep goal active.
2. Convert failures into follow-up tasks.
3. Spawn implementation agents.
4. Synthesize fixes.
5. Re-run QA on failed and affected criteria.

Repeat until the success condition is met.

## Final Output

### Delivery Summary

- Scope delivered
- Tasks completed
- Files changed
- Known risks

### Acceptance Checklist

| Criterion | Status | Evidence |
| --- | --- | --- |
| [criterion] | pass / fail | [command, output, screenshot, file, or behavior proof] |

Include commands, test results, manual checks, and QA conclusion as evidence in the checklist or delivery summary.
