# GPT-5.5 Prompt Guidance Primitives

Source: https://developers.openai.com/api/docs/guides/prompt-guidance, accessed 2026-07-09.

Use these as checks, not a required structure.

## Check

- Outcome: states the user-visible result.
- Success: defines done.
- Constraints: gives priority when rules conflict.
- Context: says what to use, ignore, retrieve, or treat as stale.
- Evidence: requires sources or placeholders for factual claims.
- Output: defines sections, length, tone, and format.
- Validation: says what to check, or how to explain skipped checks.
- Stop rules: says when to ask, retry, fallback, abstain, escalate, or stop.
- Tools: states allowed tools, side effects, approvals, and completion checks.
- Responses workflow: preserves preambles, `phase`, and assistant-item replay rules only when relevant.

## No-Op Detection

Flag a line as a no-op when removing it would not change behavior, output, validation, tool use, evidence, or rule priority.

Common no-ops:

- broad quality words: `good`, `best`, `high quality`, `robust`
- intensity words: `very`, `extremely`, `thoroughly`, `carefully`
- duplicated rules
- motivational filler
- process rules with no output or decision effect
- legacy rules copied from older prompts without a GPT-5.5 reason

Do not flag short rules that change behavior, such as a required format, tool, source, constraint, or stop rule.

## Reduce

- Put outcome before process.
- Keep detail only when it changes behavior.
- Merge overlapping rules.
- Replace vague terms with observable checks.
- Delete unsupported product facts, metrics, tools, and model claims.
- Add `Role`, `Personality`, `Goal`, `Success`, `Constraints`, `Output`, or `Stop rules` sections only when they change behavior.
