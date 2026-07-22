---
name: docs-grounded-task-context
description: Collect project context and documented best practices for clear framework, library, SDK, language, and tool tasks. Use before acting on external APIs or conventions. Stop when directive or target is unclear.
---

# Documentation-Grounded Task Context

Collect relevant project context and authoritative best practices before acting.

## Task Gate

A task is clear enough only when it has:

- An explicit directive.
- An identifiable target or outcome.

If either is missing, stop. State that task is not clear enough, identify missing detail, and ask one focused question.

## Workflow

1. Pass task gate.
2. Read official documentation for exact task and installed version. See [Resources](./RESOURCES.md).
3. Define documented best practices and how they fit project conventions.
4. Continue with directive using collected context.

Collected context must identify relevant versions, constraints, best practices, project adaptations, and source URLs.
Never replace missing evidence with remembered APIs, invented behavior, or custom mental models.

## Stop and Ask

Stop and consult user when relevant context or authoritative documentation is missing or inconclusive:

- Installed version cannot be determined.
- Documentation does not cover required behavior or sources conflict.
- Project conventions conflict with supported documented usage.
- Valid approaches have materially different product, data, security, or maintenance effects.
- Work requires an undocumented workaround or custom architecture.

State missing evidence. Ask one focused question or present documented options.
Resume only after user resolves blocker.
