---
name: vercel-sandbox
description: Run agent-browser + Chrome inside Vercel Sandbox microVMs for browser automation from any Vercel-deployed app. Use when the user needs browser automation in a Vercel app (Next.js, SvelteKit, Nuxt, Remix, Astro, etc.), wants to run headless Chrome without binary size limits, needs persistent browser sessions across commands, or wants ephemeral isolated browser environments. Triggers include "Vercel Sandbox browser", "microVM Chrome", "agent-browser in sandbox", "browser automation on Vercel", or any task requiring Chrome in a Vercel Sandbox.
---

# Browser Automation with Vercel Sandbox

## When to use

- Running browser automation from a Vercel app.
- Needing Chrome without bundling browser binaries.
- Keeping browser sessions across commands.
- Running isolated browser work in a microVM.
- Capturing screenshots or accessibility snapshots from server workflows.

## Goal

Run `agent-browser` with Chrome inside Vercel Sandbox.
Keep browser state isolated, reproducible, and callable from app code.

## Rules

- Use Sandbox for Chrome runtime, not the serverless function filesystem alone.
- Keep session IDs explicit for multi-step workflows.
- Return artifacts such as screenshots, text, or snapshots from the workflow.
- Store secrets in environment variables.
- Use snapshots for faster startup when workflows repeat.
- Clean up or expire sessions when work is done.
- Do not assume browser state persists without a session or snapshot.

## Dependencies

- Vercel app.
- Vercel Sandbox package or project integration.
- `agent-browser`.
- Chrome installed inside the sandbox image or snapshot.
- Environment variables for auth or target URLs.

## Flow

1. Create or resume sandbox.
2. Start Chrome inside sandbox.
3. Connect `agent-browser`.
4. Navigate to target URL.
5. Run actions: click, type, snapshot, screenshot, extract.
6. Persist session or create snapshot if needed.
7. Return result to caller.

## Common Workflows

- Screenshot: open page, wait for stable state, capture image.
- Accessibility snapshot: open page, capture tree, parse roles/names.
- Multi-step task: reuse session across commands.
- Authenticated task: inject credentials or cookies securely.
- Cron workflow: run scheduled browser checks in a fresh sandbox.

## Environment Variables

- Target URLs.
- Auth credentials or tokens.
- Sandbox snapshot name.
- Session timeout.
- Output storage destination.

## Failure Checks

- Chrome did not start.
- `agent-browser` cannot connect.
- Target URL blocked or requires auth.
- Page not stable before screenshot.
- Sandbox timed out.
- Snapshot is stale.

## Output

```md
## Vercel Sandbox Browser Plan
- Runtime:
- Session model:
- Browser action:
- Auth needs:
- Artifacts:
- Failure handling:
```
