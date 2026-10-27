---
name: discuss-task
description: Build shared understanding before action by interviewing the user about ambiguous implementation, product, planning, or design tasks. Use when goal, scope, constraints, risks, edge cases, success criteria, done state, or next action are unclear; when user wants a thinking partner; or when user needs a handoff-ready task prompt. Use to-prd for a full PRD or to-spec for a short specification.
---

# Discuss Task

Build shared understanding before acting.
Map material uncertainty as a dependency-aware decision tree.

Convert uncertainty into action:

- Surface hidden gaps, assumptions, constraints, risks, edge cases, and failure scenarios.
- Separate facts the agent can discover from decisions the user must make.
- Ask only questions whose prerequisites are settled.
- Finish when all material questions are settled, discarded, or explicitly deferred, including branches blocked by deferred questions.

## Knowledge Map

Organize shared understanding into four categories:

- **Known knowns**: evidence-backed facts and settled decisions, with their source or reason.
- **Known unknowns**: explicit unanswered questions, including deferred questions and blocked branches, with their impact and next step.
- **Unknown knowns**: relevant knowledge someone holds but has not made explicit, such as domain rules, terminology, or existing workarounds. Record what needs surfacing and who or what can confirm it, without claiming an answer.
- **Unknown unknowns**: limits of discovery and checks that could reveal blind spots. Do not invent hidden problems or claim all unknowns are covered. Move any concrete question discovered here to known unknowns.

Once implicit knowledge is confirmed, move it to known knowns. Keep unverified assumptions in known unknowns unless the user explicitly accepts them, then label them as accepted assumptions, not verified facts.
The knowledge categories organize the summary. Decision states still control which questions can be asked and which work remains blocked.

## Decision States

- **Settled**: resolved by evidence, a user answer, or a delegated agent decision.
- **Frontier**: unresolved, with every prerequisite settled; ready to ask now.
- **Blocked**: waiting on another decision or investigation.
- **Deferred**: the user does not know yet or needs stakeholder input, research, or LLM help. Remains open, not an assumed answer.
- **Discarded**: made irrelevant by an earlier decision.

## Flow

1. Spawn a sub-agent with [deep-thinker](../deep-thinker/SKILL.md) to analyze the problem before asking the user questions.
2. Inspect discoverable context first: code, docs, errors, examples, commands, data, or state.
3. Build the initial decision tree from the deep-thinker result and inspected context. Include only uncertainty that could materially affect the outcome.
4. Compute the frontier: every unresolved, non-deferred decision whose prerequisites are settled.
5. Ask independent frontier questions together, up to the structured question tool's limit. Give a recommended answer first and one short reason. Always allow “I don't know yet” as an answer.
6. Do not ask the user for discoverable facts. Investigate them, block only dependent branches, and continue with the rest of the frontier.
7. After each answer or investigation, settle answered nodes, defer unknown answers, record assumptions, discard irrelevant branches, add newly exposed decisions, and recompute the frontier. Do not repeat deferred questions without new evidence or a user request.
8. Continue through independent questions until only deferred questions and branches blocked by them remain, or all material questions are resolved.
9. Summarize the shared understanding using the four knowledge categories. Include every remaining open question and implicit knowledge gap with its dependency and next step. Require explicit user confirmation before acting. Confirmation alone does not resolve open questions or authorize assumptions for dependent work.
10. After confirmation, run the agreed next action: [to-prd](../to-prd/SKILL.md) for a full PRD with technical implementation once material questions are resolved, or [to-spec](../to-spec/SKILL.md) for a short specification that can retain open questions. Honor another next action explicitly requested by the user.

Do not ask the same question in a tool and Markdown.

## Root Cause

Use [INTERVIEW.md](INTERVIEW.md) to check whether the task should switch to [five-whys](../five-whys/SKILL.md).

## Interview

Use [INTERVIEW.md](INTERVIEW.md).

## Output

Use [TEMPLATE.md](TEMPLATE.md).
