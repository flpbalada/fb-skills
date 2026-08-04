#!/usr/bin/env bash
set -euo pipefail

rd_test_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rd_scripts_dir=$(CDPATH= cd -- "$rd_test_dir/.." && pwd)
rd_skill_dir=$(CDPATH= cd -- "$rd_scripts_dir/.." && pwd)
rd_renderer=$rd_scripts_dir/render-diff.sh
rd_analyzer=$rd_scripts_dir/awk/analyze-diff.awk
rd_fixtures=$rd_test_dir/fixtures
rd_tmp=$(mktemp -d "${TMPDIR:-/tmp}/render-reading-diff-tests.XXXXXX")
trap 'rm -rf "$rd_tmp"' EXIT
rd_passed=0

rd_pass() { rd_passed=$((rd_passed + 1)); printf 'ok %d - %s\n' "$rd_passed" "$1"; }
rd_fail() { printf 'not ok - %s\n' "$1" >&2; exit 1; }
rd_contains() { grep -Fq -- "$2" "$1" || rd_fail "missing: $2"; }
rd_not_matches() { ! grep -Eq -- "$2" "$1" || rd_fail "unexpected pattern: $2"; }
rd_count() { grep -Foc -- "$2" "$1" || true; }

rd_write_summary() {
  local rd_path=$1
  local rd_important=$2
  local rd_risks=${3:-Behavior}
  {
    printf '%s\n' 'Source: git diff main...feature' 'Sentence: Keeps meaningful changes and marks mechanical work.' "Important count: $rd_important"
    if [[ $rd_risks == None ]]; then
      printf '%s\n' 'Risks: None'
    else
      printf '%s\n' 'Risks:' "- $rd_risks"
    fi
  } > "$rd_path"
}

rd_render() {
  local rd_original=$1
  local rd_abridged=$2
  local rd_summary=$3
  local rd_output=$4
  "$rd_renderer" --original "$rd_original" --abridged "$rd_abridged" --summary "$rd_summary" --output "$rd_output" >/dev/null
}

rd_section_contains() {
  local rd_file=$1
  local rd_id=$2
  local rd_text=$3
  awk -v id="id=\"$rd_id\"" -v text="$rd_text" '
    index($0, id) { inside = 1 }
    inside && index($0, text) { found = 1 }
    inside && /<\/section>/ { exit }
    END { exit !found }
  ' "$rd_file" || rd_fail "$rd_id missing grouped text: $rd_text"
}

rd_original_contains() {
  local rd_file=$1
  local rd_text=$2
  awk -v text="$rd_text" '
    /<details id="original-diff">/ { inside = 1 }
    inside && index($0, text) { found = 1 }
    END { exit !found }
  ' "$rd_file" || rd_fail "complete original missing: $rd_text"
}

rd_summary=$rd_tmp/summary.txt
rd_write_summary "$rd_summary" 3 'API contract'
rd_report=$rd_tmp/report.html
rd_render "$rd_fixtures/multi-file.diff" "$rd_fixtures/mixed-changes.diff" "$rd_summary" "$rd_report"

# 1. Original order, per-file sections, unique targets, and exact totals.
rd_contains "$rd_report" '<dt>Changed files</dt><dd>4</dd>'
rd_contains "$rd_report" '<dt>Additions</dt><dd>+4</dd>'
rd_contains "$rd_report" '<dt>Removals</dt><dd>−4</dd>'
rd_contains "$rd_report" '<dt>Important files</dt><dd>3</dd>'
rd_contains "$rd_report" '<p class="source">git diff main...feature</p>'
rd_contains "$rd_report" '<p class="sentence">Keeps meaningful changes and marks mechanical work.</p>'
rd_contains "$rd_report" '<span class="risk risk-api-contract">API contract</span>'
for rd_number in 1 2 3 4; do
  [[ $(rd_count "$rd_report" "href=\"#file-$rd_number\"") -eq 1 ]] || rd_fail "sidebar target file-$rd_number is not unique"
  [[ $(rd_count "$rd_report" "id=\"file-$rd_number\"") -eq 1 ]] || rd_fail "section file-$rd_number is not unique"
done
awk '/id="file-1"/{a=NR}/id="file-2"/{b=NR}/id="file-3"/{c=NR}/id="file-4"/{d=NR} END{exit !(a<b && b<c && c<d)}' "$rd_report" || rd_fail 'file order changed'
rd_pass 'exact totals, original order, and unique targets'

