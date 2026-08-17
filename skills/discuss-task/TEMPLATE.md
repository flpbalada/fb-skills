# Template

## Output While Clarifying

Use the structured question tool when available. Ask independent frontier decisions in one round, up to the tool's limit. Put the recommended option first and include one short reason.

Use this Markdown fallback only when no structured question tool is available:

```md
Questions:

1. [Decision question]
   Recommended: [answer]. Reason: [reason].
2. [Independent decision question]
   Recommended: [answer]. Reason: [reason].
```

Do not repeat tool questions in Markdown.

## Output When Ready

```md
## Shared understanding

### Goal
- [goal and trigger]

### Decisions
- [settled decision and reason]

### Scope
- Included: [scope]
- Excluded: [non-goals]

### Constraints
- [constraint or dependency]

### Risks and edge cases
- [risk, failure behavior, or recovery]

### Acceptance and verification
- [testable success or done criterion]
- [verification command or behavior check]

### Assumptions
- [assumption, or none]

### Unresolved items
- None.

### Next action
- Run `to-prd` by default, or [user-requested action].
```

Then ask for explicit confirmation. Do not run the next action until the user confirms the summary.
