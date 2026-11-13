test_that("women's match records use the opponent's birth date", {
  js <- 'var morematchmx = [
    ["19951030","Canadian Open","Carpet","W","L","","","WC","Q1","6-1 6-1","3","Anne Miller","149","7","","R","19770119"]
  ]'
  parsed <- parse_career_matches(js)
  matches <- clean_career_matches(parsed, "1981-09-26")

  expect_equal(parsed$match_date, "19951030")
  expect_equal(parsed$opponent_age_or_birth, "19770119")
  expect_equal(matches$age_difference, -4.684463, tolerance = 0.00001)
  expect_equal(matches$result, "L")
})

test_that("men's match records provide the opponent's age", {
  js <- 'var morematchmx = [
    ["20010910","Spain F10","Hard","S","L","","","WC","R32","2-6 7-5 6-2","3","Guillermo Platel","731","","","R","22.264202601"]
  ]'
  parsed <- parse_career_matches(js)
  matches <- clean_career_matches(parsed, "1986-06-03")

  expect_equal(parsed$match_date, "20010910")
  expect_equal(parsed$opponent_age_or_birth, "22.264202601")
  expect_equal(matches$age_difference, -6.992471, tolerance = 0.00001)
  expect_equal(matches$result, "L")
})
