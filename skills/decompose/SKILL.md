---
name: decompose
description: Split a component into focused units. Use when a component mixes responsibilities and needs smaller utilities, hooks, or sub-components.
---

# Decompose Component

Decompose the provided component into smaller, focused units.

## Input

- File or component path provided by the user.

## Goals

- Identify mixed responsibilities and logic.
- Extract reusable utilities, hooks, and sub-components when useful.
- Maintain existing behavior and tests.

## Constraints

- Preserve behavior unless the user explicitly approves a behavior change.
- Prefer the smallest correct decomposition.
- Avoid new abstractions unless reuse, locality, or readability improves.
