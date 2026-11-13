make_player_ids <- function(player) {
  if (!is.character(player) || length(player) != 1L || is.na(player)) {
    stop("Enter one player's full name.", call. = FALSE)
  }
  name <- iconv(player, to = "ASCII//TRANSLIT", sub = "")
  words <- strsplit(trimws(name), "[^A-Za-z0-9]+")[[1]]
  words <- words[nzchar(words)]
  if (!length(words)) stop("Enter one player's full name.", call. = FALSE)
  capitalized <- sub("^([a-z])", "\\U\\1", words, perl = TRUE)
  unique(c(paste0(capitalized, collapse = ""), paste0(words, collapse = "")))
}

read_tennis_page <- function(address) {
  tryCatch(
    suppressWarnings(readLines(address, warn = FALSE, encoding = "UTF-8")),
    error = function(error) character()
  )
}

find_player_career <- function(player, site) {
  for (id in make_player_ids(player)) {
    address <- paste0(site, "/jsmatches/", id, "Career.js")
    js <- read_tennis_page(address)
    if (any(grepl("\\bvar\\s+morematchmx\\s*=", js, perl = TRUE))) {
      return(list(id = id, js = js))
    }
  }
  stop("Could not find career data for '", player,
       "'. Check the name and your connection to Tennis Abstract.", call. = FALSE)
}

get_player_birth_date <- function(id, site) {
  pattern <- "\\bvar\\s+dob\\s*=\\s*[0-9]{8}\\s*;"
  for (page in c("player.cgi", "wplayer.cgi")) {
    address <- paste0(site, "/cgi-bin/", page, "?p=", id)
    html <- paste(read_tennis_page(address), collapse = "\n")
    field <- regmatches(html, regexpr(pattern, html, perl = TRUE))
    birth_date <- as.Date(gsub("[^0-9]", "", field), format = "%Y%m%d")
    if (length(birth_date) && !is.na(birth_date)) return(birth_date)
  }
  stop("Could not read the birth date for ", id, ".", call. = FALSE)
}

get_career_data <- function(player) {
  site <- "https://www.tennisabstract.com"
  career <- find_player_career(player, site)
  birth_date <- get_player_birth_date(career$id, site)
  matches <- parse_career_matches(career$js)
  clean_career_matches(matches, birth_date)
}
