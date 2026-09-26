test_that("check_redbooklist mantiene la interfaz de estados", {
  result <- check_redbooklist(
    c("Aphelandra cuscoenses", "Sanchezia ovata", "Persea americana"),
    dist = 0.2,
    quiet = TRUE
  )

  expect_type(result, "character")
  expect_identical(result, c("endemic", "endemic", "not endemic"))
})

test_that("check_redbooklist devuelve diagnósticos detallados cuando se solicitan", {
  result <- check_redbooklist(
    "Sanchezia ovata",
    output = "detailed",
    quiet = TRUE
  )

  expect_s3_class(result, "data.frame")
  expect_identical(result$endemic_status, "endemic")
  expect_identical(result$redbook_name, "Sanchezia capitata")
})
