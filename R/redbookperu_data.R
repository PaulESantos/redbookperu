#' Database of the Red Book of Endemic Plants of Peru
#'
#' This database contains detailed information about the endemic plant species listed
#' in the Red Book of Endemic Plants of Peru. Each endemic taxon is presented with
#' its respective variables describing its taxonomic status, conservation category
#' according to the IUCN, bibliographic references, type collection, common names,
#' departmental registrations, ecological regions, protected natural areas (SINANPE),
#' and Peruvian herbaria where the specimens are deposited.
#'
#' @format A data frame with the following variables:
#'
#' \describe{
#'   \item{species_name}{Scientific name of the endemic species.}
#'   \item{iucn}{Conservation category assigned according to the IUCN.}
#'   \item{publication}{Bibliographic reference where the taxon was proposed.}
#'   \item{collector}{Name of the collector(s) of the type specimen.}
#'   \item{herbariums}{Acronyms of the institutions where the type specimens of the taxon
#'   are deposited.}
#'   \item{common_name}{Common names of the species mentioned in the literature.}
#'   \item{dep_registry}{Abbreviations of the departments where the taxon has been recorded.}
#'   \item{ecological_regions}{Abbreviations of the ecological regions proposed by Zamora (1996).}
#'   \item{sinampe}{Abbreviation of the Protected Natural Area where the taxon has been recorded.}
#'   \item{peruvian_herbariums}{Acronyms of the Peruvian institutions where type and non-type
#'   specimens are deposited.}
#'   \item{remarks}{Observations and additional information about the endemic taxon.}
#' }
#'
#' @details The database contains essential information for the research and conservation
#' of Peru's endemic flora, providing access to the data presented in the book.
#'
#' @references
#' [Red Book of Endemic Plants of Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
#'
#' @name redbook_tab
#' @docType data
#'
#' @examples
#' # Example of how to load and explore the database
#' data(redbook_tab)
#' head(redbook_tab)
"redbook_tab"
