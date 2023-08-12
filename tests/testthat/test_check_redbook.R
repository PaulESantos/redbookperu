test_that("check_redbook returns correct output for tax_status = TRUE", {
  splist <- c("Aphelandra cuscoensis",
              "Sanchezia ovata",
              "Piper stevensii",
              "Verbesina andina")
  expected_output <- c( "Aphelandra cuscoensis - Accepted name",
                        "Sanchezia ovata - Accepted name",
                        "Piper stevensii - No opinion",
                        "Verbesina andina - No info. available")

  actual_output <- check_redbook(splist, tax_status = TRUE)
  expect_equal(actual_output, expected_output)
})

test_that("check_redbook returns correct output for tax_status = FALSE", {
  splist <- c("Aphelandra cuscoenses", "Sanchezia capitata",
              "Sanchezia ovata", "Piper stevensi",
              "Verbesina andinaa", "Verbesina andina")
  expected_output <- c("Aphelandra cuscoensis is endemic - fuzzy macth",
                       "Sanchezia ovata is endemic",
                       "Sanchezia ovata is endemic",
                       "Piper stevensii is endemic - fuzzy macth",
                       "Verbesina andina is endemic - fuzzy match",
                       "Verbesina andina is endemic" )

  actual_output <- check_redbook(splist, tax_status = FALSE)

  expect_equal(actual_output, expected_output)
})
