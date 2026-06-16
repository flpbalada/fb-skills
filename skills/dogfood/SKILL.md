---
name: dogfood
description: Systematically explore and test a web application to find bugs, UX issues, and other problems. Use when asked to "dogfood", "QA", "exploratory test", "find issues", "bug hunt", "test this app/site/platform", or review the quality of a web application. Produces a structured report with full reproduction evidence -- step-by-step screenshots, repro videos, and detailed repro steps for every issue -- so findings can be handed directly to the responsible teams.
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*)
---

# Dogfood

Explore a web app like a user.
Find issues.
Prove every finding.

## When to use

- User asks to dogfood, QA, exploratory test, bug hunt, or test a site/app.
- Target is a web app or local URL.
- User wants actionable issues with repro evidence.

## Inputs

- Required: target URL.
- Optional: session name, output directory, scope, credentials.
- Defaults:
  - Session: slugified domain.
  - Output: `./dogfood-output/`.
  - Scope: full app.
  - Auth: none.

If target URL is present, start.
Ask only when auth is needed and credentials are missing.

## Rules

- Use `agent-browser` directly.
- Do not use `npx agent-browser`.
- Do not read target app source code.
- Do not delete output files.
- Do not close and restart session mid-run.
- Verify issue before documenting.
- Document each issue immediately.
- Static issue: annotated screenshot enough.
- Interactive issue: video plus step screenshots.

## Setup

```bash
mkdir -p {OUTPUT_DIR}/screenshots {OUTPUT_DIR}/videos
cp {SKILL_DIR}/templates/dogfood-report-template.md {OUTPUT_DIR}/report.md
agent-browser --session {SESSION} open {TARGET_URL}
agent-browser --session {SESSION} wait --load networkidle
```

If login is needed:

```bash
agent-browser --session {SESSION} snapshot -i
agent-browser --session {SESSION} fill @e1 "{EMAIL}"
agent-browser --session {SESSION} fill @e2 "{PASSWORD}"
agent-browser --session {SESSION} click @e3
agent-browser --session {SESSION} wait --load networkidle
agent-browser --session {SESSION} state save {OUTPUT_DIR}/auth-state.json
```

Ask user for OTP codes.

## Flow

1. Create output directories and report.
2. Open target and authenticate if needed.
3. Take initial annotated screenshot.
4. Read `references/issue-taxonomy.md`.
5. Explore top-level navigation.
6. Test core workflows, forms, modals, menus, empty states, and errors.
7. Check console and browser errors.
8. Document each issue as soon as found.
9. Stop around 5-10 well-documented issues.
10. Update severity counts and close session.

## Explore commands

```bash
agent-browser --session {SESSION} screenshot --annotate {OUTPUT_DIR}/screenshots/initial.png
agent-browser --session {SESSION} snapshot -i
agent-browser --session {SESSION} errors
agent-browser --session {SESSION} console
```

Use `snapshot -i` for interactive refs.
Use `snapshot` for text and content.

## Evidence

For interactive issues:

```bash
agent-browser --session {SESSION} record start {OUTPUT_DIR}/videos/issue-{NNN}-repro.webm
agent-browser --session {SESSION} screenshot {OUTPUT_DIR}/screenshots/issue-{NNN}-step-1.png
sleep 1
agent-browser --session {SESSION} screenshot --annotate {OUTPUT_DIR}/screenshots/issue-{NNN}-result.png
sleep 2
agent-browser --session {SESSION} record stop
```

For static issues:

```bash
agent-browser --session {SESSION} screenshot --annotate {OUTPUT_DIR}/screenshots/issue-{NNN}.png
```

## References

| Reference | When to Read |
|-----------|--------------|
| [references/issue-taxonomy.md](references/issue-taxonomy.md) | Start of session -- calibrate severity levels, issue types, and exploration checklist |
| [templates/dogfood-report-template.md](templates/dogfood-report-template.md) | Copy into output directory as the report file |

## Output

- Report path.
- Total issues.
- Severity breakdown.
- Most critical findings.
- Evidence files saved.
