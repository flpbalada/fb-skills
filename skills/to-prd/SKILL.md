---
name: to-prd
description: Convert conversation notes, raw ideas, feature requests, or planning discussion into concise PRD requirements with goals, users, problem, requirements, non-goals, constraints, acceptance criteria, and open questions. Use when user asks for PRD, spec, requirements doc, or product brief. Do not interview first unless key decisions are missing; use discuss-task for clarification.
---

# Write PRD From Conversation

Convert discussion into concise, testable product requirements.
Preserve intent.
Do not invent missing decisions.

## Rules / constraints

- Read the full conversation first.
- Use only conversation context unless asked to infer.
- Keep requirements measurable.
- Separate goals, non-goals, constraints, and acceptance criteria.
- Prefer short bullets.

## Flow

1. Extract raw requirements.
2. Identify context and constraints.
3. Infer user goals only when strongly supported.
4. Write concise PRD.

## Input

- Conversation context or raw notes.

## Output

```md
# PRD: [Title]

## Users (who)

- [User group]

## Problem (what)

- [Problem]

## Constraints / non-goals

- [Constraint]

## Acceptance Criteria / requirements

- Given [context], when [action], then [outcome].
```
