---
name: to-prd
description: Convert conversation notes, raw ideas, feature requests, or planning discussion into concise PRD requirements with goals, users, problem, requirements, non-goals, constraints, acceptance criteria, and open questions. Use when user asks for PRD, spec, requirements doc, or product brief. Do not interview first unless key decisions are missing; use discuss-task for clarification.
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
