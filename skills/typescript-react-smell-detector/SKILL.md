---
name: typescript-react-smell-detector
description: Scan TypeScript and React code for precise signals and contextual hotspots. Use when listing potential code smells for review.
---

# TypeScript React Smell Detector

List potential TypeScript and React code smells for review.

## Flow

1. Run `scripts/scan.sh [path]` or add `--changed` for Git changes.
2. Review `signal` findings before `hotspot` findings.
3. Inspect context and separate confirmed issues from dismissed matches.

## Commands

```bash
# Scan a path
skills/typescript-react-smell-detector/scripts/scan.sh src

# Scan Git changes as JSONL
skills/typescript-react-smell-detector/scripts/scan.sh --changed --format jsonl

# Select rules or exclude paths
skills/typescript-react-smell-detector/scripts/scan.sh \
  --rule react-unstable-key \
  --exclude 'examples/**' .
```

See [REFERENCE.md](REFERENCE.md) for flags, rules, output, exclusions, and limits.

## Rules

- Treat every match as advisory; `signal` means precise syntax and `hotspot` means contextual review.
- Inspect code before judging or editing it.
- Do not infer code quality from match counts.
- Use `codebase-slop-audit` for general repository hygiene.

## Test

```bash
bash skills/typescript-react-smell-detector/tests/run.sh
```
