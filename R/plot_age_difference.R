plot_age_difference <- function(matches) {
  ggplot2::ggplot(
    matches,
    ggplot2::aes(x = player_age, y = age_difference, color = result)
  ) +
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
