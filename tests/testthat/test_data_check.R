
# Define una prueba para verificar si la base de datos redbook_taxonomy se carga correctamente
test_that("Loading redbook_taxonomy dataset", {
  # Cargar la base de datos
  data("redbook_tab", package = "redbookperu")

  # Verificar si redbook_taxonomy es un objeto de la clase "data.frame"
  expect_s3_class(redbookperu::redbook_tab, "tbl_df")

  # Verificar si redbook_taxonomy tiene el número de filas esperado
  expect_equal(nrow(redbookperu::redbook_tab), 5507)

  # Verificar si las columnas requeridas están presentes en redbook_taxonomy
  expected_columns <- c("redbook_id",                "redbook_name",
                        "input_genus",                "input_epitheton",
                        "rank",                       "input_subspecies_epitheton",
                        "accepted_name",              "accepted_family",
                        "accepted_name_author",       "accepted_name_rank",
                         "tag_subsp_wcvp",             "genus_ephitethon_wcvp",
                         "species_ephitethon_wcvp",    "subspecies_ephitethon_wcvp")
  expect_equal(colnames(redbookperu::redbook_tab), expected_columns)
})
