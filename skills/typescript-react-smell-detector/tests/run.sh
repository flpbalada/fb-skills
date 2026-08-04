#!/usr/bin/env bash
set -euo pipefail

test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
scanner="$test_dir/../scripts/scan.sh"
fixture="$test_dir/fixtures/project"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/ts-react-smell-test.XXXXXX")
trap 'rm -rf "$tmp"' EXIT

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_contains() {
  local text=$1 pattern=$2 message=$3
  printf '%s\n' "$text" | rg -q -- "$pattern" || fail "$message"
}

assert_not_contains() {
  local text=$1 pattern=$2 message=$3
  if printf '%s\n' "$text" | rg -q -- "$pattern"; then
    fail "$message"
  fi
}

assert_fails() {
  local message=$1
  shift
  if "$@" >/dev/null 2>&1; then
    fail "$message"
  fi
}

cp -R "$fixture" "$tmp/project"

text_output=$("$scanner" "$tmp/project")
assert_contains "$text_output" '\[signal/high\] ts-explicit-any \|' 'text output lacks signal metadata'
assert_contains "$text_output" '\[hotspot/low\] react-use-effect \|' 'text output lacks hotspot metadata'
assert_contains "$text_output" 'smells\.tsx:[0-9]+' 'text output lacks file and line'
while IFS= read -r rule; do
  assert_contains "$text_output" " $rule \\|" "fixture did not exercise $rule"
done < <("$scanner" --list-rules)

json_output=$("$scanner" --format jsonl --rule react-unstable-key "$tmp/project")
assert_contains "$json_output" '^\{"rule_id":"react-unstable-key","kind":"signal","confidence":"high","file":"[^"]+","line":[0-9]+,"evidence":"[^"]+"\}$' 'JSONL schema or key order changed'

excluded_output=$("$scanner" --rule ts-explicit-any "$tmp/project")
assert_contains "$excluded_output" 'smells\.tsx' 'included source was not scanned'
assert_not_contains "$excluded_output" 'generated/ignored\.ts' 'generated path was not excluded'
assert_not_contains "$excluded_output" 'example\.snapshot\.ts' 'snapshot path was not excluded'

filtered_output=$("$scanner" --rule react-use-state "$tmp/project")
assert_contains "$filtered_output" 'react-use-state' 'selected rule did not run'
assert_not_contains "$filtered_output" 'ts-explicit-any' 'unselected rule ran'

custom_excluded=$("$scanner" --rule ts-explicit-any --exclude '*/smells.tsx' "$tmp/project")
[[ "$custom_excluded" == 'No findings.' ]] || fail 'custom exclusion did not apply'

clean_output=$("$scanner" "$tmp/project/src/clean.ts")
[[ "$clean_output" == 'No findings.' ]] || fail 'clean file produced findings'

mkdir "$tmp/empty"
[[ "$("$scanner" "$tmp/empty")" == 'No findings.' ]] || fail 'empty directory did not report no findings'
[[ "$("$scanner" "$tmp/project/src/example.snapshot.ts")" == 'No findings.' ]] || fail 'explicitly excluded file did not report no findings'

printf '%s\n' '--with-filename' > "$tmp/ripgrep.conf"
configured_output=$(RIPGREP_CONFIG_PATH="$tmp/ripgrep.conf" "$scanner" --format jsonl --rule ts-explicit-any "$tmp/project/src/smells.tsx")
assert_contains "$configured_output" '"line":[0-9]+' 'ripgrep config corrupted JSONL output'

mkdir "$tmp/ignored"
printf '%s\n' 'ignored.ts' > "$tmp/ignored/.ignore"
printf '%s\n' 'export const ignored: any = 1;' > "$tmp/ignored/ignored.ts"
[[ "$("$scanner" "$tmp/ignored")" == 'No findings.' ]] || fail 'ignored source was scanned by default'
included_output=$("$scanner" --include-excluded --rule ts-explicit-any "$tmp/ignored")
assert_contains "$included_output" 'ignored\.ts:' '--include-excluded did not scan ignored source'

printf '%s\n' 'export const optionPath: any = 1;' > "$tmp/--source.ts"
option_path_output=$(CDPATH= cd -- "$tmp" && "$scanner" --rule ts-explicit-any -- --source.ts)
assert_contains "$option_path_output" '^--source\.ts:' 'option terminator did not allow a path beginning with --'

printf 'export const control: any = "value";\f\n' > "$tmp/control.ts"
control_output=$("$scanner" --format jsonl --rule ts-explicit-any "$tmp/control.ts")
assert_contains "$control_output" '\\f' 'JSONL did not escape a form-feed control character'

assert_fails 'unknown rule returned success' "$scanner" --rule missing-rule "$tmp/project"
assert_fails 'missing path returned success' "$scanner" "$tmp/does-not-exist"

cp -R "$fixture" "$tmp/repo"
git -C "$tmp/repo" init -q
git -C "$tmp/repo" config user.name Test
git -C "$tmp/repo" config user.email test@example.invalid
printf '%s\n' 'ignored.ts' > "$tmp/repo/.gitignore"
git -C "$tmp/repo" add .
git -C "$tmp/repo" commit -qm baseline
printf 'export const staged: any = 1;\n' > "$tmp/repo/staged.ts"
git -C "$tmp/repo" add staged.ts
printf '\nexport const unstaged: any = 2;\n' >> "$tmp/repo/src/clean.ts"
printf 'export const untracked: any = 3;\n' > "$tmp/repo/untracked.ts"
printf 'export const ignored: any = 4;\n' > "$tmp/repo/ignored.ts"

changed_output=$("$scanner" --changed --rule ts-explicit-any "$tmp/repo")
assert_contains "$changed_output" '^staged\.ts:' 'changed mode missed staged file'
assert_contains "$changed_output" '^src/clean\.ts:' 'changed mode missed unstaged file'
assert_contains "$changed_output" '^untracked\.ts:' 'changed mode missed untracked file'
assert_not_contains "$changed_output" '^ignored\.ts:' 'changed mode scanned an ignored file by default'
assert_not_contains "$changed_output" 'src/smells\.tsx' 'changed mode scanned unchanged file'

changed_included=$("$scanner" --changed --include-excluded --rule ts-explicit-any "$tmp/repo")
assert_contains "$changed_included" '^ignored\.ts:' '--include-excluded missed an ignored changed file'

printf 'PASS: output, exclusions, filtering, empty scans, errors, and changed mode\n'
