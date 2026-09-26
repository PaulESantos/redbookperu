test_that("los datos distribuidos contienen los campos necesarios para las consultas", {
  expect_s3_class(redbook_tab, "data.frame")
  expect_s3_class(redbook_sp_data, "data.frame")
  expect_gt(nrow(redbook_tab), 0)
  expect_gt(nrow(redbook_sp_data), 0)
  expect_true(all(c("redbook_id", "redbook_name", "accepted_name") %in% names(redbook_tab)))
  expect_true(all(c("redbook_id", "iucn", "remarks") %in% names(redbook_sp_data)))
  expect_identical(anyDuplicated(redbook_tab$redbook_id), 0L)
})
