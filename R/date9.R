#' @title Convert a vector to date9 character string.
#'
#' @description date9 is a SAS format of the form 03APR1997 - two-character
#'   date, then a capitalized 3-character month string, then 4-digit year.  This
#'   function coerces the input to a date (if a date-time or string are input,
#'   for example) using lubridate::as_date(), the it formats the date into a
#'   date9 string.
#' @param x Date, date-time or character vector.
#' @return A character vector in date9 format.
#' @examples
#' as_date9(Sys.Date())
#' as_date9(Sys.time())
#' @export
as_date9 <- function(x) {
    dt <- lubridate::as_date(x)
    dt <- toupper(format(dt, '%d%b%Y'))
    return(dt)
}

#' @title Convert all dates to date9 character strings.
#' @description A convenience function to apply \code{as_date9} to all columns
#'   in a dataframe where it's appropriate.  Takes a dataframe as input, and
#'   converts date columns to date9 character strings (see \code{as_date9()}).
#'   If trans_date_time is true it also converts any POSIXlt or POSIXct columns.
#' @param df A dataframe or tibble.
#' @param date_time Logical.  Convert date-times in addition to dates?
#' @examples
#' test_df <- data.frame(a = Sys.Date(), b = Sys.time())
#' dates_to_date9(test_df)
#' dates_to_date9(test_df, FALSE)
#' @export
dates_to_date9 <- function(df, date_time = T) {
    df %<>% dplyr::mutate(dplyr::across(.cols = where(lubridate::is.Date),
                                        as_date9))
    if (date_time) {
        df %<>% dplyr::mutate(dplyr::across(.cols = where(lubridate::is.POSIXt),
                                            as_date9))
    }
    return(df)
}

