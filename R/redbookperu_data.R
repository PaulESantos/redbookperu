#' Database of the Red Book of Endemic Plants of Peru
#'
#' This database contains comprehensive information regarding the endemic plant species listed
#' in the Red Book of Endemic Plants of Peru. Each endemic taxon is accompanied by
#' corresponding variables that detail its taxonomic status, IUCN conservation category,
#' bibliographic references, type collection details, common names,
#' departmental registrations, ecological regions, protected natural areas (SINANPE),
#' and Peruvian herbaria where the specimens are deposited, as recorded in the original book.
#'
#' @format A data frame with the following variables:
#'
#' \describe{
#'   \item{redbook_id}{Unique identifier for each species in the Red Book of Endemic Plants of Peru.}
#'   \item{redbook_name}{Scientific name of the endemic species.}
#'   \item{iucn}{Conservation category assigned according to IUCN.}
#'   \item{publication}{Bibliographic reference where the taxon was originally proposed.}
#'   \item{collector}{Name(s) of the collector(s) of the type specimen.}
#'   \item{herbariums}{Acronyms of the institutions where the type specimens of the taxon
#'   are deposited.}
#'   \item{common_name}{Common names of the species as mentioned in the literature.}
#'   \item{dep_registry}{Abbreviations of the departments where the taxon has been recorded.}
#'   \item{ecological_regions}{Abbreviations of the ecological regions proposed by Zamora (1996).}
#'   \item{sinampe}{Abbreviation of the Protected Natural Area where the taxon was recorded.}
#'   \item{peruvian_herbariums}{Acronyms of the Peruvian institutions where both type and non-type
#'   specimens are deposited.}
#'   \item{remarks}{Observations and additional information about the endemic taxon.}
#' }
#'
#' @details The database encompasses essential information for research and conservation
#' efforts related to Peru's endemic flora, providing access to the data presented in the corresponding book.
#'
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#'
#' @name redbook_tab
#' @docType data
#'
#' @examples
#' \dontrun{
#' # Example illustrating how to load and explore the database
#' data(redbook_tab)
#' head(redbook_tab)
#' }

"redbook_tab"
