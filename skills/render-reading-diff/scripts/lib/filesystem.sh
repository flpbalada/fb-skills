rd_initialize_paths() {
  local rd_entry_dir=$1
  rd_skill_dir=$(CDPATH= cd -- "$rd_entry_dir/.." && pwd)
  rd_css_file=$rd_skill_dir/assets/report.css
  rd_js_file=$rd_skill_dir/assets/report.js
  rd_analyze_awk=$rd_entry_dir/awk/analyze-diff.awk
  rd_render_awk=$rd_entry_dir/awk/render-diff.awk
}

rd_require_readable_file() {
  local rd_label=$1
  local rd_path=$2
  [[ -f $rd_path && -r $rd_path ]] || {
    printf 'Error: %s is not a readable file: %s\n' "$rd_label" "$rd_path" >&2
    return 1
  }
}

rd_canonical_path() {
  local rd_path=$1
  local rd_dir
  rd_dir=$(CDPATH= cd -- "$(dirname -- "$rd_path")" && pwd -P)
  printf '%s/%s\n' "$rd_dir" "$(basename -- "$rd_path")"
}

rd_validate_files() {
  rd_require_readable_file original "$rd_original_file"
  rd_require_readable_file abridged "$rd_abridged_file"
  rd_require_readable_file summary "$rd_summary_file"
  rd_require_readable_file stylesheet "$rd_css_file"
  rd_require_readable_file script "$rd_js_file"
  rd_require_readable_file analyzer "$rd_analyze_awk"
  rd_require_readable_file renderer "$rd_render_awk"

  [[ -s $rd_original_file ]] || {
    printf 'No changes found\n' >&2
    return 3
  }

  rd_output_dir=$(dirname -- "$rd_output_file")
  [[ -d $rd_output_dir && -w $rd_output_dir ]] || {
    printf 'Error: output directory is not writable: %s\n' "$rd_output_dir" >&2
    return 1
  }

  local rd_output_canonical
  local rd_input
  rd_output_canonical=$(rd_canonical_path "$rd_output_file")
  for rd_input in "$rd_original_file" "$rd_abridged_file" "$rd_summary_file"; do
    [[ $rd_output_canonical != "$(rd_canonical_path "$rd_input")" ]] || {
      printf 'Error: output must differ from every input\n' >&2
      return 1
    }
    [[ ! -e $rd_output_file || ! $rd_output_file -ef $rd_input ]] || {
      printf 'Error: output must differ from every input\n' >&2
      return 1
    }
  done
  rd_output_file=$rd_output_canonical
}

rd_prepare_workspace() {
  umask 077
  rd_workspace=$(mktemp -d "${TMPDIR:-/tmp}/render-reading-diff.XXXXXX")
  rd_analysis_file=$rd_workspace/original.tsv
  rd_abridged_analysis_file=$rd_workspace/abridged.tsv
  rd_workspace_report=$rd_workspace/report.html
  rd_output_temp=
  trap rd_cleanup_workspace EXIT
}

rd_cleanup_workspace() {
  [[ -z ${rd_output_temp:-} || ! -e $rd_output_temp ]] || rm -f -- "$rd_output_temp"
  [[ -z ${rd_workspace:-} || ! -d $rd_workspace ]] || rm -rf -- "$rd_workspace"
}

rd_publish_report() {
  rd_output_temp=$(mktemp "$rd_output_dir/.render-reading-diff.XXXXXX")
  cp -- "$rd_workspace_report" "$rd_output_temp"
  mv -- "$rd_output_temp" "$rd_output_file"
  rd_output_temp=
}
