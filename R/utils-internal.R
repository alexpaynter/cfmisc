#' @title Format f
#'
#' @description Format C with format = f - simple wrapper.
#'
#' @param x A numeric value.
#' @param digits The desired number of digits after the decimal point.
#' @examples
#' form_f(293.293893, 2)
#' @export
form_f <- function(x, digits = 0) {
    formatC(x, format = 'f', digits = digits)
}
