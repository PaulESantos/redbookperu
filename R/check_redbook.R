#' Check Species Names in the Red Book of Endemic Plants of Peru
#'
#' This function checks a list of species names against the Red Book of Endemic Plants
#' of Peru database and provides information about whether a species was recorded as endemic,
#' and checks for misspelling typos (fuzzy match).
#'
#' @param splist A character vector containing the species names to be checked.
#' @param dist Maximum allowed distance for fuzzy matching of species names.
#' @param output Output type. `"status"` returns the legacy character vector;
#'   `"detailed"` returns row-level matching diagnostics.
#' @param quiet If `TRUE`, suppresses summary messages.
#'
#' @return With `output = "status"`, a character vector indicating whether each
#' input name is listed as endemic. With `output = "detailed"`, a tibble with
#' row-level matching diagnostics.
#'
#' @details
#' This function checks each species name in the provided list against the
#' Red Book of Endemic Plants of Peru database using fuzzy matching based on
#' the specified maximum distance (`dist`). It provides information about the
#' endemic status of each species and flags if the recorded name needs updating.
#' It also counts the number of exact and fuzzy matches found.
#'
#' @examples
#' # Example usage of the function
#' splist <- c("Aphelandra cuscoenses",
#'             "Piper stevensi",
#'             "Sanchezia ovata",
#'             "Verbesina andina",
#'             "Festuca dentiflora",
#'             "Eucrosia bicolor var. plowmanii",
#'             "Hydrocotyle bonplandii var. hirtipes",
#'             "Persea americana")
#'
#' # Basic usage
#' check_redbooklist(splist = splist, dist = 0.2)
#'
#' # Using base R with a data frame
#' plant_list <- data.frame(splist = splist)
#' plant_list$label <- check_redbooklist(plant_list$splist, dist = 0.2)
#' plant_list
#'
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#' [The World Checklist of Vascular Plants, a continuously updated resource for exploring global plant diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
#' [Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
#' [Plants of the World Online - Facilitated by the Royal Botanic Gardens - Kew.](http://www.plantsoftheworldonline.org/)
#'
#' @export
#' @name check_redbooklist
check_redbooklist <- function(splist,
                              dist = 0.02,
                              output = c("status", "detailed"),
                              quiet = FALSE) {
  output <- match.arg(output)

  result <- match_redbook_names(splist = splist,
                                dist = dist,
                                parser = "wcvpmatch",
                                output = "detailed")

  if (identical(output, "detailed")) {
    return(result)
  }

  output_vector <- ifelse(result$endemic_status == "endemic",
                          "endemic",
                          ifelse(result$endemic_status == "not_endemic",
                                 "not endemic",
                                 NA_character_))

  if (!isTRUE(quiet)) {
    message(paste("Total exact matches:",
                  sum(result$match_status == "exact", na.rm = TRUE)))
    message(paste("Total fuzzy matches:",
                  sum(result$match_status %in% c("fuzzy", "ambiguous"),
                      na.rm = TRUE)))
  }

  output_vector
}
