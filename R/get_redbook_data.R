#' Get Red Book Data for Given Species List
#'
#' This function retrieves comprehensive information from the Red Book of Endemic Plants
#' of Peru database for a provided list of species. It associates the provided
#' species names with their corresponding updated taxonomic information and
#' descriptions recorded in the original publication.
#'
#' @param splist A character vector containing the species names to be queried.
#' @param dist Maximum allowed distance for fuzzy matching of species names.
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
get_redbook_data <- function(splist, dist = 0.1) {
  output_names <- c( "name_subitted",
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
                     "remarks")
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }

  # Remueve valores NA y strings vacíos de splist
  splist_clean <- splist[!is.na(splist) & nchar(splist) > 0]

  # Mensaje sobre observaciones eliminadas o strings vacíos
  if (length(splist) != length(splist_clean)) {
    deleted_obs <- length(splist) - length(splist_clean)
    message(paste0(as.numeric(deleted_obs),
                   " missing observation(s) or empty string(s) were removed."))
  }
  # Create an output data container
  output_list <- list()
  # Loop code to find the matching string
  for (i in seq_along(splist_clean)) {
    result <- search_redbook(splist = splist_clean[i],
                             max_distance = dist)
    # Output selection
    if (is.null(result)) {
      output <- matrix(c(splist_clean[i],
                         rep("---", 14)), nrow = 1)
      #colnames(output) <- output_names
    } else if (!is.null(result)) {
      ids <- result$redbook_id
      row_data <- redbookperu::redbook_tab[redbookperu::redbook_tab$redbook_id == ids, ]
      book_data <- redbookperu::redbook_sp_data[redbookperu::redbook_sp_data$redbook_id == ids,]
      outputmatrix <- cbind(row_data[, c("accepted_name",
                                         "accepted_name_author",
                                         "accepted_family")],
                            book_data[, -c(1)])
      output <- as.matrix(cbind(name_submitted = splist_clean[i],
                      outputmatrix))
    }
    output_list[[i]] <- output
  }
  output_df <- as.data.frame(do.call(rbind, output_list))
  colnames(output_df) <- output_names
  row.names(output_df) <- NULL
  return(output_df)
}
