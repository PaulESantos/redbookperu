#' Check Species Names in the Red Book of Endemic Plants of Peru
#'
#' This function checks a list of species names against the Red Book of Endemic Plants
#' of Peru database and provides information about whether a species was recorded as endemic,
#' its current taxonomic status, and checks for misspelling typos (fuzzy match).
#'
#' @param splist A character vector containing the species names to be checked.
#' @param tax_status Logical value indicating whether to provide taxonomic status information.
#'                   If TRUE, it will provide taxonomic status information. If FALSE, it will
#'                   provide endemism information.
#' @param max_distance Maximum allowed distance for fuzzy matching of species names.
#'
#' @return A character vector with information about the taxonomic status or endemism
#'         of the provided species names.
#'
#' @details This function checks each species name in the provided list against the
#'          Red Book of Endemic Plants of Peru database. It performs fuzzy matching
#'          based on the specified maximum distance.
#'          The output could inform about taxonomic status:
#'          a) "Accepted name" if the input names recorded are valid,
#'          b) "Updated name", when the input name is currently a synonym,
#'          c) "No opinion", if the current taxonomic status of the input name is undefined, and
#'          d) "No info. available" for species names recorded in the Red Book that couldn't
#'          be found in the WCVP database for name status validation. The output
#'          name for this group of species is the name recorded in the original publication.
#'
#'          The output also returns information about possible misspelling,
#'          adding "fuzzy match" to the output when a typo is found.
#'
#' @examples
#'
#' # Example usage of the function
#' splist <- c("Aphelandra cuscoenses", "Sanchezia capitata",
#'             "Sanchezia ovata", "Piper stevensi",
#'             "Verbesina andinaa", "Verbesina andina")
#'
#' result_tax <- check_redbook(splist, tax_status = TRUE)
#' print(result_tax)
#'
#' result_endemism <- check_redbook(splist, tax_status = FALSE)
#' print(result_endemism)
#'
#'
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#' [The World Checklist of Vascular Plants, a continuously updated resource for exploring global plant diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
#' [Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
#' [Plants of the World Online - Facilitated by the Royal Botanic Gardens - Kew.](http://www.plantsoftheworldonline.org/)
#'
#' @name check_redbook
#'
#' @export
check_redbook <- function(splist, tax_status = TRUE, max_distance = 0.1) {
  # review text class
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  # Standardize species names
  splist_std <- standardize_names(splist)
  # Remove any NA values from splist_std
  splist_std <- splist_std[!is.na(splist_std)]
  # Create an output data container
  output_vector <- character(length(splist_std))
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
      output <- "Not recorded in the Red Book"
    }
    else if (length(matches_i) != 0){
      row_data <- redbookperu::redbook_taxonomy[redbookperu::redbook_taxonomy$redbook_name %in% matches_i, ]
      taxonomic_status <- row_data$taxonomic_status
      if(tax_status == TRUE){
        if(taxonomic_status == "Accepted" & match_dist == 0){
          output <- paste0(row_data$accepted_name, " - Accepted name")
        }
        else if(taxonomic_status == "Accepted" & match_dist != 0){
          output <- paste0(row_data$accepted_name, " - Accepted name - Fuzzy match")
        }
        else if(taxonomic_status == "Synonym" & match_dist == 0){
          output <- paste0(row_data$accepted_name, " - Updated name")
        }
        else if(taxonomic_status == "Synonym" & match_dist != 0){
          output <- paste0(row_data$accepted_name, " - Updated name - Fuzzy match")
        }
        else if(taxonomic_status == "No opinion" & match_dist == 0){
          output <- paste0(row_data$accepted_name, " - No opinion")
        }
        else if(taxonomic_status == "No opinion" & match_dist != 0){
          output <- paste0(row_data$accepted_name, " - No opinion - Fuzzy match")
        }
        else if(taxonomic_status == "nill" & match_dist == 0){
          output <- paste0(row_data$redbook_name, " - No info. available")
        }
        else if(taxonomic_status == "nill" & match_dist != 0){
          output <- paste0(row_data$redbook_name, " - No info. available - Fuzzy match")
        }
      }
      else if (tax_status == FALSE){
        if(match_dist == 0 & taxonomic_status != "nill"){
          output <-  paste0(row_data$accepted_name, " is endemic")
        }
        else  if(match_dist != 0 & taxonomic_status != "nill"){
          output <- paste0(row_data$accepted_name, " is endemic - fuzzy macth")
        }
        else  if(match_dist == 0 & taxonomic_status == "nill"){
          output <- paste0(row_data$redbook_name, " is endemic")
        }
        else  if(match_dist != 0 & taxonomic_status == "nill"){
          output <- paste0(row_data$redbook_name, " is endemic - fuzzy match")
        }
      }
    }
    output_vector[i] <- output
  }
  return(output_vector)
}
