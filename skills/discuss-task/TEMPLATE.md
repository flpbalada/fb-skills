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

### Known knowns
- Goal and users: [settled outcome, trigger, and affected users]
- Decisions: [settled choices and reasons]
- Scope: [included work and non-goals]
- Constraints: [confirmed limits and dependencies]
- Risks and edge cases: [established risks and agreed failure or recovery behavior]
- Done and verification: [testable success criteria and checks]
- Accepted assumptions: [explicitly accepted but unverified assumptions, or none]

### Known unknowns
- [Open question or unverified assumption, its impact, and state: frontier, deferred, or blocked]
- [Prerequisite, dependent question or work blocked, and next step: stakeholder input, research, or LLM-assisted exploration]

### Unknown knowns
- [Implicit rule, term, default, or workaround to surface, why it matters, and who or what can confirm it]
- [Dependent work blocked until this knowledge is made explicit]

### Unknown unknowns
- [Relevant blind-spot check and what it covered, or an unexamined area and a concrete discovery step]
- Revisit when: [new evidence or a change that should reopen discovery]

### Next action
- Run [to-prd or to-spec]: [why this deliverable fits the request and current readiness].
```

Use these categories as defined in SKILL.md. Keep bullets relevant and concise. Include the source or reason for known knowns where it matters. Place unsettled goals, scope, constraints, risks, or success criteria under known unknowns instead of filling gaps with proposals.

Include all deferred questions and blocked branches, even when the interview is complete. Record each gap once and refer to it from dependent work. Unknown knowns are prompts to surface existing knowledge, not assertions that someone has the answer. Move confirmed knowledge to known knowns and concrete unanswered questions to known unknowns.

Write “None” under known unknowns or unknown knowns only when no material gaps remain in that category. Unknown unknowns describe discovery coverage and limits, not a list of supposedly known hidden problems or a guarantee of completeness. Any material gap found by a blind-spot check becomes an explicit question with its dependency and next step.

Name one next action based on the user's requested deliverable. Use `to-prd` for a full PRD with technical implementation when material questions are resolved, or `to-spec` for a short specification that preserves remaining open questions. If the deliverable is unclear, settle that choice during clarification. Honor another next action explicitly requested by the user.

Then ask for explicit confirmation. Do not run the next action until the user confirms the summary. Keep unresolved questions visible in any handoff and leave dependent work blocked unless the user explicitly accepts an assumption.
