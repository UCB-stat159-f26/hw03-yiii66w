get_opponent_age <- function(value, match_date) {
  value <- trimws(as.character(value))
  is_birth_date <- grepl("^[0-9]{8}$", value)
  age <- suppressWarnings(as.numeric(value))
  birth_date <- as.Date(value[is_birth_date], format = "%Y%m%d")
  age[is_birth_date] <- as.numeric(match_date[is_birth_date] - birth_date) / 365.25
  age
}

clean_career_matches <- function(matches, player_birth_date) {
  match_date <- as.Date(matches$match_date, format = "%Y%m%d")
  player_age <- as.numeric(match_date - as.Date(player_birth_date)) / 365.25
  opponent_age <- get_opponent_age(matches$opponent_age_or_birth, match_date)
  data.frame(
    player_age = player_age,
    age_difference = player_age - opponent_age,
    result = matches$result
  )
}
