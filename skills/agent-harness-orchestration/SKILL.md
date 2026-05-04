---
name: agent-harness-orchestration
description: Coordinate coding agents with harness-engineering practices. Use when supervising multi-agent implementation, ticket-driven work, verification loops, or conflict-safe execution.
---

# Agent Harness Orchestration

Practical workflow for running many coding agents.
Humans steer.
Agents execute.
Harness supplies context, tools, guardrails, and feedback loops.

## What It Is

A control system for coding agents.
It turns tasks into isolated workspaces, keeps agents moving, verifies results, and consolidates changes without corrupting shared state.

Use repository-local knowledge as source of truth.
Use issues, plans, or task lists as control plane.
Use tests, linters, CI, app automation, logs, and review loops as feedback.

## When to Use

- Multiple agents work on same repo
- Tasks can run from tickets, plans, or backlog items
- Need one agent per task or per workstream
- Need safe parallel execution without edit conflicts
- Need PR shepherding, CI watching, rebasing, or review loops
- Need repeatable verification evidence before merge
- Human attention is bottleneck

## When Not to Use

- One small change fits one interactive session
- Task needs constant human judgment
- Repo lacks tests, docs, or clear boundaries
- Agents would share same working tree
- Conflicts cannot be isolated or sequenced
- Verification is manual-only

## Core Flow

```text
intake task
  → classify / split / block dependencies
  → create isolated workspace
  → assign objective + constraints
  → agent researches, plans, edits, verifies
  → supervisor reviews evidence
  → rework, split follow-ups, or prepare PR
  → CI / review / rebase / merge handoff
  → capture lessons as docs, tests, or guardrails
```

## Task Packet

Give each agent a small complete packet:

- Objective: desired outcome, not step-by-step micromanagement
- Scope: files, packages, features, or user journeys in bounds
- Out of scope: what not to touch
- Acceptance criteria: observable behavior and quality bar
- Verification commands: tests, lint, typecheck, build, smoke paths
- Context map: links to `AGENTS.md`, architecture docs, plans, specs
- Conflict rules: owned paths, branch/worktree name, blocked dependencies
- Output contract: summary, changed files, evidence, risks, follow-ups

## Workspace Isolation

- One task per branch or worktree
- One app instance per worktree when testing UI or services
- One local data store, env, ports, logs, and metrics namespace per workspace
- Never let agents edit same files concurrently without an owner
- Use dependency DAGs for ordered work
- Mark blocked tasks explicitly; run only unblocked leaves in parallel

## Supervisor Duties

1. Watch task board or plan.
2. Start agents for ready tasks.
3. Restart stalled or crashed agents with latest task state.
4. Detect overlapping edits before they grow.
5. Ask agents to split oversized tasks into subtasks.
6. Require verification evidence, not claims.
7. Route failures back into tools, docs, tests, or constraints.
8. Consolidate outputs into PRs or follow-up tickets.

## Conflict Prevention

- Prefer path ownership per task.
- Sequence migrations before dependent feature work.
- Keep shared refactors separate from feature changes.
- Rebase early when base moves.
- If two agents touch same module, pause one and merge intent first.
- If conflict repeats, create a coordination task to define boundary or API.

## Verification Loop

Agents should loop until clean or blocked:

1. Reproduce bug or baseline behavior when relevant.
2. Implement change.
3. Run targeted tests first.
4. Run broader checks next.
5. Drive app or API for critical user paths.
6. Inspect logs, metrics, screenshots, videos, or traces when available.
7. Fix failures.
8. Report exact commands and evidence.

Stop and escalate when judgment, missing secrets, flaky infra, or unsafe migrations block progress.

## Review Packet

Ask each agent to return:

- What changed
- Why it satisfies task
- Files touched
- Tests and checks run with results
- Manual or browser verification evidence
- Known risks
- Follow-up issues created or recommended
- Merge readiness: ready / needs review / blocked

## Harness Improvements

When agents fail, improve harness instead of hand-patching once:

- Add missing docs or context map entries
- Add tests, linters, or structural checks
- Add scripts for common workflows
- Add app automation or observability access
- Add clearer task templates
- Encode recurring review feedback as guardrails
- Schedule cleanup tasks for drift and duplicated patterns

## Failure Modes

- Agents share mutable workspace
- Task packet too vague
- Supervisor tracks sessions instead of deliverables
- No mechanical verification
- Huge `AGENTS.md` replaces discoverable docs
- Agents create hidden architecture drift
- Follow-up work is lost outside the task tracker
- Merge queue becomes human-babysat bottleneck

## Practical Checklist

- Task has owner, branch/worktree, and status
- Dependencies and blocked state known
- Scope and path ownership clear
- Acceptance criteria observable
- Verification commands listed
- Agent can access needed docs and tools
- Checks run in isolated environment
- Review packet produced
- Follow-ups captured in repo or tracker
- Lessons converted into docs, tests, or guardrails

## Decision Rule

Use agent harness orchestration when human attention is the bottleneck and multiple coding agents need safe, verifiable, repository-aware coordination.
For a single dynamic decomposition inside one task, prefer orchestrator-workers.
For independent prompt branches with simple merge logic, prefer parallelization.
