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
- Expose assumptions.
- Separate scope from non-goals.
- Make success and failure testable.
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
- Use `question` tool when structured choices help.
- Do not ask same question in tool and markdown.
- If clear enough, stop asking and summarize.

## Check

- User.
- Problem.
- Trigger.
- Success.
- Failure.
- Scope.
- Non-goals.
- Constraints.
- Data or state.
- Edge cases.
- Decision dependencies.
- Recommended path.

## Flow

1. Restate task only if useful.
2. List main gap or assumption.
3. Identify next blocking decision.
4. Answer from code or docs if possible.
5. Ask one question with recommended answer.
6. Refine after answer.
7. Repeat until branches are resolved.
8. Stop when next action is obvious.

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

## Requirements

- Given [state], when [action], then [result]

## Notes

- Scope: [in]
- Non-goals: [out]
- Assumptions: [known]
- Next: [smallest useful action]
```
