
# Define una prueba para verificar si la base de datos redbook_taxonomy se carga correctamente
test_that("Loading redbook_taxonomy dataset", {
  # Cargar la base de datos
  data("redbook_taxonomy", package = "redbookperu")

  # Verificar si redbook_taxonomy es un objeto de la clase "data.frame"
  expect_s3_class(redbookperu::redbook_taxonomy, "data.frame")

  # Verificar si redbook_taxonomy tiene el número de filas esperado
  expect_equal(nrow(redbookperu::redbook_taxonomy), 5507)

  # Verificar si las columnas requeridas están presentes en redbook_taxonomy
  expected_columns <- c("redbook_id", "redbook_name", "accepted_name",
                        "accepted_family", "accepted_name_author", "taxonomic_status")
  expect_equal(colnames(redbookperu::redbook_taxonomy), expected_columns)
})
