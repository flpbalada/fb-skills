---
name: to-prd
description: Convert a discussion into a concise PRD covering users, the problem, acceptance criteria or requirements, and constraints. Use when the user asks to turn a discussion into a PRD.
---

# Convert Discussion to PRD

- Read the full conversation first.
- Preserve its intent without inventing decisions.
- Write requirements as a nested Given/When/Then tree.
- Group requirements that share context or steps under their common parent.
- Each nested item inherits every ancestor condition; do not repeat inherited text.
- A branch may be nested as deeply as needed. Each leaf must state a testable outcome.
- Start nodes with `Given`, `When`, or `Then`. Use `And` only to extend the parent clause.
- Bold Given/When/Then/And keywords to make the requirement tree easy to scan.
- Use only the sections in the template.
- Prefer short bullets.

## Output

Use [OUTPUT.md](OUTPUT.md).
