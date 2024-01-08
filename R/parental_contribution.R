#' Parental contribution
#'
#' Parental contribution estimation is performed based on the formulae by Bernardo at al., 2000 titled Parental contribution and coefficient of coancestry among maize inbreds: pedigree, RFLP, and SSR data
#'
#' @param result_df The function use as input the output of the function "estimate_common_markers"
#'
#' @return A dataframe with the parental contribution in percentage between the offspring and parent 1 and parent 2
#' @export
#'
#' @examples parental_contribution(results_df)
parental_contribution <- function(result_df) {
  result_df$similarity_son_parent1 <- result_df$Son_Parent1_Common / result_df$Son_Parent1_total
  result_df$similarity_son_parent2 <- result_df$Son_Parent2_Common / result_df$Son_Parent2_total
  result_df$similarity_parent1_parent2 <-  result_df$parent1_parent2_common / result_df$Parent1_Parent2_total

  result_df$contribution_parent1 <- (result_df$similarity_son_parent1 - (result_df$similarity_son_parent2 * result_df$similarity_parent1_parent2)) /
    (1 - (result_df$similarity_parent1_parent2 * result_df$similarity_parent1_parent2))

  result_df$contribution_parent2 <- (result_df$similarity_son_parent2 - (result_df$similarity_son_parent1 * result_df$similarity_parent1_parent2)) /
    (1 - (result_df$similarity_parent1_parent2 * result_df$similarity_parent1_parent2))

  result_df$contribution_sum <- result_df$contribution_parent1 + result_df$contribution_parent2

  return(result_df)
}
