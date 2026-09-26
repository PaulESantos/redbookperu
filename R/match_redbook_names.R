#' Match Submitted Names Against the Red Book of Endemic Plants of Peru
#'
#' `match_redbook_names()` returns one row per submitted name with matching
#' diagnostics, endemicity status, and taxonomic context from the bundled Red
#' Book data.
#'
#' @param splist A character vector of submitted taxon names.
#' @param dist Maximum allowed edit distance for fuzzy matching. Values between
#'   0 and 1 are interpreted as a fraction of the submitted name length.
#' @param method Distance method. Currently only base R Levenshtein distance is
#'   used internally; the argument is reserved for compatibility with the
#'   planned `wcvpmatch` integration.
#' @param parser Parser preference. `"legacy"` uses the bundled parser.
#'   `"wcvpmatch"` uses `wcvpmatch::classify_spnames()` when available and
#'   falls back to the legacy parser otherwise.
#' @param allow_duplicates Logical. Kept for API compatibility; duplicated
#'   inputs are preserved in all cases.
#' @param output Output detail level. `"detailed"` returns the full diagnostic
#'   table. `"summary"` returns a compact subset.
#'
#' @return A data frame with one row per input name.
#' @export
match_redbook_names <- function(splist,
                                dist = 0.1,
                                method = "osa",
                                parser = c("wcvpmatch", "legacy"),
                                allow_duplicates = TRUE,
                                output = c("detailed", "summary")) {
  parser <- match.arg(parser)
  output <- match.arg(output)

  if (is.factor(splist)) {
    splist <- as.character(splist)
  }
  .names_check(splist, "splist")
  .redbook_resolve_distance("", dist)

  parsed <- .redbook_parse_names(splist, parser = parser)
  crosswalk <- .redbook_crosswalk()
  out <- .redbook_empty_match_result(parsed)

  for (i in seq_len(nrow(parsed))) {
    if (!isTRUE(parsed$input_valid[i])) {
      next
    }

    matched <- .redbook_match_one(parsed[i, , drop = FALSE],
                                  crosswalk = crosswalk,
                                  dist = dist)
    out[i, names(matched)] <- matched
  }

  if (identical(output, "summary")) {
    out <- out[, c("input_index",
                   "name_submitted",
                   "input_valid",
                   "redbook_id",
                   "redbook_name",
                   "accepted_name",
                   "matched_via",
                   "name_update_status",
                   "endemic_status",
                   "match_status",
                   "match_distance"), drop = FALSE]
  }

  row.names(out) <- NULL
  out
}

.redbook_parse_names <- function(splist, parser = "legacy") {
  if (identical(parser, "wcvpmatch") &&
      requireNamespace("wcvpmatch", quietly = TRUE)) {
    parsed <- tryCatch(
      wcvpmatch::classify_spnames(splist),
      error = function(e) NULL
    )
    if (!is.null(parsed)) {
      return(.redbook_parse_from_wcvpmatch(splist, parsed))
    }
  }

  .redbook_parse_legacy(splist)
}

.redbook_parse_from_wcvpmatch <- function(splist, parsed) {
  n <- length(splist)
  invalid <- .redbook_invalid_input(splist)

  get_column <- function(data, ...) {
    candidates <- c(...)
    hit <- candidates[candidates %in% names(data)][1]
    if (is.na(hit)) rep(NA_character_, n) else data[[hit]]
  }

  genus <- .redbook_null_if_empty(get_column(parsed, "orig_genus", "Orig.Genus"))
  species <- .redbook_null_if_empty(get_column(parsed, "orig_species", "Orig.Species"))
  infra_rank <- .redbook_null_if_empty(get_column(parsed, "infra_rank", "Infra.Rank"))
  infra <- .redbook_null_if_empty(get_column(parsed, "orig_infraspecies", "Orig.Infraspecies"))
  standardized_name <- .redbook_null_if_empty(get_column(parsed, "orig_name", "Orig.Name"))

  invalid_reason <- rep(NA_character_, n)
  invalid_reason[invalid] <- "missing_or_empty"
  invalid_reason[!invalid & (is.na(genus) | is.na(species))] <- "not_binomial"

  data.frame(
    input_index = seq_len(n),
    name_submitted = splist,
    input_valid = is.na(invalid_reason),
    invalid_reason = invalid_reason,
    standardized_name = standardized_name,
    genus = genus,
    species = species,
    infraspecific_rank = infra_rank,
    infraspecies = infra,
    stringsAsFactors = FALSE
  )
}

