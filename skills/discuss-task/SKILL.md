---
name: discuss-task
description: Clarify and stress-test ambiguous tasks before action. Use when goal, scope, success criteria, constraints, decisions, or risks are unclear.
---

# Discuss Task

Clarify before acting. Walk decision branches one by one until next action is obvious.

## When to use

- Goal is unclear.
- Scope is unclear.
- Success criteria are missing.
- Constraints or risks may change the answer.
- Decisions depend on each other.
- User asks for planning, requirements, or product thinking.

## Goal

- Define outcome.
- Shape fuzzy requests into strong task prompts.
- Expose assumptions.
- Separate scope from non-goals.
- Make success and failure testable.
- Capture task context, constraints, and done criteria.
- Resolve decision branches in dependency order.
- Recommend answers when asking.
- Use existing code or docs instead of asking when answer is discoverable.

## Rules

- Ask one question at a time by default.
- Ask max 3 only when questions are independent.
- Ask only questions that change scope, priority, risk, or acceptance.
- Include recommended answer for each question.
- Explain recommendation in one short reason.
- Explore codebase when question can be answered from files.
- Prefer gathering missing context from files, docs, errors, examples, and commands before asking.
- Use `question` tool when structured choices help.
- Do not ask same question in tool and markdown.
- If clear enough, stop asking and summarize.
- End with copy-ready task prompt when user needs to hand work off.

## Check

- User.
- Problem.
- Trigger.
- Goal.
- Context: files, folders, docs, errors, examples.
- Success.
- Failure.
- Scope.
- Non-goals.
- Constraints.
- Done when.
- Verification command or behavior check.
- Data or state.
- Edge cases.
- Decision dependencies.
- Reasoning level.
- Recommended path.

## Flow

1. Restate task only if useful.
2. List main gap or assumption.
3. Identify next blocking decision.
4. Answer from code or docs if possible.
5. Shape known details into Goal, Context, Constraints, and Done when.
6. Ask one question with recommended answer.
7. Refine after answer.
8. Repeat until branches are resolved.
9. Stop when next action is obvious.

## First-use prompt frame

When preparing a task prompt, shape it into:

- Goal: desired change or outcome.
- Context: relevant files, folders, docs, errors, examples, and commands.
- Constraints: architecture, style, safety, conventions, and non-goals.
- Done when: checks pass, behavior works, and risk is reviewed.

Ask only for missing fields that change execution.
If missing context is discoverable in the repo, inspect it instead of asking.

## Reasoning hint

- Low: small, well-scoped task.
- Medium or high: unclear task, debugging, multi-file change, or meaningful risk.
- Extra high: long-running, agentic, or reasoning-heavy task.

## Output while clarifying

```md
## Gaps

- [gap or assumption]

## Questions

1. [blocking question]

Recommended: [answer]
Reason: [short reason]
```

## Output when ready

```md
## Summary

- [task outcome]

## Task Prompt

Goal:
- [desired change or outcome]

Context:
- [files, folders, docs, errors, examples, commands]

Constraints:
- [standards, architecture, safety, conventions, non-goals]

Done when:
- [checks pass, behavior works, risk reviewed]

Reasoning:
- [low | medium | high | extra high]

## Requirements

- Given [state], when [action], then [result]

## Notes

- Scope: [in]
- Non-goals: [out]
- Assumptions: [known]
- Next: [smallest useful action]
```
