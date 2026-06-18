---
name: jobs-to-be-done
description: Reframe product strategy around customer progress with Jobs to Be Done. Use when researching motivations, switching behavior, competitive alternatives, unmet needs, feature framing, or value propositions; avoid for backlog story syntax, delivery hierarchy, or business-model economics.
---

# Jobs-to-be-Done

Users hire products to make progress in a situation.
Find the job, not just the feature request.
Do not start from feature usage.
Start from progress, circumstance, and current alternative.

## When to use

- Product strategy.
- Positioning.
- User research.
- Requirements and user stories.
- Competitor mapping.
- Switching behavior analysis.

## Goal

- Understand desired progress.
- Identify starting point and end goal.
- Capture context and trigger.
- Identify functional, emotional, and social jobs.
- Find true competition.
- Define what failure means.
- Reduce switching anxiety.

- Functional: task to complete.
- Emotional: feeling user wants.
- Social: how user wants to be seen.

## Forces

- Push: pain with current state.
- Pull: attraction of new solution.
- Anxiety: fear of new solution.
- Habit: comfort with current behavior.

Switching happens when push plus pull beats anxiety plus habit.

## Rules

- Ask about real past behavior.
- Focus on hiring moment.
- Ask what progress the user wants and in what circumstance.
- Ask what they hire today to get it done.
- Ask what getting fired would look like.
- Look for workarounds.
- Include non-consumption as competition.
- Do not ask users to design features.
- Do not take stated preferences as truth.

## Three ticket questions

Ask before starting any ticket.

1. What progress is the user trying to make, and in what circumstance?
2. What do they hire today to get it done?
3. What would fired look like?

Use the answers to avoid expensive unused solutions.

- Progress: current state, desired state, and trigger.
- Circumstance: time, place, constraints, stakes, and actors.
- Current hire: rival product, manual workaround, group text, paper list, spreadsheet, support request, or giving up.
- Fired: signal the feature failed, including behavior metric and qualitative feedback.

## Job statement

Write one sentence after the three questions.
Use it as product and architecture compass.
Let it shape system design, scope, data model, and tradeoffs.

```md
When [circumstance], I want to [make progress], so I can [desired outcome].
```

## Flow

1. Define product, feature, or behavior.
2. Answer the three ticket questions.
3. Gather real user stories.
4. Extract situation, motivation, and outcome.
5. Map functional, emotional, and social jobs.
6. Map push, pull, anxiety, and habit.
7. List true competitors.
8. Write the job statement.
9. Turn insights into positioning or requirements.

## Resources

- [Competing Against Luck - Clayton Christensen](https://www.amazon.com/Competing-Against-Luck-Innovation-Customer/dp/0062435612)
- [The Jobs to be Done Playbook - Jim Kalbach](https://www.amazon.com/Jobs-Be-Done-Playbook-Organization/dp/1933820683)
- [Jobs to be Done video](https://www.youtube.com/watch?v=vAzvoOkA70c)

## Output

```md
## JTBD Analysis

Product or feature: [name]

## Three Ticket Questions
- Progress and circumstance: [current state, trigger, desired state]
- Current hire: [alternative or workaround]
- Fired signal: [failure behavior, metric, or feedback]

## Core Job
When [situation], I want to [motivation], so I can [outcome].

## Job Dimensions
- Functional: [task]
- Emotional: [feeling]
- Social: [perception]

## Forces
- Push: [pain]
- Pull: [benefit]
- Anxiety: [concern]
- Habit: [old behavior]

## True Competition
- [alternative]: [how it serves job]

## Fired Looks Like
- [what would prove this solution is not hired]

## Implications
- Product: [requirement or scope decision]
- Architecture: [system design or tradeoff]
- Research: [question or feedback loop]
```
