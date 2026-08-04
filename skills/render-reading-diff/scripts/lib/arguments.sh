rd_usage() {
  cat >&2 <<'EOF'
Usage: render-diff.sh --original FILE --abridged FILE --summary FILE --output FILE
EOF
}

rd_argument_error() {
  printf 'Error: %s\n' "$1" >&2
  rd_usage
  return 2
}

rd_parse_arguments() {
  rd_original_file=
  rd_abridged_file=
  rd_summary_file=
  rd_output_file=

  while [[ $# -gt 0 ]]; do
    case $1 in
      --original|--abridged|--summary|--output)
        [[ $# -ge 2 && -n $2 ]] || rd_argument_error "$1 requires a value"
        case $1 in
          --original) rd_original_file=$2 ;;
          --abridged) rd_abridged_file=$2 ;;
          --summary) rd_summary_file=$2 ;;
          --output) rd_output_file=$2 ;;
        esac
        shift 2
        ;;
      --original=*|--abridged=*|--summary=*|--output=*)
        local rd_name=${1%%=*}
        local rd_value=${1#*=}
        [[ -n $rd_value ]] || rd_argument_error "$rd_name requires a value"
        case $rd_name in
          --original) rd_original_file=$rd_value ;;
          --abridged) rd_abridged_file=$rd_value ;;
          --summary) rd_summary_file=$rd_value ;;
          --output) rd_output_file=$rd_value ;;
        esac
        shift
        ;;
      -h|--help) rd_usage; exit 0 ;;
      *) rd_argument_error "unknown argument: $1" ;;
    esac
  done

  [[ -n $rd_original_file ]] || rd_argument_error '--original is required'
  [[ -n $rd_abridged_file ]] || rd_argument_error '--abridged is required'
  [[ -n $rd_summary_file ]] || rd_argument_error '--summary is required'
  [[ -n $rd_output_file ]] || rd_argument_error '--output is required'
}
