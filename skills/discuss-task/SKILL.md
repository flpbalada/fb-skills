---
name: discuss-task
description: Build shared understanding before action by interviewing the user about ambiguous implementation, product, planning, or design tasks. Use when goal, scope, constraints, risks, success criteria, done state, or next action are unclear; when user wants a thinking partner; or when user needs a handoff-ready task prompt. Do not write PRDs; use to-prd for product requirements.
---

# Discuss Task

Build shared understanding before acting.
Walk the decision tree one branch at a time until next action is obvious.

## Rules

- Inspect code, docs, errors, examples, or commands before asking when answer is discoverable.
- Ask one question at a time.
- Ask up to 3 only when questions are independent.
- Ask only questions that change goal, scope, priority, risk, constraints, acceptance, or done state.
- Include recommended answer and one short reason for each question.
- Probe past first plausible answer when context, tradeoff, or intent is still missing.
- Confirm important assumptions before treating them as settled.
- Do not ask same question in tool and markdown.
- Stop interviewing when shared understanding is enough to act.

## Flow

1. Name current gap or assumption.
2. Resolve next blocking decision.
3. Ask one question with recommendation.
4. After answer, update shared understanding.
5. Repeat until goal, scope, constraints, risks, success, and done state are clear.
6. End with next action or handoff prompt.

## Ask About

- Goal and trigger.
- Relevant files, docs, errors, examples, data, or state.
- Scope and non-goals.
- Constraints and risks.
- Success, failure, and done criteria.
- Verification command or behavior check.

## Output while clarifying

```md
Gap:
- [gap]

Question:
- [question]
Recommended: [answer]
Reason: [reason]
```

## Output when ready

If user needs handoff prompt:

```md
Goal:
- [outcome]

Context:
- [facts, files, commands]

Constraints:
- [rules, non-goals, risks]

Done when:
- [checks and behavior]

Next:
- [smallest useful action]
```

Otherwise summarize shared understanding and proceed.
