---
name: follow-goals
description: Shape long-running autonomous work into one durable goal with stop condition, validation loop, checkpoints, progress format, and pause rules. Use for scoped, verifiable progress across migrations, refactors, prototypes, evals, retry loops, or prompt optimization; avoid loose backlog lists, one-shot answers, hidden preferences or unavailable context, and autonomous work that risks production without human approval.
---

# Follow Goals

Create a goal contract before starting long-running autonomous work. Make the contract specific enough to keep progress moving without repeated steering.

## Goal Contract

Before execution, write:

- Objective: one durable outcome.
- Stop condition: exact state where work should stop.
- Context to read first: files, docs, tickets, logs, plans, screenshots, or examples.
- Constraints: non-goals, safety limits, style rules, architecture limits, approvals needed.
- Validation loop: commands, checks, artifacts, or behaviors proving progress.
- Checkpoints: small milestones with expected evidence.
- Progress log: concise format for status updates.
- Pause conditions: what should stop work and request user input.

If any required field is missing and not discoverable, ask one blocking question. Prefer a recommended answer.

## Prompt Shape

Use this structure:

```md
Goal:
- Complete [single objective].

Context:
- Read [files/docs/issues/logs/plan] first.
- Preserve [important existing behavior or artifact].

Constraints:
- Do not change [non-goals].
- Keep edits scoped to [area].
- Ask before [risky action].

Validation:
- After each checkpoint, run [command/check].
- Inspect [artifact/output] for [expected signal].

Checkpoints:
1. [milestone] done when [evidence].
2. [milestone] done when [evidence].
3. [milestone] done when [evidence].

Progress:
- Report current checkpoint, completed work, verification result, remaining work, and blockers.

Stop when:
- [verifiable end state].

Pause when:
- [blocked state, failing assumption, missing approval, or direction change].
```

## Writing Rules

- Make objective bigger than one prompt, smaller than backlog.
- Name one primary outcome.
- Use concrete nouns: file paths, commands, metrics, screenshots, issue IDs, artifact names.
- Define done before starting.
- Keep scope narrow enough for independent progress.
- Include rollback or parity checks for migrations.
- Include visual or behavior checks for prototypes and games.
- Include eval command, target score, and edit limits for prompt optimization.
- Avoid vague verbs like improve, polish, clean up, or handle unless paired with evidence.

## Status Updates

Ask for compact status in this shape:

```md
Checkpoint: [name]
Done: [what changed]
Verified: [command/artifact/result]
Remaining: [next work]
Blocked: [no | blocker]
```

If status becomes vague, tighten next checkpoint instead of adding broad instructions.

## Examples

Migration:

```md
Goal:
- Migrate [legacy path] to [target stack].

Validation:
- Run [contract tests] after each checkpoint.
- Verify old path still has rollback until parity passes.

Stop when:
- New path passes contract tests, parity checks pass, and rollback is documented.
```

Prototype:

```md
Goal:
- Implement [PLAN.md] as a working first version.

Validation:
- Build app.
- Launch app.
- Verify expected behavior against [reference screens or behavior list].

Stop when:
- App builds, launches, and matches listed behavior.
```

Prompt optimization:

```md
Goal:
- Improve prompts in [path] until [eval target].

Validation:
- Run [eval command] after each prompt change.
- Inspect failing cases before editing again.

Constraints:
- Keep prompt edits minimal and targeted.

Stop when:
- Eval reaches [target] or further changes need product or policy guidance.
```
