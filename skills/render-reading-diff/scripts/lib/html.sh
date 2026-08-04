rd_write_html_start() {
  cat > "$rd_workspace_report" <<'EOF'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Reading Diff</title>
<style>
EOF
  cat "$rd_css_file" >> "$rd_workspace_report"
  cat >> "$rd_workspace_report" <<'EOF'
</style>
</head>
<body>
EOF
}

rd_write_html_end() {
  cat >> "$rd_workspace_report" <<'EOF'
<script>
EOF
  cat "$rd_js_file" >> "$rd_workspace_report"
  cat >> "$rd_workspace_report" <<'EOF'
</script>
</body>
</html>
EOF
}
