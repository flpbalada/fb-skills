---
name: slack
description: Interact with Slack workspaces using browser automation. Use when the user needs to check unread channels, navigate Slack, send messages, extract data, find information, search conversations, or automate any Slack task. Triggers include "check my Slack", "what channels have unreads", "send a message to", "search Slack for", "extract from Slack", "find who said", or any task requiring programmatic Slack interaction.
---

# Slack Automation

## When to use

- Checking unread channels or DMs.
- Navigating Slack.
- Searching conversations.
- Extracting channel, thread, or message data.
- Sending or drafting messages through browser automation.
- Capturing Slack screenshots or state.

## Goal

Use browser automation to work in the user's existing Slack session.
Prefer visible UI state and accessibility snapshots over guesses.

## Rules

- Connect to existing Slack session when available.
- Take a snapshot before clicking.
- Use accessible names and roles to identify targets.
- Confirm channel, DM, or thread before sending.
- Do not send messages unless the user asked for sending.
- Capture enough context for summaries and searches.
- Keep private data scoped to the user's request.

## Core Commands

```bash
agent-browser open --remote-debugging-port 9222
agent-browser snapshot
agent-browser click <ref>
agent-browser type <text>
agent-browser screenshot
```

## Flow

1. Connect to Slack browser session.
2. Capture snapshot.
3. Locate target channel, DM, tab, search box, or unread area.
4. Navigate by role/name/ref.
5. Extract visible text or relevant snapshot data.
6. Act only when requested.
7. Report concise result and any limits.

## Common Tasks

- Unreads: inspect Activity, DMs, and sidebar unread sections.
- Channel navigation: search or click visible channel tree item.
- Message search: use Slack search box, then inspect results.
- Channel info: open channel details and extract members/topic/description.
- Thread context: open thread and read parent plus replies.
- Screenshots: use annotated screenshot for UI debugging.

## Data Extraction

- Prefer accessibility tree text for structured parsing.
- Use screenshots for visual state or layout proof.
- Capture URL/title when useful.
- Scroll deliberately when older messages are needed.
- Note when content is hidden, collapsed, or not loaded.

## Limitations

- Slack UI changes can break selectors.
- Some messages may require scrolling or expansion.
- Workspace permissions may hide channels or history.
- Browser session may be logged out.

## References

| Reference                                                                | When to Use                                                                   |
| ------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| [references/slack-tasks.md](references/slack-tasks.md)                   | Detailed task patterns for unreads, search, channel inventory, and monitoring |
| [templates/slack-report-template.md](templates/slack-report-template.md) | Structured report template for Slack analysis output                          |
| [Slack docs](https://slack.com/help)                                     | Slack product behavior and help docs                                          |
| [Slack web app](https://app.slack.com)                                   | Browser automation target                                                     |
| Keyboard shortcuts                                                       | Type `?` in Slack for shortcut list                                           |

## Output

```md
## Slack Result

- Target:
- Action taken:
- Key findings:
- Limits:
```
