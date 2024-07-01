#' Species Names Listed in The Red Book of Endemic Plants of Peru
#'
#' The `redbook_tab` contains records for all species listed in The Red Book of Endemic Plants of Peru.
#'
#' @name redbook_tab
#' @docType data
#' @format A tibble with the following columns:
#' \describe{
#'   \item{redbook_id}{The fixed species ID of the input taxon in The Red Book of Endemic Plants of Peru.}
#'   \item{redbook_name}{A character vector. The species name as listed in The Red Book of Endemic Plants of Peru.}
#'   \item{input_genus}{A character vector. The input genus of the corresponding species name listed.}
#'   \item{input_epitheton}{A character vector. The specific epithet of the corresponding species name listed.}
#'   \item{rank}{A character vector. The taxonomic rank (e.g., "species", "subspecies", "variety") of the corresponding species name listed.}
#'   \item{input_subspecies_epitheton}{A character vector. The infraspecific epithet of the corresponding species name listed, if applicable.}
#'   \item{accepted_name}{A character vector. The accepted plant taxa names according to the World Checklist of Vascular Plants (WCVP).}
#'   \item{accepted_family}{A character vector. The corresponding family name of the accepted name.}
#'   \item{accepted_name_author}{A character vector. The author of the accepted name.}
#'   \item{accepted_name_rank}{A character vector. The rank of the accepted name (e.g., species, subspecies).}
#'   \item{tag_subsp_wcvp}{A character vector. A tag indicating if the subspecies is recognized in the WCVP.}
#'   \item{genus_ephitethon_wcvp}{A character vector. The genus part of the name according to the WCVP.}
#'   \item{species_ephitethon_wcvp}{A character vector. The specific epithet part of the name according to the WCVP.}
#'   \item{subspecies_ephitethon_wcvp}{A character vector. The infraspecific epithet part of the name according to the WCVP, if applicable.}
#' }
#'
#' @references León, Blanca, et.al. 2006. “The Red Book of Endemic Plants of Peru”. Revista Peruana De Biología 13 (2): 9s-22s. https://doi.org/10.15381/rpb.v13i2.1782.
#'
#' @keywords datasets
#' @examples
#'
#' data("redbook_tab")
#' head(redbook_tab)
#'
"redbook_tab"


#' List of Species Names in redbook_sps_class Separated by Category
#'
#' The `redbook_sps_class` dataset includes all species names separated by genus,
#' epithet, author, subspecies, variety, and their position (ID) in the
#' \code{redbook_tab}.
#'
#' @name redbook_sps_class
#' @docType data
#' @format A data.frame with the following columns:
#' \describe{
#'   \item{species}{A character vector. The full species name.}
#'   \item{genus}{A character vector. The genus of the species.}
#'   \item{epithet}{A character vector. The specific epithet of the species.}
#'   \item{input_subspecies_epitheton}{A character vector. The infraspecific epithet of the species, if applicable.}
#'   \item{rank}{A character vector. The taxonomic rank (e.g., "species", "subspecies", "variety").}
#'   \item{subspecies}{A character vector. The subspecies name, if applicable.}
#'   \item{variety}{A character vector. The variety name, if applicable.}
#'   \item{hybrid}{A character vector. Indicates if the species is a hybrid.}
#'   \item{id}{A character vector. The ID of the species in the \code{redbook_tab}.}
#' }
#'
#' @keywords datasets
#' @examples
#'
#' data("redbook_sps_class")
#' head(redbook_sps_class)
#'
"redbook_sps_class"


#' List of the number positions of the first 3 letters of the species name in
#' the redbook_tab
#'
#' The 'redbook_position' reports the
#' position (in term of number of rows) of the first three letters (triphthong)
#' for the plant names stored in the variable 'accepted_name' of the table
#' 'redbook_tab'. This indexing system speeds up of the search on the
#' largest list using the package.
#'
#'
#' Positions of Species Names in The Red Book of Endemic Plants of Peru
#'
#' The `redbook_position` dataset provides the positions of the first three letters of each species name listed in the `redbook_tab`.
#'
#' @name redbook_position
#' @docType data
#' @format A data frame with 978 observations on the following 3 variables:
#' \describe{
#'   \item{position}{A character vector. The position of the first three letters of the species name in the `redbook_tab`.}
#'   \item{triphthong}{A character vector. The first three letters of the species name in the `redbook_tab`.}
#'   \item{genus}{A character vector. The corresponding genus name.}
#' }
#'
#' @keywords datasets
#' @examples
#'
#' data("redbook_position")
#' head(redbook_position)
#'
"redbook_position"

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
#'   \item{publication}{Bibliographic reference where the taxon was originally described.}
#'   \item{collector}{Name(s) of the collector(s) of the type specimen.}
#'   \item{herbariums}{Acronyms of the institutions where the type specimens of the taxon are deposited.}
#'   \item{common_name}{Common names of the species as mentioned in the literature.}
#'   \item{dep_registry}{Abbreviations of the departments where the taxon has been recorded.}
#'   \item{ecological_regions}{Abbreviations of the ecological regions proposed by Zamora (1996).}
#'   \item{sinampe}{Abbreviation of the Protected Natural Area where the taxon was recorded.}
#'   \item{peruvian_herbariums}{Acronyms of the Peruvian institutions where both type and non-type specimens are deposited.}
#'   \item{remarks}{Observations and additional information about the endemic taxon.}
#' }
#'
#' @details This database provides essential information for research and conservation
#' efforts related to Peru's endemic flora, offering access to the data presented in the corresponding book.
#'
#' @references
#' León, Blanca, et.al. 2006. “The Red Book of Endemic Plants of Peru”. Revista Peruana De Biología 13 (2): 9s-22s. https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153
#'
#' @name redbook_sp_data
#' @docType data
#'
#' @examples
#'
#' # Example illustrating how to load and explore the database
#' data("redbook_sp_data")
#' head(redbook_sp_data)
#'
"redbook_sp_data"
