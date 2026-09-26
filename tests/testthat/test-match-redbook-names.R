test_that("match_redbook_names conserva el orden y reconoce coincidencias", {
  submitted <- c("Sanchezia ovata", "Sanchezia capitata", "Persea americana")

  result <- match_redbook_names(submitted, parser = "legacy")

  expect_s3_class(result, "data.frame")
  expect_identical(result$name_submitted, submitted)
  expect_identical(result$input_index, seq_along(submitted))
  expect_identical(result$endemic_status, c("endemic", "endemic", "not_endemic"))
  expect_identical(result$match_status[1:2], c("exact", "exact"))
  expect_identical(result$matched_via[1], "accepted_name")
  expect_identical(result$matched_via[2], "redbook_name")
  expect_identical(result$redbook_name[1], "Sanchezia capitata")
  expect_true(is.na(result$redbook_id[3]))
})

test_that("match_redbook_names informa coincidencias aproximadas e inválidas", {
  result <- match_redbook_names(
    c("Verbesina andinaa", NA_character_, ""),
    dist = 0.2,
    parser = "legacy"
  )

  expect_identical(result$match_status[1], "fuzzy")
  expect_identical(result$endemic_status[1], "endemic")
  expect_gt(result$match_distance[1], 0)
  expect_identical(result$match_status[2:3], c("invalid_input", "invalid_input"))
  expect_identical(result$invalid_reason[2:3], c("missing_or_empty", "missing_or_empty"))
})

test_that("match_redbook_names valida argumentos y ofrece una salida resumida", {
  expect_error(
    match_redbook_names("Sanchezia ovata", dist = -1),
    "non-negative"
  )
  expect_error(
    match_redbook_names(1),
    "character vector"
  )

  summary_result <- match_redbook_names(
    "Sanchezia ovata",
    parser = "legacy",
    output = "summary"
  )

  expect_named(
    summary_result,
    c("input_index", "name_submitted", "input_valid", "redbook_id",
      "redbook_name", "accepted_name", "matched_via", "name_update_status",
      "endemic_status", "match_status", "match_distance")
  )
})
