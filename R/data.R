#' @title VX-445-102 variant list.
#'
#' @description A list used to identify "minimal function" variants for
#'   eligibility in the F508del heterozygous clinical trial of ETI therapy (
#'   doi.org/10.1056/NEJMoa1908639)
#'
#' @format A data frame with 220 rows and 10 variables: \describe{
#'   \item{variant}{The 'mutation' name, which is typically in CF legacy format.}
#'   \item{category}{The full category name as stated on the sheet, e.g.
#'   "Nonsense mutations"}
#'   \item{cat_abbr}{An abbreviated category name for easier typing, e.g. "nonsense"}
#'   }
#' @source
#'   \url{https://www.cff.org/PDF-Archive/Study-VX-445-102-Eligible-Mutations-April-2018.pdf}
#'
"vx_445_102"


#' @title A list of alleles from the United States Prescribing Info which are
#'   responsive to ETI in vitro.
#'
#' @description Prescribing info in the United States was updated to include
#'   alleles which were shown to be responsive to ETI in vitro on December 20,
#'   2020.  The primary importance of this change is FDA-approved eligibility
#'   for subjects with these mutations but zero copies of F508del.
#'
#' @format A character vector with 178 variant names (some are compound alleles).
#' @source See table 4 in
#'   \url{https://www.accessdata.fda.gov/drugsatfda_docs/label/2020/212273s002lbl.pdf}.
#'   If this URL breaks then search "trikafta" in the 'access data FDA' page.
#'
"uspi_2020dec20_invitro"


