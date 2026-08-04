function rd_is_octal(char) {
  return char ~ /^[0-7]$/
}

function rd_safe_field(value) {
  gsub(/\t/, "\\t", value)
  gsub(/\r/, "\\r", value)
  return value
}

function rd_strip_side(path) {
  if (path ~ /^[ab]\//) return substr(path, 3)
  return path
}

function rd_parse_quoted(text, start, out, i, char, next_char, two, three, decimal) {
  out = ""
  for (i = start + 1; i <= length(text); i++) {
    char = substr(text, i, 1)
    if (char == "\"") {
      rd_parsed_end = i + 1
      return out
    }
    if (char != "\\") {
      out = out char
      continue
    }
    next_char = substr(text, ++i, 1)
    two = substr(text, i + 1, 1)
    three = substr(text, i + 2, 1)
    if (rd_is_octal(next_char) && rd_is_octal(two) && rd_is_octal(three)) {
      decimal = (next_char * 64) + (two * 8) + three
      out = out sprintf("%c", decimal)
      i += 2
    } else if (next_char == "\"" || next_char == "\\") out = out next_char
    else if (next_char == "t") out = out "\\t"
    else if (next_char == "n") out = out "\\n"
    else if (next_char == "r") out = out "\\r"
    else out = out "\\" next_char
  }
  rd_parsed_end = i
  return out
}

function rd_header_path(text, value) {
  value = text
  sub(/^[[:space:]]+/, "", value)
  if (substr(value, 1, 1) == "\"") return rd_parse_quoted(value, 1)
  sub(/\t.*$/, "", value)
  return value
}

function rd_git_paths(line, text, position, found, rest) {
  text = substr(line, 12)
  if (substr(text, 1, 1) == "\"") {
    rd_old_path = rd_parse_quoted(text, 1)
    rest = substr(text, rd_parsed_end)
    sub(/^[[:space:]]+/, "", rest)
    rd_new_path = substr(rest, 1, 1) == "\"" ? rd_parse_quoted(rest, 1) : rest
    return
  }
  position = 0
  rest = text
  while ((found = index(rest, " b/")) > 0) {
    position += found
    rest = substr(rest, found + 1)
  }
  if (position > 0) {
    rd_old_path = substr(text, 1, position - 1)
    rd_new_path = substr(text, position + 1)
    return
  }
  split(text, rd_parts, /[[:space:]]+/)
  rd_old_path = rd_parts[1]
  rd_new_path = rd_parts[2]
}

function rd_is_generated(path, lowered) {
  lowered = tolower(path)
  return lowered ~ /(^|\/)(dist|build|generated|vendor|coverage)\// || lowered ~ /(^|\/)(package-lock\.json|pnpm-lock\.yaml|yarn\.lock)$/ || lowered ~ /\.min\.(js|css)$/
}

function rd_start_file(line) {
  if (rd_active) rd_finish_file()
  rd_git_paths(line)
  rd_old_path = rd_strip_side(rd_old_path)
  rd_new_path = rd_strip_side(rd_new_path)
  rd_additions = rd_deletions = rd_binary = rd_renamed = rd_added = rd_deleted = 0
  rd_plain = rd_seen_hunk = 0
  rd_active = 1
}

function rd_start_plain(path) {
  if (rd_active) rd_finish_file()
  rd_old_path = rd_strip_side(path)
  rd_new_path = ""
  rd_additions = rd_deletions = rd_binary = rd_renamed = rd_added = rd_deleted = 0
  rd_plain = 1
  rd_seen_hunk = 0
  rd_active = 1
}

function rd_finish_file(status, display, generated) {
  if (!rd_active) return
  if (rd_binary) status = "binary"
  else if (rd_added || rd_old_path == "/dev/null") status = "added"
  else if (rd_deleted || rd_new_path == "/dev/null") status = "deleted"
  else if (rd_renamed || rd_old_path != rd_new_path) status = "renamed"
  else status = "modified"

  if (status == "renamed") display = rd_old_path " → " rd_new_path
  else if (status == "deleted") display = rd_old_path
  else display = rd_new_path
  generated = rd_is_generated(display) ? 1 : 0

  rd_order++
  rd_total_additions += rd_additions
  rd_total_deletions += rd_deletions
  printf "FILE\t%d\t%s\t%d\t%d\t%s\t%s\t%s\t%d\t%d\n", rd_order, status, rd_additions, rd_deletions, rd_safe_field(display), rd_safe_field(rd_old_path), rd_safe_field(rd_new_path), rd_binary, generated
  rd_active = 0
}

/^diff --git / { rd_start_file($0); next }
!rd_active && /^--- / { rd_start_plain(rd_header_path(substr($0, 5))); next }
!rd_active { next }
/^--- / {
  if (rd_plain && rd_seen_hunk) rd_start_plain(rd_header_path(substr($0, 5)))
  else rd_old_path = rd_strip_side(rd_header_path(substr($0, 5)))
  next
}
/^\+\+\+ / { rd_new_path = rd_strip_side(rd_header_path(substr($0, 5))); next }
/^@@/ { rd_seen_hunk = 1; next }
/^new file mode / { rd_added = 1; next }
/^deleted file mode / { rd_deleted = 1; next }
/^rename from / { rd_old_path = rd_header_path(substr($0, 13)); rd_renamed = 1; next }
/^rename to / { rd_new_path = rd_header_path(substr($0, 11)); rd_renamed = 1; next }
/^Binary files / || /^GIT binary patch/ { rd_binary = 1; next }
/^\+/ { rd_additions++; next }
/^-/ { rd_deletions++; next }

END {
  rd_finish_file()
  printf "TOTAL\t%d\t%d\t%d\n", rd_order, rd_total_additions, rd_total_deletions
}
