#-------------------------------------------------------#
# Function to clean species list names
#' @keywords internal

standardize_names <- function(splist) {
  fixed1 <- trimws(splist) |>
    simple_cap()# all up
  fixed2 <- gsub("cf\\.", "", fixed1)
  fixed3 <- gsub("aff\\.", "", fixed2)
  fixed4 <- trimws(fixed3) # remove trailing and leading space
  fixed5 <- gsub("_", " ", fixed4) # change names separated by _ to space

  # Hybrids
  fixed6 <- gsub("(^x )|( x$)|( x )", " ", fixed5)
  hybrids <- fixed5 == fixed6
  if (!all(hybrids)) {
    sp_hybrids <- splist[!hybrids]
    warning(paste("The 'x' sign indicating hybrids have been removed in the",
                  "following names before search:",
                  paste(paste0("'", sp_hybrids, "'"), collapse = ", ")),
            immediate. = TRUE, call. = FALSE)
  }
  # Merge multiple spaces
  fixed7 <- gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", fixed6, perl = TRUE)
  return(fixed7)
}

#-------------------------------------------------------#
# Function to check list of names input
#' @keywords internal
check_names <- function(splist,
                        argument_name) {

  # Check if it is a character
  if (!is.character(splist) | !is.vector(splist)) {
    stop(paste0(argument_name,
                " should be a character vector, not '",
                paste(class(splist), collapse = " "), "'"),
         call. = FALSE)
  }
  enc_valid <- !validEnc(splist)

  # Check if it has invalid encoding
  if (any(enc_valid)) {
    stop(paste(argument_name,
               "should include only valid characters,",
               "please check the name(s) at position(s):",
               paste(which(enc_valid), collapse = ", ")),
         call. = FALSE)
  }
}


#-------------------------------------------------------#
# Check if names are binomial
#' @keywords internal
simple_cap <- function (x) {
  x <- tolower(x)
  words <- sapply(strsplit(x, "\\s+"), function(words) paste(tolower(words),
                                                             collapse = " "))
  capitalized <- sapply(strsplit(words, ""), function(word) {
    if (length(word) > 0) {
      word[1] <- toupper(word[1])
    }
    paste(word, collapse = "")
  })
  return(capitalized)
}
