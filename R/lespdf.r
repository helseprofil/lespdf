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
#' @param col Kombinere 2 kolonne til en
#' @param source Create column geo for source data
#' @return Tekster i form av data.table skal bli returneres
#'
#' @import data.table
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @export


lespdf <- function(pdfmappe = NULL,
                   filnavn = NULL,
                   valgside = c(1, 2, 3, 4),
                   col = FALSE,
                   source = FALSE) {
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

    ## get geo name
    geoTxt <- trimws(txtpdf[[1]][1])
    if (col) {
      txtpdf <- merge_col(txtpdf)
    }

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

    if (source) {
      txtpdf2[["geo"]] <- geoTxt
    }
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

## Merge 2 columns into one
## Args:
## char = From starting line to character number to split
## default is from 1 to character number 70 in the line
merge_col <- function(x, char = 70) {
  dt <- list()
  for (i in 1:3) {
    txt <- x[[i]]
    ## Exclude the print number
    txt <- txt[-(length(txt) - 1)]
    nchar <- char + 1
    txt <- c(
      substring(txt, 1, char), # col1
      substring(txt, nchar) # col2
    )

    ## remove blank lines
    txt <- txt[nchar(txt) > 0]

    dt[[i]] <- txt
  }
  ## Page barometer keep as it's
  dt[[4]] <- x[[4]]

  return(dt)
}
