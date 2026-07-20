---
name: opencode-skill-usage
description: List completed OpenCode skill calls ranked by usage count. Use when users ask for most-used skills, skill usage counts, skill statistics, or a ranked skill usage table.
---

# OpenCode Skill Usage

Return completed OpenCode skill calls ranked by count.

## Input

Optional positive integer result limit.

Default: `20`.

## Flow

1. Resolve this skill's base directory from loaded skill metadata.
2. Run `<skill-base-directory>/scripts/opencode-skill-usage.sh`.
3. Pass user-provided limit when present.
4. Return script output unchanged.

Examples:

```bash
<skill-base-directory>/scripts/opencode-skill-usage.sh
<skill-base-directory>/scripts/opencode-skill-usage.sh 10
```

## Rules

- Query `~/.local/share/opencode/opencode.db`.
- Use read-only SQLite mode.
- Count only completed `skill` tool calls.
- Sort by count descending, then skill name ascending.
- Never modify database or other files.
- Preserve script errors instead of inventing results.
