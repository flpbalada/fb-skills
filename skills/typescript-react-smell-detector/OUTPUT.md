# Synthesized Review Output

Inspect every scanner match in context. Report only confirmed findings.

## Format

```md
# TypeScript and React Smell Review

Scope: `[path or changed-file scope]`
Command: `[exact scanner command]`

## Confirmed Findings

- **[critical | high | medium | low] [short title]**: `[file:line]` `[rule_id]` (`kind`, `confidence` confidence) - [issue and impact]. Fix: [smallest useful change].
```

Sort findings by impact: `critical`, `high`, `medium`, then `low`. Scanner
`kind` and `confidence` are metadata, not impact severity. If no match is
confirmed, return `No confirmed findings.`
