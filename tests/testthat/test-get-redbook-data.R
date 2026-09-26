test_that("get_redbook_data devuelve campos del catálogo y conserva los no encontrados", {
  result <- get_redbook_data(
    c("Sanchezia ovata", "Persea americana"),
    quiet = TRUE
  )

  expect_s3_class(result, "data.frame")
  expect_identical(result$name_submitted, c("Sanchezia ovata", "Persea americana"))
  expect_named(
    result,
    c("name_submitted", "name_subitted", "accepted_name",
      "accepted_name_author", "accepted_family", "redbook_name", "iucn",
      "publication", "collector", "herbariums", "common_name", "dep_registry",
      "ecological_regions", "sinampe", "peruvian_herbariums", "remarks")
  )
  expect_identical(result$redbook_name[1], "Sanchezia capitata")
  expect_true(is.na(result$redbook_name[2]))
})

test_that("get_redbook_data puede representar ausencias con marcadores", {
  result <- get_redbook_data("Persea americana", unmatched = "placeholder", quiet = TRUE)

  expect_identical(result$name_submitted, "Persea americana")
  expect_identical(result$redbook_name, "---")
  expect_identical(result$iucn, "---")
})
