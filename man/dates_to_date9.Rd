% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/date9.R
\name{dates_to_date9}
\alias{dates_to_date9}
\title{Convert all dates to date9 character strings.}
\usage{
dates_to_date9(df, date_time = T)
}
\arguments{
\item{df}{A dataframe or tibble.}

\item{date_time}{Logical.  Convert date-times in addition to dates?}
}
\description{
A convenience function to apply \code{as_date9} to all columns
  in a dataframe where it's appropriate.  Takes a dataframe as input, and
  converts date columns to date9 character strings (see \code{as_date9()}).
  If trans_date_time is true it also converts any POSIXlt or POSIXct columns.
}
\examples{
test_df <- data.frame(a = Sys.Date(), b = Sys.time())
dates_to_date9(test_df)
dates_to_date9(test_df, FALSE)
}
