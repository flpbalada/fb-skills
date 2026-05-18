---
name: to-prd
description: Convert conversation context into concise PRD requirements. Use when raw ideas, requests, or discussions need product requirements.
---

# Write PRD From Conversation

## When to use

- Raw conversation needs product requirements.
- User asks for a PRD, spec, or requirements doc.
- Ideas need scope, goals, and acceptance criteria.

## Goal

Convert discussion into concise, testable product requirements.
Preserve intent.
Do not invent missing decisions.

## Rules

- Read the full conversation first.
- Use only conversation context unless asked to infer.
- Mark unknowns as questions.
- Keep requirements measurable.
- Separate goals, non-goals, constraints, and acceptance criteria.
- Prefer short bullets.

## Flow

1. Extract raw requirements.
2. Identify context and constraints.
3. Infer user goals only when strongly supported.
4. List open questions.
5. Write concise PRD.

## Input

- Conversation context or raw notes.

## Output

```md
# PRD: [Title]

## Goal
[One paragraph]

## Users
- [User group]

## Problem
- [Problem]

## Requirements
- [Requirement]

## Non-goals
- [Non-goal]

## Constraints
- [Constraint]

## Acceptance Criteria
- Given [context], when [action], then [outcome].

## Open Questions
- [Question]
```
