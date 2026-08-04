rd_run_renderer() {
  local rd_mode=$1
  local rd_input=$2

  awk \
    -v mode="$rd_mode" \
    -v analysis="$rd_analysis_file" \
    -v abridged_analysis="$rd_abridged_analysis_file" \
    -f "$rd_render_awk" \
    "$rd_input" >> "$rd_workspace_report"
}

rd_build_report() {
  awk -f "$rd_analyze_awk" "$rd_original_file" > "$rd_analysis_file"
  awk -f "$rd_analyze_awk" "$rd_abridged_file" > "$rd_abridged_analysis_file"

  rd_write_html_start
  if ! rd_run_renderer summary "$rd_summary_file"; then
    printf 'Error: invalid summary format\n' >&2
    return 1
  fi

  printf '%s\n' '<div class="layout">' '<aside id="sidebar"><label for="file-filter">Filter changed files</label><input id="file-filter" type="search" autocomplete="off"><nav aria-label="Changed files"><ol id="file-nav">' >> "$rd_workspace_report"
  rd_run_renderer navigation "$rd_analysis_file"
  printf '%s\n' '</ol></nav></aside><main id="report">' >> "$rd_workspace_report"
  rd_run_renderer abridged "$rd_abridged_file"
  rd_run_renderer original "$rd_original_file"
  printf '%s\n' '</main></div>' >> "$rd_workspace_report"
  rd_write_html_end
}