.redbook_parse_legacy <- function(splist) {
  n <- length(splist)
  invalid <- .redbook_invalid_input(splist)

  standardized_name <- rep(NA_character_, n)
  genus <- rep(NA_character_, n)
  species <- rep(NA_character_, n)
  infra_rank <- rep(NA_character_, n)
  infra <- rep(NA_character_, n)
  invalid_reason <- rep(NA_character_, n)
  invalid_reason[invalid] <- "missing_or_empty"

  valid_pos <- which(!invalid)
  if (length(valid_pos) > 0) {
    std <- .names_standardize(splist[valid_pos])
    classed <- .splist_classify(std)

    genus[valid_pos] <- simple_cap(classed[, "Genus"])
    species[valid_pos] <- tolower(classed[, "Epithet"])
    infra_rank[valid_pos] <- .redbook_legacy_infra_rank(classed)
    infra[valid_pos] <- .redbook_legacy_infra_name(classed)
    standardized_name[valid_pos] <- .redbook_build_name(genus[valid_pos],
                                                        species[valid_pos],
                                                        infra_rank[valid_pos],
                                                        infra[valid_pos])

    invalid_reason[valid_pos[is.na(genus[valid_pos]) |
                               is.na(species[valid_pos]) |
                               !nzchar(species[valid_pos])]] <- "not_binomial"
  }

  data.frame(
    input_index = seq_len(n),
    name_submitted = splist,
    input_valid = is.na(invalid_reason),
    invalid_reason = invalid_reason,
    standardized_name = standardized_name,
    genus = genus,
    species = species,
    infraspecific_rank = infra_rank,
    infraspecies = infra,
    stringsAsFactors = FALSE
  )
}

.redbook_legacy_infra_rank <- function(classed) {
  rank <- rep(NA_character_, nrow(classed))
  has_subsp <- nzchar(classed[, "Subspecies"])
  has_var <- nzchar(classed[, "Variety"])
  has_forma <- nzchar(classed[, "Forma"])
  rank[has_subsp] <- "subsp."
  rank[has_var] <- "var."
  rank[has_forma] <- "f."
  rank
}

.redbook_legacy_infra_name <- function(classed) {
  infra <- rep(NA_character_, nrow(classed))
  has_subsp <- nzchar(classed[, "Subspecies"])
  has_var <- nzchar(classed[, "Variety"])
  has_forma <- nzchar(classed[, "Forma"])
  infra[has_subsp] <- tolower(classed[has_subsp, "Subspecies"])
  infra[has_var] <- tolower(classed[has_var, "Variety"])
  infra[has_forma] <- tolower(classed[has_forma, "Forma"])
  .redbook_null_if_empty(infra)
}

