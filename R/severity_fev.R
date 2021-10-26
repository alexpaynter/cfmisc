#' @title Disease severity (Schluchter, 2005)
#' @description Disease severity based on ppFEV1 given age.  Used in cystic fibrosis.
#' @details Severity is a measure of disease aggressiveness based on age and ppFEV.  Essentially the observed ppFEV is compared with quantile-based cutoffs for that age.  This makes severity distinct from stage or condition, which usually just uses ppFEV1 alone (e.g. <40 ppFEV1 is on definition of an advanced stage).
#'
#' Schluchter identifies 'mild' and 'severe' phenotypes.  We label the group between these moderate.
#' Data comes from Schluchter (2006) "Classifying severity...", DOI: 10.1164/rccm.200512-1919OC    Table E1.
#' @param age Subject age in years.
#' @param ppfev Percentage of predicted FEV1 (Schluchster used Knudson eq.)
#' @param type Either "integer_age" or "linear_interpolation" for smooth function.
#' @param factorize T or F - return a factor?
severity_schluchter <- function(age, ppfev, type = "integer_age",
                                factorize = T) {
    stopifnot(type %in% c("integer_age", "linear_interpolation"))

    temp_df <- tibble(a = age, ppfev = ppfev) %>%
        dplyr::mutate(a = if_else(a > 34, 34, a))

    severity_levs <- c("mild", "moderate", "severe")

    temp_df <- temp_df %>%
        dplyr::mutate(
            sev = severity_cutoff_schluchter(age = a, line = "severe", type = type),
            mild = severity_cutoff_schluchter(age = a, line = "mild", type = type)
        ) %>%
        dplyr::mutate(
            grade = dplyr::case_when(
                is.na(ppfev) ~ NA_character_,
                ppfev >= mild ~ severity_levs[1],
                ppfev > sev ~ severity_levs[2],
                ppfev <= sev ~ severity_levs[3],
                T ~ NA_character_
            )
        )

    if (factorize) {
        temp_df[["grade"]] <- factor(temp_df[["grade"]], levels = severity_levs)
    }

    return(temp_df[["grade"]])

}


#' @describeIn severity_schluchter
#' @param line Either "severe" or "mild".
severity_cutoff_schluchter <- function(age,
                                       line = "severe",
                                       type = "integer_age") {
    stopifnot(line %in% c("severe", "mild")) # check type below.

    # making a temporary data frame is slow but easy.
    temp_df <- tibble::tibble(a = age)

    temp_df[["age_lb"]] <- floor(temp_df[["a"]])
    temp_df <- dplyr::left_join(temp_df, sev_tab_merge_schluchter,
                                by = "age_lb", copy = T)

    if (type == "integer_age") {
        temp_df <- temp_df %>%
            dplyr::mutate(out = dplyr::if_else(rep(line == "severe", dplyr::n()),
                                               s0, m0))
    } else if (type == "linear_interpolation") {
        temp_df <- temp_df %>%
            dplyr::mutate(out = dplyr::if_else(
                rep(line == "severe", dplyr::n()),
                (a-age_lb)*((s1-s0)/(age_ub-age_lb)) + s0,
                (a-age_lb)*((m1-m0)/(age_ub-age_lb)) + m0
            ))
    } else {
        stop("type not known ('integer_age' or 'linear_interpolation')")
    }


    return(temp_df[["out"]])
}
