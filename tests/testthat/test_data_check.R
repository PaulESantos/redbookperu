#' Unit tests for redbookperu package
#'
#' @format A list of testthat tests
test_that("Test read_data() function", {
  # Load the data using the read_data() function
  data <- redbookperu::redbook_distribution

  # Check that the data is loaded as a data frame or tibble
  expect_true(is.data.frame(data) || is.tbl(data))

  # Check that the data contains the expected columns
  expected_cols <- c("possible_names", "taxon_name", "accepted_name",
                     "accepted_name_author", "accepted_family",
                     "taxonomic_status", "level2_code")
  expect_identical(colnames(data), expected_cols)

  # Check that the data has the expected number of rows
  expected_rows <- 10957
  expect_equal(nrow(data), expected_rows)
})
