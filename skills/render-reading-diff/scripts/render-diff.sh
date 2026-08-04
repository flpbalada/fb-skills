#!/usr/bin/env bash
set -euo pipefail

rd_script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# shellcheck source=lib/arguments.sh
source "$rd_script_dir/lib/arguments.sh"
# shellcheck source=lib/filesystem.sh
source "$rd_script_dir/lib/filesystem.sh"
# shellcheck source=lib/html.sh
source "$rd_script_dir/lib/html.sh"
# shellcheck source=lib/report.sh
source "$rd_script_dir/lib/report.sh"

rd_main() {
  rd_parse_arguments "$@"
  rd_initialize_paths "$rd_script_dir"
  rd_validate_files
  rd_prepare_workspace
  rd_build_report
  rd_publish_report
  printf '%s\n' "$rd_output_file"
}

rd_main "$@"
