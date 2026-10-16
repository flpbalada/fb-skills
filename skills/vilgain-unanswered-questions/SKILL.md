---
name: vilgain-unanswered-questions
description: Find questions and requests Filip has not answered in Vilgain Slack messages and ClickUp notifications.
---

# Vilgain Unanswered Questions

Find asks waiting for Filip Balada's reply. Return a short list with direct links.

## Scope

- Use known account and workspace IDs. Resolve them only when missing or ambiguous.
- Check the requested period, otherwise the past 14 days in Europe/Prague, plus accessible older unresolved notifications and previously flagged items.
- Keep the scan read-only, including notification read state. Do not send replies or change tasks.

## Find candidates

- **Slack:** Search mentions, DMs, group DMs, and follow-ups in Filip's threads. Include read messages and Czech or English asks without question marks or explicit mentions.
- **ClickUp:** Check notifications, mentions, assigned comments, and replies. Include read notifications and relevant task discussions, even on closed tasks.
- Prefer connected tools. If ClickUp has no inbox tool, check `clickup_get_operators` once for a read-only option. If unavailable, search task comments and report that the inbox was not checked.
- Follow pagination within scope. Report inaccessible sources or unfinished searches rather than treating them as empty.

## Verify before flagging

For each likely ask, read the parent and full reply thread through its latest activity, including replies after the search period. Check linked discussions when they may contain the answer.

Keep an item only when it is directed to Filip and still needs his response:

- Exclude asks answered, withdrawn, superseded, or resolved by someone else.
- Check the specific ask. An earlier reply does not answer a later follow-up.
- A reaction or acknowledgment counts only if it resolves the ask. Task status and read markers are not proof of an answer.
- Do not flag acknowledged work still in progress unless a promised update is due or a new question needs answering.
- Merge duplicates across notifications and tools. Separate uncertain items when the recipient or resolution cannot be verified.

## Report

Lead with the number needing a reply and the dates checked. List overdue or blocking asks first, then oldest first.

One bullet per item:

`[Topic](message-or-comment-link) — requester, date — question still needing a reply.`

Use a verified thread or task link if no direct message link is available. Keep uncertain items separate with a brief reason. End with a short coverage note, including gaps. If nothing is found, say "No unanswered questions found in the checked scope."
