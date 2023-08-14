# -------------------------------------------------------------------------
#' Redbook Taxonomy Database
#'
#'
#' This database contains taxonomic information of endemic plant species from Peru.
#'
#' @details
#' This database serves as the primary reference for conducting partial and exact
#' searches of species listed in the Red Book of Endemic Plants of Peru. The
#' information in this database has been standardized using the Taxonomic Name
#' Resolution Service (TNRS) and the World Checklist of Vascular Plants (WCVP)
#' to ensure consistency and accuracy.
#'
#'
#' @format A tibble:
#'   \describe{
#'     \item{redbook_id}{Unique identifier for each species in the Red Book of Endemic Plants of Peru.}
#'     \item{redbook_name}{The species name registered in the original dataset.}
#'     \item{accepted_name}{The updated accepted scientific name of each species.}
#'     \item{accepted_family}{The accepted family of the species.}
#'     \item{accepted_name_author}{The author of the accepted scientific name.}
#'     \item{taxonomic_status}{The taxonomic status of the species (Accepted, Synonym, No opinion).}
#'   }
#'
#' @keywords dataset
#' @usage data(redbook_taxonomy)
#'
#' @docType data
#'
#' @examples
#' \dontrun{
#' data(redbook_taxonomy)
#' head(redbook_taxonomy)
#' }
"redbook_taxonomy"
