---
name: learn
description: Extract one reusable skill pattern from current session, such as a recurring error fix, debugging tactic, tool combo, project convention, or workflow worth saving. Use when user asks to learn, remember, capture, or turn session knowledge into a skill. Ask before writing new skill files; skip one-off fixes.
---

# Learn Session Patterns

Extract reusable patterns from current session.
Turn repeated value into a skill only when it will help future work.

## When to Use

- Error fix should be reused
- Debugging technique worked well
- Tool combination saved time
- Library quirk needs remembering
- Project convention became clear
- Workflow should become a skill

## Goal

Capture one reusable pattern.
Avoid saving one-off fixes or noise.

## Rules

- One pattern per skill.
- Prefer recurring problems.
- Keep pattern portable.
- Do not save trivial typos.
- Do not save outage-specific workarounds.
- Ask before writing new skill file.

## Flow

1. Review session.
2. List candidate patterns.
3. Keep only patterns likely to recur.
4. Identify trigger: when future agent should use it.
5. Draft short skill.
6. Ask user to confirm before saving.
7. Save under `skills/learned/` only after approval.

## Output

```md
## Skill Candidate: [name]

What:
- [pattern or problem]

When to use:
- [trigger]

Why:
- [future value]

How:
1. [step]
2. [step]
3. [step]

Examples:
- [scenario]

Keep?
- [yes/no recommendation]
```

## Checks

- Real problem occurred.
- Fix is not obvious or trivial.
- Pattern can apply in new contexts.
- Future trigger is clear.
- Skill would save time.
