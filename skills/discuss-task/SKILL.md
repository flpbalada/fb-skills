---
name: discuss-task
description: Clarify ambiguous tasks before action. Use when goal, scope, success criteria, constraints, or risks are unclear.
---

# Clarify Task

Discuss the task until clear enough to act.

## Style

- Caveman mode.
- Minimal words. Preserve meaning.
- Sentence fragments ok.
- No filler, no long explanations.
- One idea per line.
- Prefer bullets over paragraphs.
- Max 2 sections per reply while clarifying.
- Max 6 bullets total while clarifying, unless user asks for detail.

## Input

- Task, idea, bug, feature, or request provided by the user.

## Goal

- Find unclear assumptions.
- Define goal and outcome.
- Identify scope, non-goals, constraints, and risks.
- Ask until clear enough.
- Avoid implementation details until requirements are clear.

## Subagents

Subagents are optional. Use only when useful:

- `requirements-analyzer`: missing requirements, acceptance criteria, or scope boundaries.
- `deep-thinker`: ambiguity, tradeoffs, high-risk assumptions, or hidden risks.
- Skip subagents for simple clarifications.

## Process

1. Restate task in 1 short line only if useful.
2. State main gaps only.
3. If clear, skip questions and output ready summary.
4. Ask the smallest useful question set.
5. After answers, refine understanding.
6. Repeat only if important ambiguity remains.

## Question Rules

- Ask only questions that can change scope, direction, acceptance criteria, priority, or risk.
- Ask max 3 questions at once. Prefer 1.
- Prefer concrete choices over broad open questions when possible.
- Use the `question` tool when choices are known or structured answers would reduce ambiguity.
- If the answer needs free text, ask in markdown instead.
- Do not ask the same question with both the `question` tool and markdown.
- Do not implement, edit files, or run broad exploration unless needed for clarity.

## Check

- Who is the user?
- What problem is solved?
- When is this triggered?
- What is success?
- What is failure?
- What is out of scope?
- What must not change?
- What data or state is involved?
- What edge cases matter?
- What needs a product decision?

## Stopping Condition

Stop asking when the goal is clear, success and failure are testable, scope and non-goals are explicit, key assumptions are confirmed or listed, and the next step is obvious.

## Output While Clarifying

```md
## Gaps
- [gap or assumption]

## Questions
1. [high-value question]
```

## Output When Ready

```md
## Summary
- [concise final summary]

## Requirements
- Given [precondition], when [action], then [outcome]

## Notes
- [case]
- [assumption]
- [question or `None`]
- [item]
- [smallest useful next action]
```

Keep the whole reply compact. Ask questions instead of guessing.
