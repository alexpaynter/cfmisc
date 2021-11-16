#' @name rc_crf
#'
#' @aliases clean_crf
#' @aliases read_crf
#'
#' @title Read and cleanup iMedidata CRF data
#' @description CRF datasets from iMedidata Rave have some common, annoying
#'   features when loaded in.  These include (1) all caps variable names (2)
#'   character columns having blanks instead of NA values (3) date-time objects
#'   instead of dates.  This function is a convenience wrapper that fixes these,
#'   and optionally adds a visit number column based on the Folder.
#'
#' @details \code{clean_crf()} works on already-loaded datasets.
#'   \code{read_crf()} loads the dataset using haven given a filepath, then
#'   applies \code{clean_crf()}.
#'
#' @param vn logical - should a visit number be parsed from the \code{folder}
#'   column?
#' @param date logical - should all date-time columns be converted to dates?
#' @examples
#' mtcars %>% clean_crf
#' @rdname rc_crf
NULL


#' @rdname rc_crf
#' @param sas_df A dataframe.
#' @export
clean_crf <- function(sas_df, vn = F, date = T) {
    rtn <- sas_df %>%
        dplyr::rename_all(tolower) %>%
        dplyr::mutate(
            dplyr::across(
                .cols = where(is.character),
                .fns = (function(col) ifelse(col == "", NA, col))
            )
        )

    if (vn) {
        rtn <- rtn %>% dplyr::mutate(visit_num = readr::parse_number(folder))
    }

    if (date) {
        rtn <- rtn %>%
             dplyr::mutate(
                 dplyr::across(
                     .cols = where(lubridate::is.POSIXt),
                     .fns = lubridate::as_date
                 )
             )
    }
    return(rtn)
}

#' @rdname rc_crf
#' @param file File path to a SAS dataset, passed on to haven::read_sas().
#' @export
read_crf <- function(file, vn = F, date = T) {
    rtn <- haven::read_sas(file) %>%
        clean_crf(., vn = vn, date = date)

    return(rtn)
}



