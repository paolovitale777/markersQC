#' Count common SNPs
#'
#'Count the common SNPs between two vectors (offspring and parent 1 or parent 2)
#'
#' @param vec1 SNPs offspring
#' @param vec2 SNPs parent 1 or parent 2
#'
#' @return common elements
#' @export
#'
#' @examples no example
count_common_elements <- function(vec1, vec2) {
  vec1_filtered <- vec1[vec1 != "N"]
  vec2_filtered <- vec2[vec2 != "N"]
  common_elements <- sum(vec1_filtered %in% vec2_filtered)
  return(common_elements)
}
