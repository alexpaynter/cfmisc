#' @title Project heights
#'
#' @description Project a vector of heights using the CDC growth charts.
#'
#' @details The motivation for this function is to project previously measured
#'   heights forward in order to have a reasonable guess at a new timepoint.
#'   This explicitly assumes that a person would have grown at a rate which
#'   would place them in the same percentile (or z score), as compared to the
#'   CDC growth charts.
#'
#' @details The advantages of this approach are
#' 1. it requires no data aside from one
#'   previous height measurement, and could be used for individual subjects if
#'   needed, and
#' 2. it is conservative compared to last observation carried
#'   forward (LOCF) if the height is to be used in GLI spirometry equations
#'   later (to calculate ppFEV1, for example).
#'
#' @details On the other hand, LOCF is more conservative in analysis of height
#'   as an outcome, so we strongly recommend its use over this method when
#'   height is the target outcome.  Data-driven imputation methods may have
#'   better performance in cohorts which differ significantly from the CDC's
#'   cohort, or for projecting over large time periods.
#' @md
#' @param sex Sex at birth, "M" for male and "F" for female.
#' @param old_height Height to be projected.
#' @param old_age Age at \code{old_height}.
#' @param new_age Age we're projecting to (where we guess height).
#' @return Returns a numeric vector with height guesses at \code{new_age}.
#' @examples
#' # for a male subject whose height was 152cm at 14 years old and
#' # is missing the height measurement at age 14.6:
#' project_ht(sex = "M", old_height = 152, old_age = 14, new_age = 14.6)
#' @export
project_ht <- function(sex, old_height, old_age, new_age) {
    z_scores <- AGD::y2z(sex = sex,
                         x = old_age,
                         y = old_height,
                         ref = AGD::cdc.hgt)
    new_ht <- AGD::z2y(sex = sex,
                       x = new_age,
                       z = z_scores,
                       ref = AGD::cdc.hgt)
    return(new_ht)
}
