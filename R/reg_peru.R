#' Regions of Peru Database (sf object)
#'
#' This database contains the geospatial information of the administrative
#' regions of Peru.
#'
#' @format An sf object representing a simple feature collection with 25 features
#' and 4 fields.
#' \describe{
#'   \item{level2_code}{Two letter code for the administrative region.}
#'   \item{name}{Name of the administrative region.}
#'   \item{woe_name}{WOE name of the administrative region.}
#'   \item{gn_name}{GN name of the administrative region.}
#'   \item{geometry}{Geospatial information in MULTIPOLYGON format.}
#' }
#'
#' @details
#' This sf object contains the geospatial representation of the administrative
#' regions of Peru. It includes information such as the name of the region, the
#' WOE name, the GN name, and the geometry in MULTIPOLYGON format.
#'
#' @name reg_peru
#' @docType data
#'
#' @examples
#' data(reg_peru)
#'
#'
#' @keywords dataset, spatial data, geospatial, Peru, administrative regions, sf
#'
"reg_peru"
