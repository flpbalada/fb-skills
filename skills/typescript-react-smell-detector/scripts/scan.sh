#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage: scan.sh [options] [path]

Options:
  --changed             Scan staged, unstaged, and untracked Git files.
  --format text|jsonl   Output format. Default: text.
  --rule ID             Run one rule. Repeatable.
  --exclude GLOB        Exclude a relative path glob. Repeatable.
  --include-excluded    Include ignored files and disable default exclusions.
  --list-rules          Print rule IDs and exit.
  --                    End options.
  -h, --help            Show this help.
EOF
}

rule_ids=(
  ts-explicit-any
  ts-unsafe-assertion
  ts-non-null-assertion
  ts-suppression-comment
  ts-strict-disabled
  ts-constrained-generic
  ts-interface-intersection
  ts-satisfies-candidate
  rhf-double-registration
  rhf-controlled-register
  rhf-controller-watch
  react-unstable-key
  react-query-action-errors
  react-use-callback
  react-use-client
  react-use-memo
  react-use-state
  react-state-from-prop
  react-use-effect
  react-effect-state-update
)

is_rule() {
  local candidate=$1 rule
  for rule in "${rule_ids[@]}"; do
    [[ "$candidate" == "$rule" ]] && return 0
  done
  return 1
}

changed=false
format=text
include_excluded=false
selected_rules=()
custom_excludes=()
target=

