#' Find duplicated text
#'
#' Find possible duplicated text for control
#'
#' @param ... Additional parameters for lespdf function
#' @inheritParams lespdf
#' @return A list containing data and dup (duplicate texts) with line index for reference
#' @import data.table
#' @export

find_duplicate <- function(pdfmappe = NULL,
                           filnavn = NULL,
                           col = FALSE,
                           source = TRUE,
                           ...) {
  dt <- lespdf(
    pdfmappe = pdfmappe,
    filnavn = filnavn,
    col = col,
    source = source,
    ...
  )

  dt[, ind := .I]
  dupDT <- dt[side != 4, .(id = fifelse(grepl("\\b(\\w+)\\s+\\1\\b", tekst, perl = TRUE), ind, 0)), by = geo]
  indx <- dupDT[id != 0, c(id)]
  dup <- dt[ind %in% indx, ]

  return(list(data = dt, dup = dup))
}