.redbook_crosswalk <- function() {
  tab <- .redbook_taxonomy_data()
  tab$.row_index <- seq_len(nrow(tab))
  tab$matched_via <- "redbook_name"
  tab$genus <- .redbook_null_if_empty(tab$input_genus)
  tab$species <- .redbook_null_if_empty(tab$input_epitheton)
  tab$infraspecific_rank <- .redbook_rank_to_label(tab$rank)
  tab$infraspecies <- .redbook_null_if_empty(tab$input_subspecies_epitheton)
  tab$standardized_name <- .redbook_build_name(tab$genus,
                                               tab$species,
                                               tab$infraspecific_rank,
                                               tab$infraspecies)
  tab$name_key <- .redbook_name_key(tab$standardized_name)
  tab$binomial <- .redbook_build_name(tab$genus, tab$species)
  tab$binomial_key <- .redbook_name_key(tab$binomial)
  tab$taxon_status <- .redbook_taxon_status(tab$redbook_name, tab$accepted_name)

  aliases <- list(tab)
  for (alias_type in c("accepted_name", "wcvp_matched_name")) {
    if (!alias_type %in% names(tab)) {
      next
    }
    alias_value <- .redbook_null_if_empty(tab[[alias_type]])
    valid <- !is.na(alias_value)
    if (!any(valid)) {
      next
    }

    parsed <- .redbook_parse_legacy(alias_value[valid])
    alias_tab <- tab[valid, , drop = FALSE]
    alias_tab$matched_via <- alias_type
    alias_tab$genus <- parsed$genus
    alias_tab$species <- parsed$species
    alias_tab$infraspecific_rank <- parsed$infraspecific_rank
    alias_tab$infraspecies <- parsed$infraspecies
    alias_tab$standardized_name <- parsed$standardized_name
    alias_tab$name_key <- .redbook_name_key(alias_tab$standardized_name)
    alias_tab$binomial <- .redbook_build_name(alias_tab$genus,
                                              alias_tab$species)
    alias_tab$binomial_key <- .redbook_name_key(alias_tab$binomial)
    aliases[[length(aliases) + 1L]] <- alias_tab
  }

  do.call(rbind, aliases)
}

.redbook_empty_match_result <- function(parsed) {
  data.frame(
    input_index = parsed$input_index,
    name_submitted = parsed$name_submitted,
    input_valid = parsed$input_valid,
    invalid_reason = parsed$invalid_reason,
    standardized_name = parsed$standardized_name,
    redbook_id = NA_character_,
    redbook_name = NA_character_,
    accepted_name = NA_character_,
    accepted_family = NA_character_,
    accepted_name_author = NA_character_,
    taxon_status = NA_character_,
    matched_via = NA_character_,
    name_update_status = NA_character_,
    endemic_status = ifelse(parsed$input_valid, "not_endemic", "invalid_input"),
    match_status = ifelse(parsed$input_valid, "no_match", "invalid_input"),
    match_stage = "none",
    match_distance = NA_real_,
    candidate_count = 0L,
    ambiguous_candidates = NA_character_,
    stringsAsFactors = FALSE
  )
}

.redbook_match_one <- function(parsed_row, crosswalk, dist) {
  input_key <- .redbook_name_key(parsed_row$standardized_name)
  binomial <- .redbook_build_name(parsed_row$genus, parsed_row$species)
  binomial_key <- .redbook_name_key(binomial)

  exact <- which(crosswalk$name_key == input_key)
  if (length(exact) > 0) {
    return(.redbook_format_match(crosswalk[exact, , drop = FALSE],
                                 match_status = "exact",
                                 match_stage = "exact_name",
                                 match_distance = 0))
  }

  binomial_exact <- which(crosswalk$binomial_key == binomial_key)
  if (length(binomial_exact) > 0) {
    return(.redbook_format_match(crosswalk[binomial_exact, , drop = FALSE],
                                 match_status = "exact",
                                 match_stage = "genus_exact_species_exact",
                                 match_distance = 0))
  }

  genus_key <- tolower(parsed_row$genus)
  genus_candidates <- which(tolower(crosswalk$genus) == genus_key)
  if (length(genus_candidates) == 0) {
    genus_candidates <- seq_len(nrow(crosswalk))
  }

  distances <- as.numeric(utils::adist(tolower(binomial),
                                       tolower(crosswalk$binomial[genus_candidates])))
  max_distance <- .redbook_resolve_distance(binomial, dist)
  within <- which(distances <= max_distance)
  if (length(within) == 0) {
    return(list())
  }

  best_distance <- min(distances[within])
  best <- genus_candidates[within[distances[within] == best_distance]]
  .redbook_format_match(crosswalk[best, , drop = FALSE],
                        match_status = if (length(best) > 1) "ambiguous" else "fuzzy",
                        match_stage = "fuzzy_species",
                        match_distance = best_distance)
}

