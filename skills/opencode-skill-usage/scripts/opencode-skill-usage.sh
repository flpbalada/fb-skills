#!/usr/bin/env bash

set -euo pipefail

usage() {
  printf 'Usage: %s [positive-limit]\n' "${0##*/}" >&2
}

if (( $# > 1 )); then
  usage
  exit 2
fi

limit="${1:-20}"

if [[ ! "$limit" =~ ^[1-9][0-9]*$ ]]; then
  printf 'Error: limit must be a positive integer.\n' >&2
  usage
  exit 2
fi

if [[ -z "${HOME:-}" ]]; then
  printf 'Error: HOME is not set.\n' >&2
  exit 1
fi

database="$HOME/.local/share/opencode/opencode.db"

if ! command -v sqlite3 >/dev/null 2>&1; then
  printf 'Error: sqlite3 is not available in PATH.\n' >&2
  exit 1
fi

if [[ ! -r "$database" ]]; then
  printf 'Error: OpenCode database not readable: %s\n' "$database" >&2
  exit 1
fi

if ! results="$(
  sqlite3 -readonly -tabs "$database" "
    SELECT
      json_extract(data, '\$.state.input.name') AS skill,
      COUNT(*) AS uses
    FROM part
    WHERE json_valid(data)
      AND json_extract(data, '\$.type') = 'tool'
      AND json_extract(data, '\$.tool') = 'skill'
      AND json_extract(data, '\$.state.status') = 'completed'
      AND json_type(data, '\$.state.input.name') = 'text'
      AND json_extract(data, '\$.state.input.name') <> ''
    GROUP BY skill
    ORDER BY uses DESC, skill COLLATE NOCASE ASC
    LIMIT $limit;
  "
)"; then
  printf 'Error: failed to query OpenCode skill usage.\n' >&2
  exit 1
fi

printf '| Skill | Uses |\n'
printf '|---|---:|\n'

if [[ -z "$results" ]]; then
  printf '| _No completed skill calls found_ | 0 |\n'
  exit 0
fi

while IFS=$'\t' read -r skill uses; do
  printf '| %s | %s |\n' "$skill" "$uses"
done <<< "$results"
