#' @title n percent string
#' @description Creates a string (glue) output, given a numerator vector (n) and
#'   a denominator vector (d).  The percentage and n are always shown, and the
#'   denominator is shown only if show_d = T.
#' @param n Numerator vector (whole numbers only)
#' @param d Denominator vector (whole numbers only)
#' @param show_d T/F - show the denominator in the string?
#' @param digits Digits after the decimal point to show.
#' @param na String to return if n is missing.  If null then the output not
#'   modified.
#' @examples
#' n_pct_str(c(5,6), c(7,7))
#' n_pct_str(c(NA,6), c(7,7), show_d = TRUE, digits = 2, na = "(Missing)")
#' @export
n_pct_str <- function(n, d, show_d = F, digits = 0, na = "") {
    if (any((n %% 1 != 0) | (d %% 1 != 0), na.rm = T)) {
        stop("n, d must be integers (n %% 1 == 0 must be true)")
    }
    if (length(na) > 1) {
        stop("na must be a length 1 vector (or NULL)")
    }

    pct <- n/d
    if (show_d) {
        rtn <- glue::glue("{n}/{d} ({form_f(pct*100, digits = digits)}%)")
    } else {
        rtn <- glue::glue("{n} ({form_f(pct*100, digits = digits)}%)")
    }

    if (!is.null(na)) {
        rtn[is.na(n)] <- glue::glue("{na}")
    }
    return(rtn)
}

#' @title Estimate and (confidence) interval string
#' @description Creates a string representation of 3 numbers:  Point estimate,
#'   lower bound for an interval, upper bound for an interval.  The purpose is
#'   displaying statistical results (prediciton intervals, confidence intervals,
#'   etc).  The default number of digits comes from the NEJM guidelines, which
#'   recommend two digits as a good starting point for association measures
#'   \url{https://www.nejm.org/author-center/new-manuscripts}
#' @param est Estimate, a numeric vector
#' @param lower Lower bound of the interval
#' @param upper Upper bound of the interval
#' @param est_digits Number of digits to round to for the estimate (default =
#'   2).
#' @param ci_digits Number of digits to round to for the CI (lower and upper).
#'   Defaults to est_digits.
#' @param na String to return if estimate is NA (optional - NULL for no action).
#' @param plus_prefix logical.  Add a plus sign to positive estimates?
#' @examples
#' est_int_str(c(1,2), c(3,4), c(5.6, 7.8))
#' est_int_str(c(NA,2), c(3,4), c(5.6, 7.8), est_digits = 0, plus_prefix = TRUE, na = "miss")
#' @export
est_int_str <- function(est, lower, upper,
                        est_digits = 2,
                        ci_digits = est_digits,
                        na = "",
                        plus_prefix = T) {

    est_s <- form_f(est, digits = est_digits)
    lcb_s <- form_f(lower, digits = ci_digits)
    ucb_s <- form_f(upper, digits = ci_digits)

    if (plus_prefix) {
        est_s <- dplyr::if_else(est >= 0,
                                glue::glue("+{est_s}"),
                                glue::glue("{est_s}"),
                                glue::glue("{est_s}"))
    }

    rtn <- glue::glue("{est_s} ({lcb_s}, {ucb_s})")

    if (!is.null(na)) {
        rtn[is.na(est)] <- glue::glue("{na}")
    }
    return(rtn)
}

#' @title NEJM-style P value formatter
#' @description Updated NEJM guildines state: "In general, P values larger than
#'   0.01 should be reported to two decimal places, and those between 0.01 and
#'   0.001 to three decimal places; P values smaller than 0.001 should be
#'   reported as P<0.001."
#'   (\url{https://www.nejm.org/author-center/new-manuscripts})
#' @param p numeric vector, all in [0,1] or NA.
#' @param na String to return if missing.  Empty string is default.
#' @return A character string representing a P value.
#' @examples
#' pval_nejm(c(0.2, 0.000003, NA))
#' @export
pval_nejm <- function(p, na = "") {
    if (any(!is.numeric(p) | p < 0 | p > 1, na.rm = T)) {
        stop("Input p must be a numeric vector between 0 and 1.")
    }

    dplyr::case_when(
        is.na(p) ~ na,
        p >= 0.01 ~ form_f(p, 2),
        p >= 0.001 ~ form_f(p, 3),
        T ~ "<0.001"
    )

}


