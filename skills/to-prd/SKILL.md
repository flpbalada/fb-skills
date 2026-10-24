---
name: to-prd
description: Convert a discussion into a concise PRD covering users, the problem, requirements, technical implementation, and constraints. Use when the user asks to turn a discussion into a PRD.
---

# Convert Discussion to PRD

## Readiness Check

- Before every PRD, read the full conversation and locate the installed [discuss-task](../discuss-task/SKILL.md) skill.
- If `discuss-task` is not installed, stop without generating a PRD and tell the user to install the Discuss Task (`discuss-task`) skill before continuing. Do not substitute your own readiness check.
- Invoke `discuss-task` for a quick readiness check.
- Use its uncertainty assessment to check shared understanding of the problem, users, scope, requirements, success criteria, implementation, and constraints. Keep this check brief rather than starting the full interview.
- If any material question needs discussion, stop before generating any PRD content.
- Name the open questions and ask the user to use `discuss-task` to establish a clear shared understanding before returning to `to-prd`.
- Deferred questions and questions blocked by them remain open. Do not treat confirmation alone as resolving them.
- Proceed only when no material questions need discussion. Reuse settled answers without asking them again.

## Write the PRD

- Preserve the discussion's intent without inventing decisions.
- Write requirements as a nested Given/When/Then tree.
- Group requirements that share context or steps under their common parent.
- Each nested item inherits every ancestor condition; do not repeat inherited text.
- A branch may be nested as deeply as needed. Each leaf must state a testable outcome.
- Start nodes with `Given`, `When`, or `Then`. Use `And` only to extend the parent clause.
- Bold Given/When/Then/And keywords to make the requirement tree easy to scan.
- Write the Technical section as the implementation specification (how).
- Include an abstract Mermaid diagram showing the main layers, components, and data flow.
- Include a file tree showing the files or directories to add or change.
- Include relevant architecture, UI layers and components, APIs and integrations, data models and state, error handling, testing, and migration or rollout details.
- Include only technical constraints explicitly settled in the discussion or required by authoritative project instructions.
- Do not choose, infer, or derive technical constraints from general best practices.
- If a material gap appears while writing, return to the readiness check and stop generation.
- Never invent a missing implementation decision. Mark an area as unspecified only when it does not need discussion to produce a usable PRD.
- Use only the sections in the template.
- Prefer short bullets.

## Output

Use [OUTPUT.md](OUTPUT.md).