while (( $# > 0 )); do
  case "$1" in
    --changed)
      changed=true
      shift
      ;;
    --format)
      (( $# >= 2 )) || { usage; exit 2; }
      format=$2
      shift 2
      ;;
    --rule)
      (( $# >= 2 )) || { usage; exit 2; }
      is_rule "$2" || { printf 'Error: unknown rule: %s\n' "$2" >&2; exit 2; }
      selected_rules+=("$2")
      shift 2
      ;;
    --exclude)
      (( $# >= 2 )) || { usage; exit 2; }
      custom_excludes+=("$2")
      shift 2
      ;;
    --include-excluded)
      include_excluded=true
      shift
      ;;
    --list-rules)
      printf '%s\n' "${rule_ids[@]}"
      exit 0
      ;;
    --)
      shift
      (( $# <= 1 )) || { printf 'Error: only one path may be provided.\n' >&2; exit 2; }
      if (( $# == 1 )); then
        [[ -z "$target" ]] || { printf 'Error: only one path may be provided.\n' >&2; exit 2; }
        target=$1
      fi
      break
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      printf 'Error: unknown option: %s\n' "$1" >&2
      usage
      exit 2
      ;;
    *)
      [[ -z "$target" ]] || { printf 'Error: only one path may be provided.\n' >&2; exit 2; }
      target=$1
      shift
      ;;
  esac
done

[[ "$format" == text || "$format" == jsonl ]] || {
  printf 'Error: format must be text or jsonl.\n' >&2
  exit 2
}

target=${target:-.}
[[ -e "$target" ]] || { printf 'Error: path does not exist: %s\n' "$target" >&2; exit 1; }
command -v rg >/dev/null 2>&1 || { printf 'Error: rg is required.\n' >&2; exit 1; }

if (( ${#selected_rules[@]} == 0 )); then
  selected_rules=("${rule_ids[@]}")
fi

is_excluded() {
  local path=${1#./} pattern

  [[ "/$path/" == */.git/* ]] && return 0

  if [[ "$include_excluded" == false ]]; then
    case "/$path/" in
      */node_modules/*|*/vendor/*|*/deps/*|*/generated/*|*/dist/*|*/build/*|*/coverage/*|*/.next/*|*/out/*|*/fixtures/*|*/__fixtures__/*|*/snapshots/*|*/__snapshots__/*) return 0 ;;
    esac
    case "$path" in
      *.d.ts|*.generated.*|*.snap|*.snapshot.*) return 0 ;;
    esac
  fi

  for pattern in "${custom_excludes[@]-}"; do
    [[ -n "$pattern" ]] || continue
    [[ "$path" == $pattern || "$path" == */$pattern ]] && return 0
  done
  return 1
}

files=()
file_list=$(mktemp "${TMPDIR:-/tmp}/ts-react-smell-files.XXXXXX") || {
  printf 'Error: could not create temporary file.\n' >&2
  exit 1
}
trap 'rm -f "$file_list"' EXIT

add_file() {
  local file=$1 existing
  case "$file" in
    *.ts|*.tsx|*.js|*.jsx|*/tsconfig*.json|tsconfig*.json) ;;
    *) return 0 ;;
  esac
  is_excluded "$file" && return 0
  [[ -f "$file" ]] || return 0
  for existing in "${files[@]-}"; do
    [[ -n "$existing" ]] || continue
    [[ "$existing" == "$file" ]] && return 0
  done
  files+=("$file")
}

if [[ "$changed" == true ]]; then
  command -v git >/dev/null 2>&1 || { printf 'Error: git is required for --changed.\n' >&2; exit 1; }
  git_target=$target
  [[ -d "$git_target" ]] || git_target=$(dirname -- "$git_target")
  repo_root=$(git -C "$git_target" rev-parse --show-toplevel 2>/dev/null) || {
    printf 'Error: --changed requires a Git worktree.\n' >&2
    exit 1
  }

  append_git_files() {
    local error=$1
    shift
    "$@" >> "$file_list" || { printf 'Error: %s\n' "$error" >&2; exit 1; }
  }

  append_git_files 'could not list staged files.' git -C "$repo_root" diff --cached --name-only --diff-filter=ACMR -z
  append_git_files 'could not list unstaged files.' git -C "$repo_root" diff --name-only --diff-filter=ACMR -z
  untracked_args=(git -C "$repo_root" ls-files --others -z)
  [[ "$include_excluded" == true ]] || untracked_args+=(--exclude-standard)
  append_git_files 'could not list untracked files.' "${untracked_args[@]}"
  while IFS= read -r -d '' relative; do add_file "$repo_root/$relative"; done < "$file_list"
else
  if [[ -f "$target" ]]; then
    add_file "$target"
  else
    discovery_args=(--no-config --files --sort path --hidden -0 -g '!.git/**')
    [[ "$include_excluded" == false ]] || discovery_args+=(--no-ignore)
    status=0
    rg "${discovery_args[@]}" -- "$target" > "$file_list" || status=$?
    if (( status > 1 )); then
      printf 'Error: could not list source files under %s.\n' "$target" >&2
      exit 1
    fi
    while IFS= read -r -d '' file; do add_file "$file"; done < "$file_list"
  fi
fi

if (( ${#files[@]} == 0 )); then
  [[ "$format" == jsonl ]] || printf 'No findings.\n'
  exit 0
fi

print_rule_metadata() {
  printf '%s\t%s\t%s' "$1" "$2" "$3"
}

rule_metadata() {
  case "$1" in
    ts-explicit-any) print_rule_metadata signal high '(:[[:space:]]*any\b|<any>|Array<[[:space:]]*any[[:space:]]*>|\bany\[\])' ;;
    ts-unsafe-assertion) print_rule_metadata signal medium '(\bas[[:space:]]+any\b|\bas[[:space:]]+unknown[[:space:]]+as\b)' ;;
    ts-non-null-assertion) print_rule_metadata signal medium '[[:alnum:]_)\]}]![.?,;:)\[]' ;;
    ts-suppression-comment) print_rule_metadata signal high '^[[:space:]]*//[[:space:]]*@ts-(ignore|nocheck)\b' ;;
    ts-strict-disabled) print_rule_metadata signal high '"strict"[[:space:]]*:[[:space:]]*false\b' ;;
    ts-constrained-generic) print_rule_metadata hotspot low '<[A-Z][A-Za-z0-9_]*[[:space:]]+extends[[:space:]]+(string|number|boolean|[A-Z][A-Za-z0-9_]*)' ;;
    ts-interface-intersection) print_rule_metadata hotspot medium '^[[:space:]]*(export[[:space:]]+)?type[[:space:]]+[A-Z][A-Za-z0-9_]*[[:space:]]*=.*&' ;;
    ts-satisfies-candidate) print_rule_metadata hotspot medium '(const|let)[[:space:]]+[A-Za-z0-9_]+[[:space:]]*:[[:space:]]*(Record<|[^=]+)[[:space:]]*=.*\{|\}[[:space:]]+as[[:space:]]+(const[[:space:]]+)?(Record<|[A-Z][A-Za-z0-9_]*)' ;;
    rhf-double-registration) print_rule_metadata signal high '(Controller|\bfield\b).*\{\.\.\.register\(|\{\.\.\.register\([^)]*\)\}.*(Controller|\bfield\b)' ;;
    rhf-controlled-register) print_rule_metadata hotspot medium '(\{\.\.\.register\([^)]*\)\}.*(value|onChange)=|(value|onChange)=.*\{\.\.\.register\()' ;;
    rhf-controller-watch) print_rule_metadata hotspot low '\b(Controller|useController|watch|useWatch)[[:space:]]*[(<]' ;;
    react-unstable-key) print_rule_metadata signal high 'key=\{(index|idx|i|Math\.random\(\)|Date\.now\(\)|useId\(\)|crypto\.randomUUID\(\)|nanoid\(\))\}' ;;
    react-query-action-errors) print_rule_metadata hotspot low '\b(useMutation|mutationFn|throwOnError|onError)[[:space:]]*[:(<]' ;;
    react-use-callback) print_rule_metadata hotspot low '\buseCallback[[:space:]]*[(<]' ;;
    react-use-client) print_rule_metadata hotspot low '^[[:space:]]*["'\'' ]use client["'\'' ][[:space:]]*;?[[:space:]]*$' ;;
    react-use-memo) print_rule_metadata hotspot low '\buseMemo[[:space:]]*[(<]' ;;
    react-use-state) print_rule_metadata hotspot low '\buseState[[:space:]]*[(<]' ;;
    react-state-from-prop) print_rule_metadata hotspot low '\buseState([[:space:]]*<[^>]+>)?[[:space:]]*\([[:space:]]*props\.' ;;
    react-use-effect) print_rule_metadata hotspot low '\buseEffect[[:space:]]*\(' ;;
    react-effect-state-update) print_rule_metadata hotspot medium '\buseEffect[[:space:]]*\(.*\bset[A-Z][A-Za-z0-9_]*[[:space:]]*\(' ;;
  esac
}

