function rd_html(value, result) {
  result = value
  gsub(/&/, "\\&amp;", result)
  gsub(/</, "\\&lt;", result)
  gsub(/>/, "\\&gt;", result)
  gsub(/\"/, "\\&quot;", result)
  gsub(/\047/, "\\&#39;", result)
  return result
}

function rd_load_analysis(path, kind, line, fields, record_index) {
  while ((getline line < path) > 0) {
    split(line, fields, "\t")
    if (fields[1] == "TOTAL") {
      if (kind == "original") {
        rd_total_files = fields[2]
        rd_total_additions = fields[3]
        rd_total_deletions = fields[4]
      }
      continue
    }
    record_index = fields[2]
    if (kind == "original") {
      rd_status[record_index] = fields[3]
      rd_additions[record_index] = fields[4]
      rd_deletions[record_index] = fields[5]
      rd_display[record_index] = fields[6]
      rd_old[record_index] = fields[7]
      rd_new[record_index] = fields[8]
      rd_binary[record_index] = fields[9]
      rd_generated[record_index] = fields[10]
    } else {
      rd_abr_old[record_index] = fields[7]
      rd_abr_new[record_index] = fields[8]
      rd_abr_count++
    }
  }
  close(path)
}

function rd_find_original(old_path, new_path, i) {
  for (i = 1; i <= rd_total_files; i++) {
    if (old_path == rd_old[i] && new_path == rd_new[i]) return i
    if (new_path != "/dev/null" && new_path == rd_new[i]) return i
    if (old_path != "/dev/null" && old_path == rd_old[i]) return i
  }
  return 0
}

function rd_map_abridged(i, target) {
  for (i = 1; i <= rd_abr_count; i++) {
    target = rd_find_original(rd_abr_old[i], rd_abr_new[i])
    rd_abr_target[i] = target
    if (target) rd_retained[target] = 1
  }
}

function rd_line_class(line) {
  if (line ~ /^[ +\-]?# \.\.\. [0-9]+ mechanical lines omitted \.\.\.$/) return "omission"
  if (line ~ /^Binary files / || line ~ /^GIT binary patch/) return "binary-notice"
  if (line ~ /^@@/) return "hunk"
  if (line ~ /^\+\+\+ / || line ~ /^--- /) return "diff-header"
  if (line ~ /^diff --git / || line ~ /^index / || line ~ /^(new|deleted) file mode / || line ~ /^(old|new) mode / || line ~ /^(similarity|dissimilarity) index / || line ~ /^rename (from|to) / || line ~ /^copy (from|to) /) return "diff-metadata"
  if (line ~ /^\+/) return "addition"
  if (line ~ /^-/) return "removal"
  if (line ~ /^\\ No newline/) return "note"
  return "context"
}

function rd_badge(label, class_name) {
  class_name = tolower(label)
  gsub(/ /, "-", class_name)
  return "<span class=\"risk risk-" class_name "\">" rd_html(label) "</span>"
}

function rd_file_badges(i, value) {
  value = "<span class=\"status status-" rd_status[i] "\">" rd_status[i] "</span>"
  if (rd_generated[i]) value = value "<span class=\"indicator generated\">generated</span>"
  if (rd_binary[i]) value = value "<span class=\"indicator binary\">binary</span>"
  if (!rd_retained[i]) value = value "<span class=\"indicator mechanical\">all mechanical</span>"
  return value
}

BEGIN {
  if (mode != "summary") rd_load_analysis(analysis, "original")
  if (mode == "summary") {
    rd_load_analysis(analysis, "original")
    rd_load_analysis(abridged_analysis, "abridged")
  }
  if (mode == "navigation" || mode == "abridged") {
    rd_load_analysis(abridged_analysis, "abridged")
    rd_map_abridged()
  }
}

mode == "summary" {
  if ($0 ~ /^Source: /) { rd_source = substr($0, 9); rd_source_seen++; next }
  if ($0 ~ /^Sentence: /) { rd_sentence = substr($0, 11); rd_sentence_seen++; next }
  if ($0 ~ /^Important count: [0-9]+$/) { rd_important = substr($0, 18); rd_count_seen++; next }
  if ($0 == "Risks: None") { rd_risks_seen++; rd_no_risks = 1; next }
  if ($0 == "Risks:") { rd_risks_seen++; rd_in_risks = 1; next }
  if (rd_in_risks && $0 ~ /^- /) {
    rd_risk = substr($0, 3)
    if (rd_risk !~ /^(Behavior|API contract|Data|Security|Dependency|Configuration|Migration|Destructive)$/) rd_invalid = 1
    else rd_risks[++rd_risk_count] = rd_risk
    next
  }
  if ($0 != "") rd_invalid = 1
  next
}

mode == "navigation" { next }

mode == "abridged" {
  if ($0 ~ /^diff --git /) {
    rd_abr_position++
    rd_current = rd_abr_target[rd_abr_position]
    if (!rd_current) rd_unmatched = 1
    rd_git_section = 1
    rd_seen_hunk = 0
  } else if ($0 ~ /^--- / && !rd_git_section && (!rd_abr_position || rd_seen_hunk)) {
    rd_abr_position++
    rd_current = rd_abr_target[rd_abr_position]
    if (!rd_current) rd_unmatched = 1
    rd_seen_hunk = 0
  }
  if ($0 ~ /^@@/) rd_seen_hunk = 1
  if (rd_current) rd_body[rd_current] = rd_body[rd_current] "<span class=\"line " rd_line_class($0) "\">" rd_html($0) "</span>\n"
  next
}

mode == "original" {
  rd_original_body = rd_original_body "<span class=\"line " rd_line_class($0) "\">" rd_html($0) "</span>\n"
  next
}

END {
  if (mode == "summary") {
    if (rd_invalid || rd_source_seen != 1 || rd_sentence_seen != 1 || rd_count_seen != 1 || rd_risks_seen != 1 || (!rd_no_risks && rd_risk_count < 1) || (rd_important + 0) != (rd_abr_count + 0) || (rd_important + 0) > (rd_total_files + 0)) exit 3
    print "<header class=\"report-header\"><button id=\"menu-toggle\" aria-controls=\"sidebar\" aria-expanded=\"false\">Files</button><h1>Reading Diff</h1><p class=\"sentence\">" rd_html(rd_sentence) "</p><p class=\"source\">" rd_html(rd_source) "</p><button id=\"diff-toggle\" aria-controls=\"abridged-diff original-diff\" aria-pressed=\"false\">Full diff</button>"
    print "<dl class=\"metrics\"><div><dt>Changed files</dt><dd>" rd_total_files "</dd></div><div><dt>Additions</dt><dd>+" rd_total_additions "</dd></div><div><dt>Removals</dt><dd>−" rd_total_deletions "</dd></div><div><dt>Important files</dt><dd>" rd_important "</dd></div></dl><div class=\"risks\" aria-label=\"Risk categories\">"
    if (rd_no_risks) print "<span class=\"no-risk\">No supported risks</span>"
    else for (rd_i = 1; rd_i <= rd_risk_count; rd_i++) print rd_badge(rd_risks[rd_i])
    print "</div></header>"
  }
  if (mode == "navigation") {
    for (rd_i = 1; rd_i <= rd_total_files; rd_i++) print "<li data-file-index=\"" rd_i "\"><a href=\"#file-" rd_i "\">" rd_html(rd_display[rd_i]) "<span class=\"nav-meta\">+" rd_additions[rd_i] " −" rd_deletions[rd_i] "</span>" rd_file_badges(rd_i) "</a></li>"
  }
  if (mode == "abridged") {
    if (rd_unmatched) exit 4
    print "<section class=\"abridged-files\" id=\"abridged-diff\"><h2>Changes</h2>"
    for (rd_i = 1; rd_i <= rd_total_files; rd_i++) {
      print "<section class=\"file\" id=\"file-" rd_i "\" data-file-index=\"" rd_i "\"><header><h3>" rd_html(rd_display[rd_i]) "</h3><span class=\"counts\">+" rd_additions[rd_i] " −" rd_deletions[rd_i] "</span>" rd_file_badges(rd_i) "</header>"
      if (rd_retained[rd_i]) print "<pre>" rd_body[rd_i] "</pre>"
      else print "<p class=\"all-mechanical\">All changes classified as mechanical.</p>"
      print "</section>"
    }
    print "</section>"
  }
  if (mode == "original") {
    print "<section class=\"complete-original\"><div class=\"original-heading\"><h2>Complete original diff</h2><button id=\"original-toggle\" aria-controls=\"original-diff\" aria-expanded=\"false\">Expand original diff</button></div><details id=\"original-diff\"><summary>Complete source patch</summary><pre>" rd_original_body "</pre></details></section>"
  }
}
