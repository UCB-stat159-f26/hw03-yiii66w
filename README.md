# tenniscareer

`tenniscareer` is an R package that gets career match data from Tennis Abstract and plots the age difference between a player and their opponents. Each point represents one match, and its color shows whether the player won or lost.

## Installation

Run this in R to install the package from GitHub:

```r
devtools::install_github("UCB-stat159-f26/hw03-yiii66w")
```

## Example

```r
library(tenniscareer)

matches <- get_career_data("Serena Williams")
head(matches)
plot_age_difference(matches)
```

`get_career_data()` returns three columns: `player_age`, `age_difference`, and `result`. The age difference is the player’s age minus the opponent’s age, in years. The result is `"W"` for a win or `"L"` for a loss.

## Reflection

In HW2, my goal was to recreate a specific plot using Serena Williams’s match data. Since I already knew whose data I was working with, I could use Serena’s birth date directly and write my code around the structure of her file. In HW3, I had to think about what would happen when someone entered a different player’s name. The package needed to find that player’s records, calculate the ages, and return a data frame that the same plotting function could use. I also had to think about what message someone should see if the package could not find their player. That made me pay more attention to the assumptions I had made in HW2, because some of those assumptions only worked for Serena. The biggest example was how Tennis Abstract stores information about opponents. In Serena’s file, the relevant field contains the opponent’s birth date. In Nadal’s file, that field already contains the opponent’s age. If I treated both values as ages, I could still end up with a numeric column and even produce a plot, but some of the points would be completely wrong. I learned to look at what a field actually represents before using it in a calculation. I also had to be consistent about the direction of the age difference. Since I used the player’s age minus the opponent’s age, a negative value means the player was younger than their opponent. Checking the sign on a match I could reason through by hand gave me more confidence in the plot than just looking at whether it appeared on the screen. I also learned what I can check with different kinds of tests. I manually ran the data function for Serena and Nadal to see whether it could retrieve real match records from Tennis Abstract. I also tried a name that would fail so I could see what the error message looked like. For the automated tests, I used small local JS examples and checked the match date, opponent information, calculated age difference, and result. Using only a few values made it easier to tell exactly which part of the code was wrong if a test failed. It also meant I could rerun the tests even if the website was unavailable. A successful download tells me the package can reach the source, while the offline tests give me a way to check whether I handled the data correctly. Before HW3, I was used to running R scripts in a particular order and knowing which objects I had already created. Building a package made me think about how someone would use my code in a fresh R session. I learned why `DESCRIPTION` lists the packages my code depends on and how `@export` makes the two main functions available to users. Writing the help pages also made me explain exactly what each function takes and returns. For example, the plotting function expects the cleaned data frame, so its help page needs to tell the user where that data frame comes from. Running `devtools::check()` helped me see the whole process from the user’s side because it checked whether the package could be installed and loaded, and whether its examples and tests ran. If I did this assignment again, I would compare the raw files for a few different players before writing the cleaning code. Starting with Serena made sense because I already knew her data from HW2, but looking at Nadal’s file earlier would have helped me recognize which parts of my original code were specific to Serena. I would also write a small test as soon as I found a difference between the files, so I could check that both formats still worked as I made changes.

## AI Use

I used ChatGPT (6.1) to review the lecture slides, draft steps of homework3, and understand concepts like Roxygen and `NAMESPACE`. My main prompts were to walk me through the lecture slides, help fix bugs and offline tests, and explain the documentation tags.