# 2. Omission marker stays with its abridged file and receives its own class.
rd_section_contains "$rd_report" file-1 '# ... 2 mechanical lines omitted ...'
rd_contains "$rd_report" 'class="line omission"># ... 2 mechanical lines omitted ...'
rd_section_contains "$rd_report" file-1 '+new behavior'
rd_pass 'omission marker grouping and retained mixed changes'

# 3. Entirely mechanical and generated file appears in section and sidebar.
rd_section_contains "$rd_report" file-2 'All changes classified as mechanical.'
rd_contains "$rd_report" 'dist/generated.min.js<span class="nav-meta">+1 −1</span><span class="status status-modified">modified</span><span class="indicator generated">generated</span><span class="indicator mechanical">all mechanical</span>'
rd_pass 'entirely mechanical generated file indicators'

# 4. Added and deleted status/count metadata.
rd_section_contains "$rd_report" file-3 'status status-added'
rd_section_contains "$rd_report" file-4 'status status-deleted'
rd_contains "$rd_report" 'src/added.txt<span class="nav-meta">+1 −0</span>'
rd_contains "$rd_report" 'src/deleted.txt<span class="nav-meta">+0 −1</span>'
rd_pass 'added and deleted file metadata'

# 5. Complete original remains collapsed, escaped, and mechanically complete.
rd_contains "$rd_report" '<button id="original-toggle" aria-controls="original-diff" aria-expanded="false">'
rd_contains "$rd_report" '<details id="original-diff">'
rd_not_matches "$rd_report" '<details id="original-diff"[^>]* open'
rd_contains "$rd_report" '-var a=1;'
rd_contains "$rd_report" '+var a=2;'
rd_pass 'complete collapsed original diff'

# 6. Renamed and binary files keep distinct metadata and notices.
rd_write_summary "$rd_tmp/one-summary.txt" 1 Migration
rd_render "$rd_fixtures/renamed-file.diff" "$rd_fixtures/renamed-file.diff" "$rd_tmp/one-summary.txt" "$rd_tmp/renamed.html"
rd_contains "$rd_tmp/renamed.html" 'docs/old guide.md → docs/new guide.md'
rd_contains "$rd_tmp/renamed.html" 'status status-renamed'
rd_render "$rd_fixtures/binary-file.diff" "$rd_fixtures/binary-file.diff" "$rd_tmp/one-summary.txt" "$rd_tmp/binary.html"
rd_contains "$rd_tmp/binary.html" 'indicator binary'
rd_contains "$rd_tmp/binary.html" 'class="line binary-notice">Binary files'
cat > "$rd_tmp/supplied.diff" <<'EOF'
--- a/src/supplied.txt
+++ b/src/supplied.txt
@@ -1 +1 @@
-before
+after
EOF
rd_render "$rd_tmp/supplied.diff" "$rd_tmp/supplied.diff" "$rd_tmp/one-summary.txt" "$rd_tmp/supplied.html"
rd_contains "$rd_tmp/supplied.html" 'src/supplied.txt'
rd_contains "$rd_tmp/supplied.html" '<dt>Additions</dt><dd>+1</dd>'
rd_pass 'renamed, binary, and supplied unified diff rendering'

# 7. C-style quoted Unicode paths and hostile content are escaped once.
rd_write_summary "$rd_tmp/unsafe-summary.txt" 1 Security
rd_render "$rd_fixtures/unsafe-content.diff" "$rd_fixtures/unsafe-content.diff" "$rd_tmp/unsafe-summary.txt" "$rd_tmp/unsafe.html"
rd_contains "$rd_tmp/unsafe.html" 'src/naïve &lt;&amp; &quot;quote&quot;&gt;.txt'
rd_contains "$rd_tmp/unsafe.html" '&lt;script&gt;alert(&quot;unsafe &amp; risky&quot;)&lt;/script&gt;'
rd_contains "$rd_tmp/unsafe.html" '&lt;style&gt;bad &amp; &#39;single&#39; &quot;double&quot; `tick`&lt;/style&gt;'
rd_contains "$rd_tmp/unsafe.html" '&lt;div data-value=&#39;single&#39; title=&quot;double&quot;&gt;`tick` &amp; text&lt;/div&gt;'
rd_original_contains "$rd_tmp/unsafe.html" '&lt;style&gt;bad &amp; &#39;single&#39; &quot;double&quot; `tick`&lt;/style&gt;'
rd_original_contains "$rd_tmp/unsafe.html" '&lt;span onclick=&quot;bad()&quot;&gt;old&lt;/span&gt;'
rd_not_matches "$rd_tmp/unsafe.html" '<script>alert|</style><span|onclick="bad'
rd_pass 'quoted Unicode paths and hostile HTML safety'