rule_applies_to_file() {
  if [[ "$1" == ts-strict-disabled ]]; then
    case "$2" in
      */tsconfig*.json|tsconfig*.json) return 0 ;;
      *) return 1 ;;
    esac
  fi

  [[ "$2" != *.json ]]
}

json_escape() {
  local value=$1 result= char escaped code index=0
  while (( index < ${#value} )); do
    char=${value:index:1}
    case "$char" in
      \\) escaped='\\\\' ;;
      \" ) escaped='\\"' ;;
      $'\b') escaped='\\b' ;;
      $'\f') escaped='\\f' ;;
      $'\n') escaped='\\n' ;;
      $'\r') escaped='\\r' ;;
      $'\t') escaped='\\t' ;;
      *)
        printf -v code '%d' "'$char"
        if (( code < 32 )); then
          printf -v escaped '\\u%04x' "$code"
        else
          escaped=$char
        fi
        ;;
    esac
    result+=$escaped
    index=$((index + 1))
  done
  printf '%s' "$result"
}

display_path() {
  local file=$1
  if [[ "$changed" == true && "$file" == "$repo_root/"* ]]; then
    printf '%s' "${file#"$repo_root/"}"
    return
  fi
  printf '%s' "${file#./}"
}

finding_count=0
for rule in "${selected_rules[@]}"; do
  IFS=$'\t' read -r kind confidence pattern <<< "$(rule_metadata "$rule")"
  for file in "${files[@]}"; do
    rule_applies_to_file "$rule" "$file" || continue
    if [[ "$rule" == react-query-action-errors ]]; then
      rg --no-config -q '\buseMutation\b' -- "$file" || continue
      rg --no-config -q '([Aa]ction\b|use server|action\()' -- "$file" || continue
    fi

    status=0
    matches=$(rg --no-config -n --no-heading --color never -e "$pattern" -- "$file") || status=$?
    if (( status > 1 )); then
      printf 'Error: rg failed while scanning %s.\n' "$file" >&2
      exit 1
    fi
    (( status == 0 )) || continue

    output_file=$(display_path "$file")
    if [[ "$format" == jsonl ]]; then
      escaped_output_file=$(json_escape "$output_file")
    fi
    while IFS= read -r match; do
      line=${match%%:*}
      evidence=${match#*:}
      if [[ "$rule" == rhf-controller-watch && "$evidence" == *register\(* ]]; then
        continue
      fi
      finding_count=$((finding_count + 1))
      if [[ "$format" == jsonl ]]; then
        printf '{"rule_id":"%s","kind":"%s","confidence":"%s","file":"%s","line":%s,"evidence":"%s"}\n' \
          "$rule" "$kind" "$confidence" "$escaped_output_file" "$line" "$(json_escape "$evidence")"
      else
        printf '%s:%s [%s/%s] %s | %s\n' "$output_file" "$line" "$kind" "$confidence" "$rule" "$evidence"
      fi
    done <<< "$matches"
  done
done

if (( finding_count == 0 )) && [[ "$format" == text ]]; then
  printf 'No findings.\n'
fi
