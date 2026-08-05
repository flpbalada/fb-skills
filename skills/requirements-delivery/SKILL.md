---
name: requirements-delivery
description: Deliver a defined goal and its requirements through orchestrated task decomposition, implementation agents, and independent QA. Use when scope may come from a prompt, specification, issue, referenced documents, or mixed sources and every blocking requirement must be verified before completion.
---

# Requirements Delivery

## Goal

Deliver the complete requested scope from requirements in any format. Success requires independent QA to account for every blocking requirement with concrete evidence. Failed, blocked, or unverified blocking requirements keep delivery active.

## Requirement Sources

The source package may include:

- User goals, requested outcomes, scope, and exclusions
- Requirements and constraints in any format
- Referenced documents, issues, artifacts, or conversations
- Governing repository and environment instructions
- Relevant existing behavior discovered during inspection

The orchestrator reads the complete source package directly. Do not require the input to be converted into a PRD or another document format.

## Roles

### Orchestrator

- Own the delivery baseline, planning, delegation, synthesis, and completion.
- Read the source package and normalize its goal, scope, requirements, constraints, assumptions, dependencies, blockers, and verification expectations.
- Distinguish explicit requirements, necessary derived requirements, and advisory checks.
- Define focused tasks and spawn implementation agents with available delegation tools.
- Resolve dependencies, conflicts, and integration gaps.
- Send the original source package and synthesized delivery to QA.
- Retain responsibility until the success condition is met.

### Implementation Agent

- Own and deliver one defined task.
- Stay within assigned scope.
- Verify delivered behavior.
- Return completed work, changed artifacts, evidence, assumptions, and blockers.
- Request orchestrator approval before expanding scope.

### QA Agent

- Own independent verification of the requirements and synthesized delivery.
- Read the original source package and governing constraints.
- Derive a verification matrix independently before relying on implementation claims.
- Compare its requirements with the orchestrator's delivery baseline and report omissions, conflicts, unsupported inferences, and scope expansion.
- Run relevant tests and checks.
- Record pass, fail, blocked, or not applicable with evidence for every requirement.
- Report defects, gaps, regressions, and unverified claims.
- Reject incomplete or unsupported delivery.

## Workflow

### 1. Normalize and Decompose

The orchestrator creates a delivery baseline from the source package, using stable identifiers and source references where useful. It then creates independent tasks suitable for parallel execution.

Classify baseline items as:

- Explicit: directly stated by an authoritative source
- Necessary: logically required to deliver the goal or satisfy governing constraints
- Advisory: useful quality guidance that does not block completion unless an authoritative source requires it

Explicit requirements and applicable necessary requirements are blocking. Advisory checks are non-blocking unless an authoritative source makes them explicit requirements.

Ask the user when ambiguity changes behavior, scope, irreversible choices, or the meaning of success. Proceed with a documented assumption only when the choice is low-risk, reversible, and does not materially expand scope. Never resolve conflicting authoritative requirements silently.

Each task defines:

- Goal
- Scope
- Dependencies
- Requirements addressed
- Expected output
- Required evidence
- Applicable verification

### 2. Delegate

The orchestrator spawns one implementation agent per independent task. Spawn no more agents than useful.

### 3. Deliver and Synthesize

Implementation agents return their delivery reports. Orchestrator combines the results and resolves conflicts, missing dependencies, and integration gaps.

### 4. Verify

The orchestrator spawns an independent QA agent with the original source package, governing constraints, and delivered artifacts. QA derives its own verification matrix, reconciles it with the delivery baseline, and verifies all blocking requirements.

### 5. Repair

If any blocking requirement fails, is blocked, or remains unverified:

1. Keep goal active.
2. Determine whether implementation or further verification can resolve it.
3. Convert resolvable gaps into follow-up tasks.
4. Spawn implementation agents.
5. Synthesize fixes.
6. Re-run QA on failed and affected requirements.

Repeat until the success condition is met. Escalate conflicting, impossible, or externally blocked requirements to the user instead of looping indefinitely.

## Completion Gate

Delivery is complete only when:

- Every explicit and applicable necessary requirement is accounted for.
- Every blocking requirement passes or is justified as not applicable.
- QA and orchestrator requirement sets are reconciled.
- No unresolved conflict, blocker, or unverified blocking claim remains.
- Residual risks and advisory findings are disclosed.

## Final Output

### Delivery Summary

- Goal and scope delivered
- Tasks completed
- Artifacts changed
- Assumptions and approved scope changes
- Residual risks and blockers

### Verification Matrix

| Requirement | Source | Class | Status | Evidence |
| --- | --- | --- | --- | --- |
| [requirement] | [source] | explicit / necessary / advisory | pass / fail / blocked / not applicable | [proof or reason] |

Evidence may include commands, test results, observed behavior, artifact inspection, screenshots, source citations, calculations, or review records. Include the independent QA conclusion.
