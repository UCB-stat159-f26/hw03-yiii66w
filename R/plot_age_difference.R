#' @title Plot Match Age Differences
#' @description Creates a scatter plot with the player's age on the x-axis
#'   and the player-minus-opponent age difference on the y-axis.
#'   Point colors indicate wins and losses.
#' @param matches A data frame returned by `get_career_data()`.
#' @return A ggplot object.
#' @export
#' @importFrom rlang .data
#' @examples
#' matches <- data.frame(
#'   player_age = c(20, 21),
#'   age_difference = c(-2, 1),
#'   result = c("W", "L")
#' )
#' plot_age_difference(matches)
plot_age_difference <- function(matches) {
  ggplot2::ggplot(matches, ggplot2::aes(
    x = .data$player_age,
    y = .data$age_difference,
    color = .data$result
  )) +
    ggplot2::geom_hline(yintercept = 0, color = "grey50") +
    ggplot2::geom_point(size = 1.5, alpha = 0.8) +
    ggplot2::scale_color_manual(
      values = c(W = "blue", L = "purple"),
      breaks = c("W", "L"),
      labels = c("Won", "Lost")
    ) +
    ggplot2::scale_x_continuous(position = "top") +
    ggplot2::labs(
      x = "Player age", y = "Player age minus opponent age (years)",
      color = "Match result", caption = "Source: Tennis Abstract"
    ) +
    ggplot2::theme_minimal()
}
