#' Get Red Book Data for Given Species List
#'
#' This function retrieves comprehensive information from the Red Book of Endemic Plants
#' of Peru database for a provided list of species. It associates the provided
#' species names with their corresponding updated taxonomic information and
#' descriptions recorded in the original publication.
#'
#' @param splist A character vector containing the species names to be queried.
#' @param dist Maximum allowed distance for fuzzy matching of species names.
#' @param unmatched How unmatched or invalid rows are represented. `"NA"` uses
#'   missing values; `"placeholder"` uses the historical `"---"` placeholder.
#' @param quiet If `TRUE`, suppresses summary messages.
#'
#' @return A data frame containing comprehensive information about the provided
#' species, including updated taxonomic details and descriptions.
#'
#' @details
#' This function checks each species name in the provided list against the
#' Red Book of Endemic Plants of Peru database using fuzzy matching based on
#' the specified maximum distance (`dist`). For each species, it retrieves and
#' combines taxonomic information (accepted name, accepted family, accepted name author)
#' with additional descriptive data recorded in the original publication, such as
#' IUCN conservation category, bibliographic reference, collector, herbariums,
#' common name, departmental registrations, ecological regions, protected natural
#' areas (SINANPE), Peruvian herbaria, and additional remarks.
#'
#' @seealso \code{\link{check_redbooklist}} function for a more focused check of species endemic status.
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#' [The World Checklist of Vascular Plants, a continuously updated resource for exploring global plant diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
#' [Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
#' [Plants of the World Online - Facilitated by the Royal Botanic Gardens - Kew.](http://www.plantsoftheworldonline.org/)
#'
#' @examples
#' # Example illustrating how to use the get_redbook_data function
#' species_list <- c("Aphelandra cuscoensis", "Sanchezia ovata", "Piper stevensii")
#' redbook_data <- get_redbook_data(species_list)
#' head(redbook_data)
#'
#' @name get_redbook_data
#' @export
get_redbook_data <- function(splist,
                             dist = 0.1,
                             unmatched = c("NA", "placeholder"),
                             quiet = FALSE) {
  unmatched <- match.arg(unmatched)

  matching <- match_redbook_names(splist = splist,
                                  dist = dist,
                                  parser = "wcvpmatch",
                                  output = "detailed")

  book_data <- as.data.frame(redbookperu::redbook_sp_data,
                             stringsAsFactors = FALSE)
  book_data <- book_data[, c("redbook_id",
                             "iucn",
                             "publication",
                             "collector",
                             "herbariums",
                             "common_name",
                             "dep_registry",
                             "ecological_regions",
                             "sinampe",
                             "peruvian_herbariums",
                             "remarks")]

  output <- merge(matching[, c("input_index",
                               "name_submitted",
                               "accepted_name",
                               "accepted_name_author",
                               "accepted_family",
                               "redbook_id",
                               "redbook_name")],
                  book_data,
                  by = "redbook_id",
                  all.x = TRUE,
                  sort = FALSE)
  output <- output[order(output$input_index), , drop = FALSE]

  output$name_subitted <- output$name_submitted
  output <- output[, c("name_submitted",
                       "name_subitted",
                       "accepted_name",
                       "accepted_name_author",
                       "accepted_family",
                       "redbook_name",
                       "iucn",
                       "publication",
                       "collector",
                       "herbariums",
                       "common_name",
                       "dep_registry",
                       "ecological_regions",
                       "sinampe",
                       "peruvian_herbariums",
                       "remarks"), drop = FALSE]

  if (identical(unmatched, "placeholder")) {
    data_cols <- setdiff(names(output), c("name_submitted", "name_subitted"))
    output[data_cols] <- lapply(output[data_cols], function(x) {
      x[is.na(x)] <- "---"
      x
    })
  }

  if (!isTRUE(quiet)) {
    message(paste("Total exact matches:",
                  sum(matching$match_status == "exact", na.rm = TRUE)))
    message(paste("Total fuzzy matches:",
                  sum(matching$match_status %in% c("fuzzy", "ambiguous"),
                      na.rm = TRUE)))
  }

  row.names(output) <- NULL
  output
}
