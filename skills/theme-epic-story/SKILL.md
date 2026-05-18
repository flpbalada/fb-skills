---
name: theme-epic-story
description:
  Structure product work hierarchically using themes, epics, and stories. Use
  when organizing backlogs, planning releases, communicating with stakeholders,
  or breaking down large initiatives into manageable work.
---

# Theme, Epic, Story

## When to use

- Organizing roadmaps or backlogs.
- Breaking large initiatives into actionable work.
- Planning releases or quarters.
- Explaining work structure to stakeholders.
- Aligning delivery work with strategy.

## Goal

Structure work from strategy to execution.
Keep user value separate from implementation tasks.

## Hierarchy

- Theme: strategic outcome. Why this matters.
- Epic: major capability. What area changes.
- Story: user need. What value is delivered.
- Task: implementation work. How to build it.

## Rules

- Themes need measurable outcomes.
- Epics must fit inside a planning horizon.
- Stories must be user-centered and testable.
- Tasks belong under stories, not beside themes.
- Split oversized epics by workflow, role, data lifecycle, platform, or release slice.
- Split oversized stories until they fit one sprint.
- Keep non-goals explicit.

## Flow

1. Define theme goal and success metric.
2. List epics needed to reach the goal.
3. Define each epic scope and out-of-scope.
4. Break each epic into stories.
5. Add acceptance criteria to each story.
6. Identify dependencies.
7. Mark MVP vs later work.

## Story Format

```md
As a [user type],
I want [capability],
so that [benefit].
```

## INVEST Check

- Independent.
- Negotiable.
- Valuable.
- Estimable.
- Small.
- Testable.

## Output

```md
## Theme
- Name:
- Goal:
- Success metrics:

## Epics
- [epic]: scope, out-of-scope, dependencies

## Release
- MVP:
- Later:
- Non-goals:
```