.redbook_format_match <- function(candidates,
                                  match_status,
                                  match_stage,
                                  match_distance) {
  first <- candidates[1, , drop = FALSE]
  candidate_names <- unique(candidates$redbook_name)
  match_status_out <- if (length(candidate_names) > 1) {
    "ambiguous"
  } else {
    match_status
  }
  list(
    redbook_id = first$redbook_id,
    redbook_name = first$redbook_name,
    accepted_name = .redbook_na_if_null(first$accepted_name),
    accepted_family = .redbook_na_if_null(first$accepted_family),
    accepted_name_author = .redbook_na_if_null(first$accepted_name_author),
    taxon_status = first$taxon_status,
    matched_via = first$matched_via,
    name_update_status = if (first$matched_via %in%
                             c("accepted_name", "wcvp_matched_name")) {
      "updated_name"
    } else {
      "historical_name"
    },
    endemic_status = "endemic",
    match_status = match_status_out,
    match_stage = match_stage,
    match_distance = as.numeric(match_distance),
    candidate_count = length(candidate_names),
    ambiguous_candidates = if (length(candidate_names) > 1) {
      paste(candidate_names, collapse = " | ")
    } else {
      NA_character_
    }
  )
}

.redbook_invalid_input <- function(x) {
  is.na(x) | !nzchar(trimws(x))
}

.redbook_null_if_empty <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  x[x == "" | tolower(x) == "null"] <- NA_character_
  x
}

.redbook_na_if_null <- function(x) {
  x <- .redbook_null_if_empty(x)
  ifelse(is.na(x), NA_character_, x)
}

.redbook_rank_to_label <- function(x) {
  x <- tolower(.redbook_null_if_empty(x))
  out <- rep(NA_character_, length(x))
  out[x %in% c("subsp", "subsp.", "ssp", "ssp.", "subspecies")] <- "subsp."
  out[x %in% c("var", "var.", "variety")] <- "var."
  out[x %in% c("f", "f.", "fo", "fo.", "forma", "form")] <- "f."
  out
}

.redbook_build_name <- function(genus, species, infra_rank = NA_character_,
                                infraspecies = NA_character_) {
  genus <- .redbook_null_if_empty(genus)
  species <- .redbook_null_if_empty(species)
  infra_rank <- .redbook_null_if_empty(infra_rank)
  infraspecies <- .redbook_null_if_empty(infraspecies)
  n <- max(length(genus), length(species), length(infra_rank),
           length(infraspecies))
  genus <- rep(genus, length.out = n)
  species <- rep(species, length.out = n)
  infra_rank <- rep(infra_rank, length.out = n)
  infraspecies <- rep(infraspecies, length.out = n)

  out <- paste(genus, species)
  has_infra <- !is.na(infra_rank) & !is.na(infraspecies)
  out[has_infra] <- paste(out[has_infra], infra_rank[has_infra],
                          infraspecies[has_infra])
  out[is.na(genus) | is.na(species)] <- NA_character_
  trimws(out)
}

.redbook_name_key <- function(x) {
  x <- tolower(trimws(as.character(x)))
  x <- gsub("[[:space:]]+", " ", x)
  x
}

.redbook_resolve_distance <- function(x, dist) {
  if (!is.numeric(dist) || length(dist) != 1 || is.na(dist) || dist < 0) {
    stop("dist must be a single non-negative number.", call. = FALSE)
  }
  if (dist > 0 && dist < 1) {
    return(ceiling(nchar(x) * dist))
  }
  as.integer(dist)
}

.redbook_taxon_status <- function(redbook_name, accepted_name) {
  accepted_name <- .redbook_null_if_empty(accepted_name)
  redbook_name <- .redbook_null_if_empty(redbook_name)
  ifelse(is.na(accepted_name),
         "unplaced",
         ifelse(.redbook_name_key(redbook_name) == .redbook_name_key(accepted_name),
                "accepted",
                "synonym"))
}
