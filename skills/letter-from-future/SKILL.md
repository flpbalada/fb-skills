---
name: letter-from-future
description: Create a letter-from-future planning artifact for startup, product, roadmap, pivot, project kickoff, quarterly planning, or stakeholder alignment. Use when user needs to describe a desired future, backcast milestones, connect vision to customer value, and surface risks, metrics, and next actions. Do not use for formal PRDs; use to-prd.
---

# Letter From Future

Describe future as if it already happened.
Work backward into product bets and project actions.

## Goal

Turn vague ambition into a usable planning artifact:

- Future letter: vivid target state.
- Product promise: customer value in plain words.
- Backcast roadmap: steps from future to now.
- Premortem: risks, warning signs, mitigations.
- Next actions: owner-ready work.

## Use For

- Startup vision and strategy.
- Product discovery and roadmap planning.
- Project kickoff.
- Pivot or positioning work.
- Founder, PM, design, engineering, sales, and investor alignment.
- Quarterly or annual planning.

## Rules

- Write from specific future date.
- Prefer 6-24 month horizon for startups.
- Name customer, problem, behavior change, and business result.
- Separate outcome from solution.
- Include evidence: metrics, customer quotes, market signals, shipped capabilities.
- Backcast from future to present.
- Add premortem after vision so optimism meets risk.
- Do not write generic inspiration.
- Mark weak assumptions.
- End with next 1-3 actions.

## Flow

1. Define scope.
2. Pick future date.
3. Write letter from future.
4. Extract product promise.
5. Backcast milestones.
6. Run premortem.
7. Convert into decisions and next actions.

## Prompts

Use these questions when context is thin:

- Who writes from future?
- Who receives letter?
- What changed for customer?
- What proof shows success?
- What had to become true?
- What almost killed project?
- What decision is needed now?

## Output

```md
## Letter From Future

Date: [future date]
From: [future narrator]
To: [team / founder / product org]
Horizon: [6 / 12 / 18 / 24 months]

Dear [recipient],

We succeeded because [plain-language reason].

Customers now [new behavior].
Before, they struggled with [old problem].
Now, they get [better outcome].

The product changed by [key capability or experience].
The business changed by [business result].
The market changed by [market signal].

Proof:
- Customer quote: "[realistic quote]"
- Metric: [metric moved from X to Y]
- Signal: [retention, revenue, activation, usage, sales cycle, support, NPS]

Hard choices:
- We stopped [thing].
- We focused on [thing].
- We said no to [thing].

What almost failed:
- [risk]
- [risk]

What made it work:
- [decision]
- [project]
- [habit or operating change]
```

```md
## Product Promise

Customer: [specific customer]
Problem: [pain or job]
Promise: [outcome in customer language]
Why now: [timing]
Differentiator: [why this wins]
Success metric: [primary metric]
```

```md
## Backcast Roadmap

Future state: [one-sentence outcome]

Milestones:
- T-12 months: [must be true]
- T-9 months: [must be true]
- T-6 months: [must be true]
- T-3 months: [must be true]
- Now: [first move]

Projects:
- [project]: [owner / metric / risk]
```

```md
## Premortem

Assume letter failed.

Failure causes:
- [cause]

Early warning signs:
- [signal]

Mitigations:
- [action]

Kill or pivot criteria:
- [condition]
```

```md
## Next Actions

- [owner]: [action] by [date]
- [owner]: [decision] by [date]
- [owner]: [evidence to gather] by [date]
```
