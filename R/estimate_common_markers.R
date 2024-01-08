#' Common markers estimation
#'
#' Estimate the number of common markers between offspring and parent 1 or parent 2
#'
#' @param marker_data Hapmap with SNP markers information (letters)
#' @param specific_lines_df Dataframe with three columns 1) offspring, 2) parent 1, and 3) parent 2
#'
#' @return A dataframe with the number of common SNPs between offspring and parent
#' @export
#'
#' @examples estimate_common_markers(markers, crosses)
estimate_common_markers <- function(marker_data, specific_lines_df) {
  result <- specific_lines_df
  colnames(result) <- c("GID", "F_GID", "M_GID")  # To ensure consistent column names

  for (i in 1:nrow(specific_lines_df)) {
    offspring <- as.character(specific_lines_df[i, "GID"])
    parent1 <- as.character(specific_lines_df[i, "F_GID"])
    parent2 <- as.character(specific_lines_df[i, "M_GID"])

    offspring_markers <- marker_data[[offspring]]
    parent1_markers <- marker_data[[parent1]]
    parent2_markers <- marker_data[[parent2]]

    # Find rows with both columns having non-"N" values
    rows_with_no_N_values1 <- which(offspring_markers != "N" & parent1_markers != "N")
    rows_with_no_N_values2 <- which(offspring_markers != "N" & parent2_markers != "N")
    rows_with_no_N_values3 <- which(parent1_markers != "N" & parent2_markers != "N")

    # Get the common elements for rows with non-"N" values in both columns
    offspring_parent1_common <- if (length(rows_with_no_N_values1) > 0) {
      sum(mapply(count_common_elements, offspring_markers[rows_with_no_N_values1], parent1_markers[rows_with_no_N_values1]))
    } else {
      NA
    }

    offspring_parent2_common <- if (length(rows_with_no_N_values2) > 0) {
      sum(mapply(count_common_elements, offspring_markers[rows_with_no_N_values2], parent2_markers[rows_with_no_N_values2]))
    } else {
      NA
    }

    parent1_parent2_common <- if (length(rows_with_no_N_values3) > 0) {
      sum(mapply(count_common_elements, parent1_markers[rows_with_no_N_values3], parent2_markers[rows_with_no_N_values3]))
    } else {
      NA
    }

    # Total number of rows considered (filtered for "N" values) in the operation
    total_rows_considered1 <- length(rows_with_no_N_values1)
    total_rows_considered2 <- length(rows_with_no_N_values2)
    total_rows_considered3 <- length(rows_with_no_N_values3)

    result[i, "offspring_Parent1_total"] <- total_rows_considered1
    result[i, "offspring_Parent1_Common"] <- offspring_parent1_common
    result[i, "offspring_Parent2_total"] <- total_rows_considered2
    result[i, "offspring_Parent2_Common"] <- offspring_parent2_common
    result[i, "Parent1_Parent2_total"] <- total_rows_considered3
    result[i, "parent1_parent2_common"] <- parent1_parent2_common
  }

  return(result)
}
