#' Les PDF filer
#'
#'
#' Dette er en forenkle funksjon for å lese pdf-filer spesielt tilpasset til
#' arbeidt med folkeheleprofiler. Funksjonen er avhenging av pdftools pakke
#' \url{https://CRAN.R-project.org/package=pdftools}, stringi
#' \url{https://CRAN.R-project.org/package=stringi} og data.table
#' \url{https://CRAN.R-project.org/package=data.table}
#'
#' @param pdfmappe Spesifiserer mappen til pdf filer
#' @param filnavn Navn til filen hvis ikke alle filen skal leses
#' @param valgside Spesifiserer sidenummer hvis ikke alle sidene skal leses
#' @return Tekster i form av data.table skal bli returneres
#'
#' @import data.table
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @export


lespdf <- function(pdfmappe = NULL, filnavn = NULL, valgside = c(1, 2, 3, 4)) {
  if (is.null(pdfmappe)) {
    stop("Mangler sti til pdfmappen", call. = FALSE)
  }

  if (is.null(filnavn)) {
    filnavn <- list.files(pdfmappe)
  }

  pb <- txtProgressBar(min = 0, max = length(filnavn), style = 3)
  utfil <- list()

  for (x in seq_along(filnavn)) {
    setTxtProgressBar(pb, x)

    txtpdf <- pdftools::pdf_text(paste0(pdfmappe, "\\", filnavn[x]))

    txtpdf <- split_text(txtpdf)

    txtpdf <- lapply(txtpdf, function(x) x[!grepl("^\\s*$", x)])
    txtpdf2 <- data.table::data.table(
      side = rep(
        seq_along(txtpdf),
        sapply(txtpdf, length)
      ),
      rownr = unlist(sapply(txtpdf, function(x) seq_len(length(x)))),
      tekst = unlist(txtpdf)
    )
    txtpdf2[["tekst"]] <- trimws(txtpdf2[["tekst"]])
    utfil[[x]] <- txtpdf2[side %in% valgside, ]
  }

  klarfil <- data.table::rbindlist(utfil)
  cat("\n")
  return(klarfil)
}

## Split should create many lines
## Else the regexp should be spcified accordingly
split_text <- function(x) {
  txt <- stringi::stri_split(x, regex = "\\r\\n")
  txt_length <- length(txt[[1]])

  if (txt_length == 1) {
    txt <- stringi::stri_split(x, regex = "\\n")
  }

  return(txt)
}
