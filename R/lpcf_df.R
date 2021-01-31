#' @title Last percentile carried forward (for dataframes)
#'
#' @description This function takes a set of clinical observations and projects
#'    the heights of subjects forward so that their z score stays the same in
#'    the case of missing values.
#'
#' @param dat A dataframe or tibble.  Grouping will be ignored.
#' @param age Unquoted variable name in \code{dat} containing ages (years).
#' @param height Unquoted variable name in \code{dat} containing height (cm).
#' @param sex Unquoted variable name in \code{dat} containing sex at birth ("M" or "F").  Sex at birth should not change for participants.
#' @param group_vars A character vector containing the grouping variable(s) for projection, usually the single column containing subject id's.  In hierarchical studies this could be a vector or grouping variables like c("country", "region", "subject").
#' @param output_name A character vector for the name of the new column containing the projected heights.
#' @return A tibble with a column added for projected height.  Grouping will be dropped and the dataframe will be sorted by grouping vars, then age.
#' @examples
#' test_dat <- data.frame(subject = c("A1","A1","B2","B2"), sex = rep("F", 4),
#'     visit = c(1,2,1,2), visit_age = c(12, 12.4, 14, 14.2),
#'     ht = c(140, NA, 135, NA))
#' lpcf_df(test_dat, age = visit_age, height = ht, sex = sex,
#'         group_vars = "subject")
#' @export
lpcf_df <- function(dat,
                 age,
                 height,
                 sex,
                 group_vars = NULL,
                 output_name = "projected_height") {
    if (tibble::is_tibble(dat) || is.data.frame(dat)) {
        dat <- tibble::as_tibble(dat)
    } else {
        stop("dat must be a tibble or dataframe")
    }
    if (length(output_name) != 1 || !is.character(output_name)) {
        stop("ouptut_name must be a length 1 character variable")
    }
    g_expr <- rlang::parse_expr(group_vars)

    dat %<>% dplyr::group_by(!!rlang::parse_expr(group_vars)) %>%
        dplyr::arrange(!!group_vars, {{ age }})

    dat %<>%
        # put the age and height into one column temporarily:
        dplyr::mutate(ah = dplyr::case_when(
            is.na({{age}}) | is.na({{height}}) ~ NA_character_,
            T ~ paste0({{ age }}, "(sep)", {{ height }})
        ))

    dat %<>%
        tidyr::fill(data = ., ah, .direction = "down") %>%
        # now that we've projected we can re-separate.
        tidyr::separate(data = ., col = ah, into = c("last_age", "last_height"),
                        sep = "\\(sep\\)", remove = T, convert = T,
                        fill = "left")

    dat %<>%
        dplyr::mutate(!!rlang::parse_expr(output_name) := dplyr::case_when(
            is.na({{ age }}) ~ NA_real_, # need current age.
            is.na(last_age) ~ NA_real_, # last_age is NA iff last_height is NA
            !is.na({{ height }}) ~ {{ height }}, # if they had a height, no work to be done.
            T ~ project_ht(sex = {{ sex }},
                           old_age = last_age,
                           old_height = last_height,
                           new_age = {{ age }})
        ))

    dat %<>%
        dplyr::select(-last_height, -last_age) %>%
        dplyr::arrange(!!group_vars, {{ age }}) %>%
        dplyr::ungroup(.) # drop groups

    return(dat)
}
