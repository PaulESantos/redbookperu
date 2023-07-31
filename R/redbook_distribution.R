#' redbook_distribution Dataset
#'
#' This dataset, `redbook_distribution`, provides information on the
#' distribution of plant species listed in the Red Book of Endemic Plants
#' of Peru. It is a tibble (data frame) containing seven variables:
#'
#' \describe{
#'   \item{possible_names}{Character vector with possible names for each taxon.}
#'   \item{taxon_name}{Character vector with the taxonomic names of the species.}
#'   \item{accepted_name}{Character vector with the accepted names for each taxon.}
#'   \item{accepted_name_author}{Character vector with the authors of the accepted names.}
#'   \item{accepted_family}{Character vector with the accepted family for each taxon.}
#'   \item{taxonomic_status}{Character vector indicating the taxonomic status (e.g., "Accepted", "Synonym") of each taxon.}
#'   \item{level2_code}{Character vector with the level 2 code for the distribution of each taxon.}
#' }
#'
#' The `redbook_distribution` dataset is a tibble (data frame) that contains the
#' distribution information for a subset of taxa listed in the Red Book of Endemic
#' Plants of Peru.
#'
#'
#' @seealso [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#'
#' @name redbook_distribution
#' @docType data
#'
#' @examples
#' \dontrun{
#'   head(redbook_distribution)
#' }
#'
"redbook_distribution"
