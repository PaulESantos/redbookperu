#' Get Red Book Data for Given Species List
#'
#' This function retrieves information from the Red Book of Endemic Plants
#' of Peru database for a provided list of species. It associates the provided
#' species names with their corresponding updated taxonomic information and
#' descriptions recorded in the original publication.
#'
#' @param splist A character vector containing the species names to be queried.
#' @param max_distance Maximum allowed distance for fuzzy matching of species names.
#'
#' @return A data frame containing comprehensive information about the provided
#'         species, including updated taxonomic details and descriptions.
#'
#' @details This function checks each species name in the provided list against the
#'          Red Book of Endemic Plants of Peru database. It performs fuzzy matching
#'          based on the specified maximum distance. The output includes information
#'          such as the updated taxonomic details (accepted name, accepted family,
#'          and accepted name author) complemented with the information recorded
#'          in the original publication (IUCN conservation category, bibliographic
#'          reference, collector, herbariums, common name, departmental registrations,
#'          ecological regions, protected natural areas (SINANPE), Peruvian herbaria,
#'          and additional remarks).
#'
#' @seealso \code{\link{check_redbook}} function for a more detailed check of individual species.
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#' [The World Checklist of Vascular Plants, a continuously updated resource for exploring global plant diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
#' [Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
#' [Plants of the World Online - Facilitated by the Royal Botanic Gardens - Kew.](http://www.plantsoftheworldonline.org/)
#'
#' @examples
#'
#' # Example illustrating how to use the get_redbook function
#' species_list <- c("Aphelandra cuscoensis", "Sanchezia ovata", "Piper stevensii")
#' redbook_data <- get_redbook_data(species_list)
#' head(redbook_data)
#'
#' @name get_redbook_data
#' @export
get_redbook_data <- function(splist, max_distance = 0.1) {
  output_names <- c( "name_subitted",
                     "accepted_name",
                     "accepted_family",
                     "accepted_name_author",
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
                     "remarks")
  # Review text class
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  # Standardize species names
  splist_std <- standardize_names(splist)
  # Remove any NA values from splist_std
  splist_std <- splist_std[!is.na(splist_std)]
  # Create an output data container
  output_list <- list()
  # Loop code to find the matching string
  for (i in seq_along(splist_std)) {
    # Standardise max distance value
    max_distance_fixed <- max(ceiling(nchar(splist_std[i]) * max_distance))
    # Fuzzy and exact match
    matches <- agrep(splist_std[i],
                     redbookperu::redbook_taxonomy$redbook_name, # base data column
                     max.distance = max_distance_fixed,
                     value = TRUE)
    match_dist <- utils::adist(splist_std[i], matches)
    matches_i <- matches[which(match_dist <= max_distance_fixed)]
    # Output selection
    if (length(matches_i) == 0) {
      output <- matrix(c(splist_std[i], rep("nill", 14)), nrow = 1)
      #colnames(output) <- output_names
    } else if (length(matches_i) != 0) {
      row_data <- redbookperu::redbook_taxonomy[redbookperu::redbook_taxonomy$redbook_name %in% matches_i, ]
      book_data <- redbookperu::redbook_tab[redbookperu::redbook_tab$redbook_id %in% row_data$redbook_id,]
      outputmatrix <- cbind(row_data[, c(3:5)],
                            book_data[, -c(1)])
      output <- as.matrix(cbind(name_submitted = splist_std[i],
                      outputmatrix))
    }
    output_list[[i]] <- output
  }
  output_df <- as.data.frame(do.call(rbind, output_list))
  colnames(output_df) <- output_names
  row.names(output_df) <- NULL
  return(output_df)
}
