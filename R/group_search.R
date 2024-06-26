#-------------------------------------------------------#
# Function for multiple names
.group_pt <- function(group_names,
                      group_ref,
                      max_distance) {
  # group_names = list of names to be searched
  # group_ref = reference species name
  # max_distance = fuzzy match distance allowed

  # Length of group names
  n_groups <- length(group_names)
  # Object to keep the results
  groups_pos <- numeric(n_groups)
  # Loop over all names applying the individual function
  for (i in 1:n_groups) {
    groups_pos[i] <- .group_ind(group_names[i],
                                group_ref,
                                max_distance)
  }
  # Result the position in the list
  return(groups_pos)
}


#-------------------------------------------------------#
# Function to search species names,
# based on group (genus, family, order)
#' @keywords internal

.group_ind <- function(group_name,
                       group_ref,
                       max_distance,
                       only_one = TRUE,
                       closest = FALSE) {
  # Get the position
  group_pos <- which(group_ref == group_name)

  # Fuzzy match if it did not work
  if (length(group_pos) == 0) {
    if (max_distance > 0) {
      group_pos <- .agrep_whole(group_name,
                                group_ref,
                                max_distance = max_distance)
      closest1 <- utils::adist(group_name, group_ref[group_pos])

      if (closest & length(group_pos) > 0) {
        which_closest1 <- which(closest1 == min(closest1))
        group_pos <- group_pos[which_closest1]
      }
      n_temp <- length(group_pos)

      if (n_temp > 1 & only_one) {
        # If more than one, get the closest
        which_closest <- which.min(utils::adist(group_name,
                                                group_ref[group_pos]))
        group_pos <- group_pos[which_closest] # choose more than one
      }
      if (n_temp == 0) {
        # if no match is found, return NA
        group_pos <- NA
      }
    } else {
      group_pos <- NA
    }
  }

  return(group_pos)
}
