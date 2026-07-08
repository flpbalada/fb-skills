---
name: codebase-slop-audit
description: Detect sloppy-code signals with repo-wide search metrics and sampled evidence. Use when asked to audit codebase quality, "vibe coding", `isRecord`, broad `Record<string, unknown>` guards, fallback usage, excessive null guards, non-null assertions, unsafe type assertions, `node:*` imports in browser/shared code, swallowed errors, TODO debt, or code smell hotspots before refactoring.
---

# Codebase Slop Audit

Audit code quality with search metrics.
Counts guide inspection.
Evidence decides findings.

## Flow

1. Search source files with generated, build, vendor, and lock files excluded.
2. Count broad sloppy-code signals.
3. Rank files by repeated signals.
4. Inspect the top files before judging.
5. Report investigated findings.
6. Ask the user how to handle the findings before editing.
7. Use [TEMPLATE.md](TEMPLATE.md) for output.

## Scan

Use `rg`.
Start with this pattern, then narrow by repo language and folders:

```bash
rg -n "isRecord|Record<string,\s*(unknown|any)>|\bfallback\b|fallback[A-Z]|return\s+(null|undefined)|===?\s*(null|undefined)|!==?\s*(null|undefined)|\?\?|\?\.|[A-Za-z0-9_\)\]]!|\bas\s+(any|unknown|Record<)|:\s*any\b|from\s+['\"]node:|import\(['\"]node:|catch\s*\(|console\.(error|warn)|TODO|FIXME|HACK|workaround" . \
  --glob '*.{ts,tsx,js,jsx,astro,vue,svelte}' \
  --glob '!node_modules/**' \
  --glob '!dist/**' \
  --glob '!build/**' \
  --glob '!coverage/**' \
  --glob '!**/generated/**' \
  --glob '!**/*.generated.*' \
  --glob '!*.lock'
```

Rank hotspot files:

```bash
rg -n "isRecord|Record<string,\s*(unknown|any)>|\bfallback\b|===?\s*(null|undefined)|!==?\s*(null|undefined)|\?\?|\?\.|\bas\s+(any|unknown)|:\s*any\b|from\s+['\"]node:|import\(['\"]node:|TODO|FIXME|HACK|workaround" . \
  | cut -d: -f1 \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -20
```

## Signals

- `isRecord`, `Record<string, unknown>`, or `Record<string, any>`.
- Fallbacks, default objects, `return null`, or `return undefined`.
- Repeated null or undefined guards, optional chaining, or nullish coalescing.
- Non-null assertions.
- `as any`, broad `as Type`, assertion chains, or `: any`.
- `node:*` imports outside scripts, config, CLI, build-time, or server-only files.
- Swallowed errors, generic errors, `console.error`, or `console.warn`.
- `TODO`, `FIXME`, `HACK`, `temporary`, or `workaround`.

## Judgment

Valid:

- Boundary code parses external JSON, CMS, API, DB, file, env, URL, or message data.
- Code narrows once, normalizes once, and gives the app a typed shape.
- Optional data is truly optional and does not hide a required invariant.
- `node:*` imports stay in server-only or build-time code.

Sloppy:

- Guards, fallbacks, or assertions repeat inside domain, UI, or business logic.
- Missing required data becomes empty arrays, default objects, `null`, or `undefined`.
- Type escapes replace runtime validation.
- `node:*` imports can reach browser bundles or shared frontend modules.
- Error handling drops cause, context, or user-visible failure.
