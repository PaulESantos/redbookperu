#' Check Species Names in the Red Book of Endemic Plants of Peru
#'
#' This function checks a list of species names against the Red Book of Endemic Plants
#' of Peru database and provides information about whether a species was recorded as endemic,
#' and checks for misspelling typos (fuzzy match).
#'
#' @param splist A character vector containing the species names to be checked.
#' @param dist Maximum allowed distance for fuzzy matching of species names.
#'
#' @return A character vector indicating if each input species name is listed as "endemic"
#' in the Red Book of Endemic Plants of Peru database. Returns "endemic" if the species name
#' is listed and "not endemic" if no matching entry is found.
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
check_redbooklist <- function(splist, dist = 0.02) {
  # Revisa la clase del vector de entrada
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

  # Crear contenedor de datos de salida
  output_vector <- character(length(splist_clean))

  # Inicializar contadores para los flags
  total_exact_matches <- 0
  total_fuzzy_matches <- 0

  # Loop para encontrar las coincidencias
  for (i in seq_along(splist_clean)) {
    result <- search_redbook(splist = splist_clean[i],
                             max_distance = dist)

    # Si no se encuentra ninguna coincidencia, crear un resultado vacío
    if (is.null(result) || nrow(result) == 0) {
      result <- data.frame(
        name_submitted = splist_clean[i],
        redbook_id = NA,
        redbook_name = NA,
        input_genus = NA,
        input_epitheton = NA,
        rank = NA,
        input_subspecies_epitheton = NA,
        accepted_name = NA,
        accepted_family = NA,
        accepted_name_author = NA,
        accepted_name_rank = NA,
        tag_subsp_wcvp = NA,
        genus_ephitethon_wcvp = NA,
        species_ephitethon_wcvp = NA,
        subspecies_ephitethon_wcvp = NA,
        dist = NA,
        endemic_flag = "not endemic",
        update_flag = "Not matching data",
        match_flag = "no match"
      )
    } else {
      # Calcular distancia de Levenshtein
      result$dist <- diag(utils::adist(result$name_submitted, result$redbook_name))

      # Calcular flags
      result$endemic_flag <- ifelse(!is.na(result$redbook_name),
                                    "endemic",
                                    "not endemic")
      result$update_flag <- ifelse(result$redbook_name == result$accepted_name,
                                   "Non update name",
                                   "Update name")
      result$update_flag <- ifelse(result$accepted_name == "null",
                                   "Unplaced name",
                                   result$update_flag)
      result$update_flag <- ifelse(is.na(result$redbook_name) & is.na(result$accepted_name),
                                   "Not matching data",
                                   result$update_flag)
      result$match_flag <- ifelse(result$dist == 0, "exact", "fuzzy")
      result$match_flag <- ifelse(is.na(result$dist),
                                  "no match",
                                  result$match_flag)
    }

    # Contar tipos de coincidencias y mensajes
    if (result$match_flag == "exact") {
      total_exact_matches <- total_exact_matches + 1
    } else if (result$match_flag == "fuzzy") {
      total_fuzzy_matches <- total_fuzzy_matches + 1
    }

    # Agregar flag de endemicidad al vector de salida
    output_vector[i] <- result$endemic_flag
  }

  # Mensajes de resumen
  message(paste("Total exact matches:", total_exact_matches))
  message(paste("Total fuzzy matches:", total_fuzzy_matches))

  return(output_vector)
}