# 8. Empty abridged succeeds; empty original fails with no report.
: > "$rd_tmp/empty.diff"
rd_write_summary "$rd_tmp/zero-summary.txt" 0 None
rd_render "$rd_fixtures/multi-file.diff" "$rd_tmp/empty.diff" "$rd_tmp/zero-summary.txt" "$rd_tmp/empty-abridged.html"
[[ $(rd_count "$rd_tmp/empty-abridged.html" 'All changes classified as mechanical.') -eq 4 ]] || rd_fail 'empty abridged did not mark every file mechanical'
! "$rd_renderer" --original "$rd_tmp/empty.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/zero-summary.txt" --output "$rd_tmp/empty-original.html" 2> "$rd_tmp/empty.err" || rd_fail 'empty original succeeded'
rd_contains "$rd_tmp/empty.err" 'No changes found'
[[ ! -e $rd_tmp/empty-original.html ]] || rd_fail 'empty original created a report'
rd_pass 'empty abridged accepted and empty original rejected'

# 9. Large multi-hunk input uses macOS-default shell tools only.
{
  printf '%s\n' 'diff --git a/src/large.txt b/src/large.txt' 'index 1111111..2222222 100644' '--- a/src/large.txt' '+++ b/src/large.txt'
  rd_number=1
  while [[ $rd_number -le 250 ]]; do
    printf '@@ -%d +%d @@\n-old %d\n+new %d\n' "$rd_number" "$rd_number" "$rd_number" "$rd_number"
    rd_number=$((rd_number + 1))
  done
} > "$rd_tmp/large.diff"
rd_render "$rd_tmp/large.diff" "$rd_tmp/large.diff" "$rd_tmp/one-summary.txt" "$rd_tmp/large.html"
rd_contains "$rd_tmp/large.html" '<dt>Additions</dt><dd>+250</dd>'
rd_contains "$rd_tmp/large.html" '<dt>Removals</dt><dd>−250</dd>'
rd_contains "$rd_tmp/large.html" '@@ -250 +250 @@'
rd_pass 'large multi-hunk diff without seq'

# 10. Invalid input leaves no partial output and rejects aliases/directories.
! "$rd_renderer" --original "$rd_fixtures/multi-file.diff" >/dev/null 2>&1 || rd_fail 'missing options accepted'
! "$rd_renderer" --unknown value >/dev/null 2>&1 || rd_fail 'unknown option accepted'
! "$rd_renderer" --original "$rd_tmp/missing.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/zero-summary.txt" --output "$rd_tmp/missing.html" >/dev/null 2>&1 || rd_fail 'unreadable input accepted'
! "$rd_renderer" --original "$rd_fixtures/multi-file.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/zero-summary.txt" --output "$rd_fixtures/../fixtures/multi-file.diff" >/dev/null 2>&1 || rd_fail 'same-path alias accepted'
! "$rd_renderer" --original "$rd_fixtures/multi-file.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/zero-summary.txt" --output "$rd_tmp/missing-dir/report.html" >/dev/null 2>&1 || rd_fail 'invalid output directory accepted'
printf '%s\n' 'unreadable' > "$rd_tmp/unreadable.diff"
chmod 000 "$rd_tmp/unreadable.diff"
! "$rd_renderer" --original "$rd_tmp/unreadable.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/zero-summary.txt" --output "$rd_tmp/unreadable.html" >/dev/null 2>&1 || rd_fail 'unreadable file accepted'
chmod 600 "$rd_tmp/unreadable.diff"
printf '%s\n' 'Source: invalid' > "$rd_tmp/bad-summary.txt"
printf '%s\n' 'existing output' > "$rd_tmp/no-partial.html"
! "$rd_renderer" --original "$rd_fixtures/multi-file.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/bad-summary.txt" --output "$rd_tmp/no-partial.html" >/dev/null 2>&1 || rd_fail 'invalid summary accepted'
[[ $(< "$rd_tmp/no-partial.html") == 'existing output' ]] || rd_fail 'failure replaced requested output'
{
  printf '%s\n' 'Source: invalid risk' 'Sentence: Reject arbitrary prose risk.' 'Important count: 0' 'Risks:' '- This is arbitrary risk prose.'
} > "$rd_tmp/bad-risk.txt"
! "$rd_renderer" --original "$rd_fixtures/multi-file.diff" --abridged "$rd_tmp/empty.diff" --summary "$rd_tmp/bad-risk.txt" --output "$rd_tmp/bad-risk.html" >/dev/null 2>&1 || rd_fail 'arbitrary risk prose accepted'
[[ ! -e $rd_tmp/bad-risk.html ]] || rd_fail 'invalid risk created output'
rd_pass 'invalid inputs and atomic no-partial behavior'

