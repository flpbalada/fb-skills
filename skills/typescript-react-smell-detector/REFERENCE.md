# Scanner Reference

## Requirements

- Bash 3.2 or newer
- ripgrep (`rg`)
- Git for `--changed`

## CLI

```text
scan.sh [options] [path]

Options:
  --changed             Scan staged, unstaged, and untracked files in the path's Git worktree.
  --format text|jsonl   Select output format. Default: text.
  --rule ID             Run one rule. Repeat to select more rules.
  --exclude GLOB        Exclude a shell-style path glob. Repeat as needed.
  --include-excluded    Include ignored files and disable default exclusions except .git.
  --list-rules          Print stable rule IDs and exit.
  --                    End options, allowing a path that begins with --.
  -h, --help            Show help.
```

The target defaults to the current directory. In `--changed` mode, it locates a Git worktree; the scanner then considers all changed files in that worktree.

Default exclusions cover dependency, vendor, generated, build, declaration, fixture, and snapshot paths, including `node_modules`, `vendor`, `generated`, `dist`, `build`, `coverage`, `.next`, `out`, `fixtures`, snapshots, and `*.d.ts`.
The scanner reads `.ts`, `.tsx`, `.js`, and `.jsx` files, plus `tsconfig*.json` for the strict-mode rule.

## Output

Text fields are ordered as:

```text
file:line [kind/confidence] rule_id | evidence
```

JSONL uses one object per finding with this stable key order:

```json
{"rule_id":"...","kind":"signal","confidence":"high","file":"...","line":1,"evidence":"..."}
```

No JSONL records means no findings; text mode prints `No findings.`.

## Rules

| Rule ID | Kind | Confidence |
|---|---|---|
| `ts-explicit-any` | signal | high |
| `ts-unsafe-assertion` | signal | medium |
| `ts-non-null-assertion` | signal | medium |
| `ts-suppression-comment` | signal | high |
| `ts-strict-disabled` | signal | high |
| `ts-constrained-generic` | hotspot | low |
| `ts-interface-intersection` | hotspot | medium |
| `ts-satisfies-candidate` | hotspot | medium |
| `rhf-double-registration` | signal | high |
| `rhf-controlled-register` | hotspot | medium |
| `rhf-controller-watch` | hotspot | low |
| `react-unstable-key` | signal | high |
| `react-query-action-errors` | hotspot | low |
| `react-use-callback` | hotspot | low |
| `react-use-client` | hotspot | low |
| `react-use-memo` | hotspot | low |
| `react-use-state` | hotspot | low |
| `react-state-from-prop` | hotspot | low |
| `react-use-effect` | hotspot | low |
| `react-effect-state-update` | hotspot | medium |

## Limits

- Regex sees text, not syntax trees, types, imports, or runtime behavior.
- Comments, strings, examples, and shadowed function names can match.
- Most rules inspect one line. Multiline assertions, JSX props, and Hook Form double registration can be missed.
- Effect state-update, prop-state, and controlled-register rules only flag review candidates; each pattern can be intentional.
- Generic, intersection, `satisfies`, hook, Controller/watch, client-boundary, and mutation findings require context and are never labeled defects.
- The React Query rule only runs in files that mention both `useMutation` and an action marker; this favors precision but misses indirect wrappers.
- Non-null and assertion patterns intentionally miss ambiguous forms rather than report broad noise.
