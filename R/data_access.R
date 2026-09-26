.redbook_taxonomy_data <- function() {
  parquet <- system.file("extdata", "redbook_taxonomy.parquet",
                         package = "redbookperu")
  if (nzchar(parquet) && requireNamespace("arrow", quietly = TRUE)) {
    return(as.data.frame(arrow::read_parquet(parquet),
                         stringsAsFactors = FALSE))
  }

  as.data.frame(redbookperu::redbook_tab, stringsAsFactors = FALSE)
}
