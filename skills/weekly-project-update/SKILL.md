---
name: weekly-project-update
description: Ask the user for project status, then draft an English weekly update and suggested Health value using the Vilgain project wiki format.
---

# Weekly Project Update

Turn the user's project name or link and status notes into an English draft using [OUTPUT.md](OUTPUT.md).

Source: [Running a project — 5. Post the weekly update](https://app.clickup.com/2412134/v/dc/29kk6-115875/29kk6-68755).

## Collect status

Use the questions tool (`request_user_input_async` in Codex) to ask for project status in one free-text question:

- What moved last week?
- What is planned this week?
- What risks or delays exist, and what will resolve them?
- What is needed, from whom, and by when?
- Is the promised scope and delivery date still achievable?

Ask only for missing details if the user already supplied status. Include the project name or link if missing. Wait for their answer before drafting; ClickUp records do not replace the user's status.

## Health

Assess Health against the promised scope and date:

- **On track:** Everything is going to plan.
- **At risk:** Delivery is still expected, but unresolved risks threaten it.
- **Off track:** Already late or delivering less than promised. Keep this value unless the sponsor agrees a new commitment.
- **Paused:** Already started and on hold by sponsor agreement. No weekly update required. Not started stays `to do`.
- **Unknown:** No current update or insufficient information.

For a requested pause comment, state the reason and conditions for resuming. On resumption, draft a normal update and assess Health against sponsor-agreed dates.
