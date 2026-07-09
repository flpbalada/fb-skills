---
name: gpt5-5-prompt-grill
description: Pressure-test, reduce, and rewrite prompts for GPT-5.5. Use when the user asks to grill, audit, critique, harden, improve, optimize, simplify, de-noise, or rewrite a prompt, system prompt, developer instruction, agent playbook, or tool-use workflow specifically for GPT-5.5; especially when it may contain no-op instructions, contradictions, vague rules, missing success criteria, missing output rules, missing validation, unsupported claims, or unclear stop rules.
---

# GPT-5.5 Prompt Grill

Make GPT-5.5 prompts shorter, sharper, and executable.

## Flow

1. Read [references/primitives.md](references/primitives.md).
2. Read the prompt, failure examples, and desired behavior.
3. Ask for the prompt only if it is missing.
4. Classify each issue as `blocker`, `no-op`, or `rewrite`.
5. Ask only when the missing answer changes behavior; include a recommended answer.
6. Rewrite after blockers are clear.
7. Re-check the rewrite against the primitives.
8. Use [TEMPLATE.md](TEMPLATE.md).

## Rules

- Preserve intent, useful constraints, and examples.
- Remove no-ops: vague, duplicated, decorative, or intensity-only rules.
- Replace vague quality words with observable behavior.
- Keep only instructions that change behavior, output, validation, tool use, evidence, or priority.
- Use `cause -> effect -> fix`.
- Do not invent product facts, metrics, tools, policies, or model capabilities.
