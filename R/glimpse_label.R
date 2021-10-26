#' @title Glimpse label
#' @description Similar to glimpse from the tibble package, with labels printed
#'   instead of values.
#' @details Labels are a customary part of SAS datasets.  When we use
#'   \code{haven::read_sas()}, these labels are read in and stored as attributes
#'   using \code{labeller}. These are useful in understanding datasets, and with
#'   other packages like \code{gtsummary}, so this function was created to look
#'   at them quickly.
#'
#' @param x A dataframe, hopefully with some label attributes.
#' @param width The character width of the printout.  Default: automatic guess.
#' @param ... Not used.  Copy from glimpse().
#' @export
glimpse_label <- function(x, width = NULL, ...) {
    if (!is.null(width) && !is.finite(width)) {
        abort("`width` must be finite.")
    }
    width <- getOption("width")

    cli::cat_line("Rows: ", formatC(nrow(x)))

    # this is an overestimate, but shouldn't be too expensive.
    # every type needs at least three characters: "x, "
    rows <- as.integer(width / 3)
    df <- df_head(x, rows)
    cli::cat_line("Cols: ", formatC(ncol(x)))

    if (ncol(df) == 0) {
        return(invisible(x))
    }

    var_types <- purrr::map_chr(
        purrr::map(df, new_pillar_type),
        format)
    ticked_names <- format(
        pillar::new_pillar_title(
            pillar:::tick_if_needed(
                names(df)
            )
        )
    )


    var_names <- paste0("$ ", pillar::align(ticked_names),
                        " ", var_types, " ")

    raw_labs <- purrr::map_chr(df, attr, "label")
    var_labs <- raw_labs

    data_width <- width - crayon::col_nchar(var_names) - 1
    truncated <- stringr::str_trunc(var_labs, data_width)

    cli::cat_line(var_names, truncated)

    invisible(x)
}



df_head <- function(x, n) {
    if (!is.data.frame(x)) {
        as.data.frame(head(x, n))
    } else {
        vec_head(as.data.frame(x), n)
    }
}

vec_head <- function(x, n) {
    n <- min(n, vctrs::vec_size(x))
    vctrs::vec_slice(x, seq_len(n))
}

