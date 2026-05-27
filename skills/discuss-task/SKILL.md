---
name: discuss-task
description: Clarify and stress-test ambiguous tasks before action. Use when goal, scope, success criteria, constraints, decisions, or risks are unclear.
---

# Discuss Task

Interview user before acting. Build shared understanding by walking decision
branches one by one until next action is obvious.

## When to use

- Goal is unclear.
- Scope is unclear.
- Success criteria are missing.
- Constraints or risks may change the answer.
- Decisions depend on each other.
- User asks for planning, requirements, or product thinking.
- User needs thinking partner before implementation.

## Goal

- Define outcome.
- Build shared knowledge between user and assistant.
- Interview user until assumptions, context, and intent are explicit.
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
- Prefer interview questions over early summarizing when shared context is thin.
- Do not stop after first plausible answer; probe missing context, tradeoffs, and intent.
- Confirm important inferred assumptions before treating them as settled.
- Include recommended answer for each question.
- Explain recommendation in one short reason.
- Explore codebase when question can be answered from files.
- Prefer gathering missing context from files, docs, errors, examples, and commands before asking.
- Use `question` tool when structured choices help.
- Do not ask same question in tool and markdown.
- If clear enough, stop asking and summarize.
- Clear enough means user intent, constraints, success, risks, and next action are shared.
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

## Interview focus

Use questions to uncover shared knowledge:

- What user wants.
- Why user wants it.
- What changed or triggered task.
- Existing attempts, constraints, and preferences.
- Hidden tradeoffs.
- Risk tolerance.
- What good looks like.
- What bad outcome must be avoided.
- Who or what is affected.
- What can be decided now.
- What must stay flexible.

## Flow

1. Restate task only if useful.
2. List main gap or assumption.
3. Identify next blocking decision.
4. Answer from code or docs if possible.
5. Ask one interview question with recommended answer.
6. Refine shared understanding after answer.
7. Probe next dependency, tradeoff, or assumption.
8. Shape known details into Goal, Context, Constraints, and Done when.
9. Repeat until branches are resolved and user intent is shared.
10. Stop when next action is obvious.

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
