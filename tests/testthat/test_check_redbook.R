test_that("check_redbook returns correct output for tax_status = TRUE", {
  splist <- c("Aphelandra cuscoenses",
              "Piper stevensi",
              "Sanchezia ovata",
              "Verbesina andina",
              "Festuca dentiflora",
              "Eucrosia bicolor var. plowmanii",
              "Hydrocotyle bonplandii var. hirtipes",
              "Persea americana")
  expected_output <- c("endemic", "endemic", "not endemic",
                       "endemic", "endemic",
                       "endemic", "endemic", "not endemic")

  actual_output <- check_redbooklist(splist, dist = 0.2)
  expect_equal(actual_output, expected_output)
})

