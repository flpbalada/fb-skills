---
name: agent-harness-orchestration
description: Coordinate multiple coding agents in shared repos with task packets, worktree or branch isolation, path ownership, verification loops, and PR or CI follow-through. Use when supervising ticket-driven multi-agent implementation or conflict-safe execution. Do not use for abstract LLM task splitting without repo state; use orchestrator-workers instead.
---

# Agent Harness Orchestration

Coordinate many coding agents without corrupting shared state.

Humans steer. Agents execute.
Harness gives context, isolation, and feedback.

## When to Use

- Multiple agents work in one repo.
- Tasks come from tickets, plans, or backlog items.
- Work can run in parallel.
- Path ownership or worktree isolation is needed.
- CI, review, rebase, or PR shepherding is part of the job.
- Human attention is the bottleneck.

## Goal

Turn tasks into isolated, verifiable, review-ready work.

## Rules

- One task per branch or worktree.
- One owner per path when possible.
- Do not let agents edit the same files at the same time.
- Sequence migrations before dependent feature work.
- Keep shared refactors separate from feature work.
- Require evidence, not claims.
- Capture follow-ups in repo docs, tests, or tracker.

## Task Packet

Give each agent:

- Objective.
- Scope and owned paths.
- Out of scope.
- Acceptance criteria.
- Verification commands.
- Required context: `AGENTS.md`, docs, specs, issues.
- Branch or worktree name.
- Output contract.

## Flow

1. Intake task.
2. Split work and mark dependencies.
3. Start only unblocked tasks.
4. Create isolated workspace.
5. Assign packet.
6. Agent edits and verifies.
7. Supervisor reviews evidence.
8. Rework, prepare PR, or capture follow-ups.

## Verification Loop

1. Reproduce bug or baseline when relevant.
2. Make smallest useful change.
3. Run targeted checks.
4. Run broader checks.
5. Smoke test user path or API.
6. Report exact commands and results.

Escalate missing secrets, unsafe migrations, flaky infra, or unclear product judgment.

## Failure Modes

- Shared mutable workspace.
- Vague task packet.
- No mechanical verification.
- Hidden architecture drift.
- Lost follow-up work.

## Output

```md
## Agent Work Summary
- Ready: [tasks]
- Blocked: [tasks and reason]
- Conflicts: [paths or none]
- Verification: [commands and results]
- Follow-ups: [docs, tests, tasks]
```
