# Template

## Output While Clarifying

Use the structured question tool when available. Ask independent frontier decisions in one round, up to the tool's limit. Put the recommended option first and include one short reason. Include “I don't know yet” as a choice.

Use this Markdown fallback only when no structured question tool is available:

```md
Questions:

1. [Decision question]
   Recommended: [answer]. Reason: [reason].
   You can answer: I don't know yet.
2. [Independent decision question]
   Recommended: [answer]. Reason: [reason].
   You can answer: I don't know yet.
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

### Open questions
- [Unanswered question, why it remains open, and next step: stakeholder input, research, or LLM-assisted exploration]
- [Dependent question or work blocked by an open answer]

### Next action
- Run `to-prd` by default, or [user-requested action].
```

Include all deferred questions and blocked branches in the final summary, even when the interview is complete. Write “None” under Open questions only when all material questions are resolved. Do not present proposed answers as settled decisions.

Then ask for explicit confirmation. Do not run the next action until the user confirms the summary. Keep unresolved questions visible in any handoff and leave dependent work blocked unless the user explicitly accepts an assumption.
