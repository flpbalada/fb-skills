---
name: to-milestones
description: Break a PRD into linear, verifiable implementation milestones grounded in the codebase. Use when planning implementation checkpoints from product requirements.
---

# Convert PRD to Milestones

## Workflow

1. Extract required behavior, priorities, constraints, acceptance criteria, dependencies, and open questions from the PRD.
2. Inspect the affected code paths, data flow, integrations, tests, and reusable patterns.
3. Ask focused questions when inputs are missing, the PRD conflicts with the codebase, or sequencing requires an unresolved decision. Do not invent decisions.
4. Draft one linear sequence ordered by dependencies, then priority and risk.
5. Make each milestone the smallest useful vertical slice with an observable result. It may depend only on external prerequisites or earlier milestones.
6. Ensure the sequence covers every required outcome and each milestone can be verified after earlier milestones without requiring later ones.
7. State the command or behavior check that verifies each milestone.

## Output

Use the [response template](./RESPONSE.md).