# 11. Accessible controls, embedded assets, themes, and offline document.
[[ $(rd_count "$rd_report" '<!doctype html>') -eq 1 && $(rd_count "$rd_report" '<html lang="en">') -eq 1 ]] || rd_fail 'not exactly one HTML document'
rd_contains "$rd_report" '<button id="menu-toggle" aria-controls="sidebar" aria-expanded="false">'
rd_contains "$rd_report" '<button id="diff-toggle" aria-controls="abridged-diff original-diff" aria-pressed="false">Full diff</button>'
rd_contains "$rd_report" '.abridged-files .diff-metadata { display: none; }'
rd_contains "$rd_report" '<label for="file-filter">Filter changed files</label>'
rd_contains "$rd_report" 'IntersectionObserver'
rd_contains "$rd_report" '@media (prefers-color-scheme: dark)'
rd_contains "$rd_report" '@media print'
rd_contains "$rd_report" ':focus-visible'
rd_not_matches "$rd_report" 'https?://|href="//|src="//|<link |innerHTML|eval\(|fetch\(|XMLHttpRequest'
rd_pass 'accessible controls, embedded assets, dark and print modes'

# 12. Static structure, source order, names, and syntax.
bash -n "$rd_renderer" "$rd_scripts_dir"/lib/*.sh "$rd_test_dir/run-tests.sh"
awk -f "$rd_analyzer" /dev/null >/dev/null
awk -v mode=original -v analysis=/dev/null -v abridged_analysis=/dev/null -f "$rd_scripts_dir/awk/render-diff.awk" /dev/null >/dev/null
[[ $(wc -l < "$rd_renderer") -le 100 ]] || rd_fail 'render-diff.sh exceeds 100 lines'
! grep -Eh '^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(\)[[:space:]]*\{' "$rd_renderer" "$rd_scripts_dir"/lib/*.sh "$rd_test_dir/run-tests.sh" | grep -Ev '^[[:space:]]*rd_' >/dev/null || rd_fail 'shell function lacks rd_ prefix'
rd_sources=$(grep '^source ' "$rd_renderer" | tr '\n' ' ')
[[ $rd_sources == *'lib/arguments.sh'*'lib/filesystem.sh'*'lib/html.sh'*'lib/report.sh'* ]] || rd_fail 'source order changed'
rd_expected_files=$(cat <<'EOF'
agents/openai.yaml
assets/report.css
assets/report.js
scripts/awk/analyze-diff.awk
scripts/awk/render-diff.awk
scripts/lib/arguments.sh
scripts/lib/filesystem.sh
scripts/lib/html.sh
scripts/lib/report.sh
scripts/render-diff.sh
scripts/tests/fixtures/binary-file.diff
scripts/tests/fixtures/mixed-changes.diff
scripts/tests/fixtures/multi-file.diff
scripts/tests/fixtures/renamed-file.diff
scripts/tests/fixtures/unsafe-content.diff
scripts/tests/run-tests.sh
SKILL.md
EOF
)
rd_actual_files=$(find "$rd_skill_dir" -type f | while IFS= read -r rd_file; do printf '%s\n' "${rd_file#"$rd_skill_dir/"}"; done | sort)
[[ $rd_actual_files == "$rd_expected_files" ]] || rd_fail 'unexpected source files'
rd_pass 'static syntax, prefixes, source order, and exact structure'

printf 'PASS: %d substantive test categories\n' "$rd_passed"
