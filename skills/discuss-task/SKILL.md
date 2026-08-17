---
name: discuss-task
description: Build shared understanding before action by interviewing the user about ambiguous implementation, product, planning, or design tasks. Use when goal, scope, constraints, risks, edge cases, success criteria, done state, or next action are unclear; when user wants a thinking partner; or when user needs a handoff-ready task prompt. Do not write PRDs; use to-prd for product requirements.
---

# Discuss Task

Build shared understanding before acting.
Map material uncertainty as a dependency-aware decision tree.

Convert uncertainty into action:

- Surface hidden gaps, assumptions, constraints, risks, edge cases, and failure scenarios.
- Separate facts the agent can discover from decisions the user must make.
- Ask only questions whose prerequisites are settled.
- Stop when no unresolved decision could materially change scope, design, risk, success, or verification.

## Decision States

- **Settled**: resolved by evidence, a user answer, or a delegated agent decision.
- **Frontier**: unresolved, with every prerequisite settled; ready to ask now.
- **Blocked**: waiting on another decision or investigation.
- **Discarded**: made irrelevant by an earlier decision.

## Flow

1. Spawn a sub-agent with [deep-thinker](../deep-thinker/SKILL.md) to analyze the problem before asking the user questions.
2. Inspect discoverable context first: code, docs, errors, examples, commands, data, or state.
3. Build the initial decision tree from the deep-thinker result and inspected context. Include only uncertainty that could materially affect the outcome.
4. Compute the frontier: every unresolved decision whose prerequisites are settled.
5. Ask independent frontier questions together, up to the structured question tool's limit. Give a recommended answer first and one short reason.
6. Do not ask the user for discoverable facts. Investigate them, block only dependent branches, and continue with the rest of the frontier.
7. After each answer or investigation, settle answered nodes, record assumptions, discard irrelevant branches, add newly exposed decisions, and recompute the frontier.
8. Continue until no material frontier or blocked decision remains.
9. Summarize the shared understanding and require explicit user confirmation before acting.
10. After confirmation, route to [to-prd](../to-prd/SKILL.md) by default unless the user requested another next action.

Do not ask the same question in a tool and Markdown.

## Root Cause

Use [INTERVIEW.md](INTERVIEW.md) to check whether the task should switch to [five-whys](../five-whys/SKILL.md).

## Interview

Use [INTERVIEW.md](INTERVIEW.md).

## Output

Use [TEMPLATE.md](TEMPLATE.md).
