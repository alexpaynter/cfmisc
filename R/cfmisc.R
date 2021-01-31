#' @title \code{cfmisc} package
#'
#' @description Miscellaneous functions and utilities for Cystic Fibrosis research.
#'
#' @details For a general overview of what this package covers please see
#'   \code{browseVignettes("cfmisc")}
#'
#' @docType package
#' @name cfmisc
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @importFrom rlang :=
NULL

# A questionable fix for having NOTE(s) from R CMD CHECK a about
# not declaring global vars.
# some of these could be avoided by using the data prefix.
utils::globalVariables(c(".", "ah", "last_age", "last_height"))

