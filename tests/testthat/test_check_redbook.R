test_that("check_redbook returns correct output for tax_status = TRUE", {
  splist <- c("Aphelandra cuscoensis",
              "Sanchezia ovata",
              "Piper stevensii",
              "Verbesina andina")
  expected_output <- c( "Aphelandra cuscoensis - Accepted name",
                        "Sanchezia ovata - Not endemic",
                        "Piper stevensii - No opinion",
                        "Verbesina andina - No info. available")

  actual_output <- check_redbook(splist, tax_status = TRUE)
  expect_equal(actual_output, expected_output)
})

test_that("check_redbook returns correct output for tax_status = FALSE", {
  splist <- c("Aphelandra cuscoenses",
              "Sanchezia capitata",
              "Sanchezia ovata",
              "Piper stevensi",
              "Verbesina andinaa",
              "Verbesina andina")
  expected_output <- c("Endemic - fuzzy match",
                       "Endemic",
                       "Not endemic",
                       "Endemic - fuzzy match",
                       "Endemic - fuzzy match",
                       "Endemic" )

  actual_output <- check_redbook(splist, tax_status = FALSE)
  actual_output
  expect_equal(actual_output, expected_output)
})
