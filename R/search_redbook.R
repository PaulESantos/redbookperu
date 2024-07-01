#' Search Species Names in “The Red Book of Endemic Plants of Peru”
#'
#' This function allows searching for plant taxa names listed in
#' "The Red Book of Endemic Plants of Peru". It connects to the data
#' listed in the catalog and validates if the species is present, removing
#' orthographic errors in plant names.
#'
#' @param splist A character vector specifying the input taxon, each element
#' including genus and specific epithet and, potentially, infraspecific rank,
#' infraspecific name, and author name.
#' Only valid characters are allowed (see \code{\link[base:validEnc]{base::validEnc}}).
#'
#' @param max_distance An integer or fraction specifying the maximum distance
#' allowed when comparing the submitted name with the closest
#' name matches in the species listed in "The Red Book of Endemic Plants of Peru".
#' The distance used is a generalized
#' Levenshtein distance indicating the total number of insertions, deletions,
#' and substitutions allowed to match the two names. For example, a name with
#' a length of 10 and a max_distance = 0.1 allows only one change (insertion,
#' deletion, or substitution). A max_distance = 2 allows two changes.
#'
#' @param show_correct If TRUE, a column is added to the final result indicating
#' whether the binomial name was exactly matched (TRUE) or if it is misspelled (FALSE).
#'
#' @param genus_fuzzy If TRUE, allows fuzzy matching at the genus level.
#'
#' @param grammar_check If TRUE, performs a grammar check on the species names.
#'
#' @details
#'
#' The function tries to match names in "The Red Book of Endemic Plants of Peru",
#' which has a corresponding
#' accepted valid name (accepted_name). If the input name is a valid name,
#' it will be duplicated in the accepted_name column.
#'
#' The algorithm will first try to exactly match the binomial names provided in
#' `splist`. If no match is found, it will try to find the closest name given the
#' maximum distance defined in `max_distance`.
#' Note that only binomial names with valid characters are allowed in this
#' function.
#'
#' @return A data frame with the matched species names and additional
#' information from the redbook catalog.
#' If no match is found, a warning is issued suggesting to increase
#' the `max_distance` argument.
#'
#' @references León, Blanca, et.al. 2006. “The Red Book of Endemic Plants
#' of Peru”. Revista Peruana De Biología 13 (2): 9s-22s. https://doi.org/10.15381/rpb.v13i2.1782.
#'
#' @keywords internal
#'
search_redbook <- function(splist,
                      max_distance = 0.2,
                      show_correct = FALSE,
                      genus_fuzzy = FALSE,
                      grammar_check = FALSE) {
  #hasData() # Check if LCVP is installed
  # Defensive function here, check for user input errors
  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  .names_check(splist, "splist")

  # Fix species name
  splist_std <- .names_standardize(splist)
  # Classify splist
  splist_class <- .splist_classify(splist_std)

  # Check binomial
  .check_binomial(splist_class, splist)

  # Now match
  matching <- .match_algorithm(splist_class,
                               max_distance,
                               progress_bar = progress_bar,
                               genus_fuzzy = genus_fuzzy,
                               grammar_check = grammar_check)

  # Elaborate the return object
  ## Return Null if it did not find anything
  if (all(is.na(matching))) {
    result_final <- NULL
    ## Return the matrix with matched species
  } else {
    comb_match <- matching[, -(1:2), drop = FALSE]
    # keep homonyms to the warning
    ho_pos <- ncol(comb_match)
    homonyms <- as.logical(comb_match[, ho_pos])
    homonyms[is.na(homonyms)] <- FALSE
    comb_match <- comb_match[, -ho_pos, drop = FALSE]

    comb_match <- as.matrix(apply(comb_match, 2, as.logical))

    if (ncol(comb_match) == 1) { # If only one column, need to be transposed
      comb_match <- t(comb_match)
    }
    # Transform in data.frame
    comb_match <- as.data.frame(comb_match)

    names_col <-
      colnames(redbook_sps_class)[-c(1,
                           ncol(redbook_sps_class))]

    colnames(comb_match) <- paste(names_col, "match", sep = "_")

    result_final <- data.frame("name_submitted" = splist,
                               redbook_tab[matching[, 1], ,
                                                        drop = FALSE])

    # Add whether the searched name matched each class,
    # will be used in the summary function
    attributes(result_final)$match.names <- comb_match
    # Remove row names
    rownames(result_final) <- NULL

    # Warning more than one match
    if (any(homonyms)) {
      warning(
        paste0(
          "More than one name was matched for some species. ",
          "Only the first 'Accepted' (if present) name was returned. ",
          "Consider using the function fuzzy_search ",
          "to return all names for these species:\n",
          paste(result_final[homonyms, 1], collapse = ", ")
        ),
        call. = FALSE
      )
      attributes(result_final)$matched_mult <- result_final[homonyms, 1]
    }
  }

  # If no match, give a warning
  #if (is.null(result_final)) {
  #  (paste0("No match found for the species list provided."))
  #} else {
    if (show_correct) {

      result_final$Correct <- rowSums(comb_match[, 1:2, drop = FALSE]) == 2
    }
  #}

  return(result_final)
}

