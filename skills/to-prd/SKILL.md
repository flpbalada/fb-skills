---
name: to-prd
description: Convert a discussion into a concise PRD covering users, the problem, requirements, technical implementation, and constraints. Use when the user asks to turn a discussion into a PRD.
---

# Convert Discussion to PRD

- Read the full conversation first.
- Preserve its intent without inventing decisions.
- Assess whether the discussion provides enough technical detail to explain how to implement the requirements.
- When technical details are missing, unclear, or contradictory:
  - Warn the user before the PRD.
  - Name the incomplete areas.
  - Recommend using `discuss-task` to resolve them.
  - Still compose the PRD from the available details; do not route automatically.
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
- When relevant technical constraints are missing or incomplete, name the gaps in the warning and guide the user to consider `discuss-task` before deciding them.
- Still compose the PRD with the settled constraints and mark unresolved constraints as unspecified.
- State when a relevant technical area, constraint, diagram relationship, or file path is unspecified; never invent the missing implementation decision.
- Use only the sections in the template.
- Prefer short bullets.

## Output

Use [OUTPUT.md](OUTPUT.md).
