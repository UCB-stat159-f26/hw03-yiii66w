extract_match_rows <- function(js, field_pattern) {
  js <- paste(js, collapse = "\n")
  start <- regexpr("\\bvar\\s+morematchmx\\s*=\\s*\\[", js, perl = TRUE)
  if (start == -1L) stop("The career file is missing morematchmx.", call. = FALSE)
  content <- substring(js, start + attr(start, "match.length"))
  row_pattern <- paste0("\\[\\s*", field_pattern, "(?:\\s*,\\s*", field_pattern, ")*\\s*\\]")
  last_row <- regexpr(paste0(row_pattern, "\\s*\\]"), content, perl = TRUE)
  if (last_row == -1L) stop("No match records found in the career file.", call. = FALSE)
  content <- substr(content, 1L, last_row + attr(last_row, "match.length") - 1L)
  regmatches(content, gregexpr(row_pattern, content, perl = TRUE))[[1]]
}

extract_match_fields <- function(row, field_pattern) {
  fields <- regmatches(row, gregexpr(field_pattern, row, perl = TRUE))[[1]]
  fields <- fields[c(1L, 5L, 17L)]
  substr(fields, 2L, nchar(fields) - 1L)
}

parse_career_matches <- function(js) {
  field_pattern <- r"("(?:[^"\\]|\\.)*")"
  rows <- extract_match_rows(js, field_pattern)
  fields <- t(vapply(rows, extract_match_fields, character(3), field_pattern))
  data.frame(
    match_date = fields[, 1L],
    result = fields[, 2L],
    opponent_age_or_birth = fields[, 3L]
  )
}
