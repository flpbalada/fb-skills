---
name: kanban
description: Visualize and improve delivery flow with Kanban. Use when managing work-in-progress, bottlenecks, queues, service classes, cycle time, or team workflow policies; avoid for broader continuous-improvement culture, root-cause analysis, or product hierarchy planning.
---

# Kanban

Visualize work.
Limit WIP.
Improve flow.

## When to Use

- Team work is hard to see
- Too many tasks in progress
- Bottlenecks delay delivery
- Priorities change often
- Delivery dates are unpredictable

## Goal

Improve lead time, cycle time, throughput, and focus.

## Rules

- Start from current workflow.
- Make all work visible.
- Limit WIP per active stage.
- Pull work only when capacity exists.
- Write movement rules.
- Review blocked items daily.
- Improve with data.

## Metrics

- Lead time: request to delivery.
- Cycle time: started to done.
- Throughput: completed items per period.
- WIP: items in progress.

```text
Lead Time = WIP / Throughput
```

## Flow

1. Map current stages.
2. Add board with those stages.
3. Define entry and exit rules.
4. Set WIP limits.
5. Track blocked work.
6. Measure flow.
7. Fix one bottleneck.
8. Revisit policies.

## WIP Limits

Start simple:

- `Doing`: team size minus 1
- `Review` / `Test`: available reviewers or testers

## Resources

- [Kanban - David J. Anderson](https://www.amazon.com/Kanban-Successful-Evolutionary-Technology-Business/dp/0984521402)
- [Making Work Visible - Dominica DeGrandis](https://www.amazon.com/Making-Work-Visible-Exposing-Optimize/dp/1942788150)

## Output

```md
## Kanban Setup

Team: [name]
Workflow:
- [stage]: WIP [limit], entry [rule], exit [rule]

Metrics:
- Lead time: [value]
- Cycle time: [value]
- Throughput: [value]
- WIP: [value]

Bottleneck:
- Stage: [stage]
- Evidence: [queue / delay / blocked work]
- Cause: [reason]

Improvement:
- Change: [policy or process change]
- Measure: [metric]
- Review date: [date]
```
