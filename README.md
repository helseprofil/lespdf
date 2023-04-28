# lespdf

 <!-- badges: start -->
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/folkehelseprofil/lespdf?branch=master&svg=true)](https://ci.appveyor.com/project/folkehelseprofil/lespdf)
[![R-CMD-check](https://github.com/helseprofil/lespdf/workflows/R-CMD-check/badge.svg)](https://github.com/helseprofil/lespdf/actions)
[![Codecov test coverage](https://codecov.io/gh/folkehelseprofil/lespdf/branch/master/graph/badge.svg)](https://codecov.io/gh/folkehelseprofil/lespdf?branch=master)
 <!-- badges: end -->

En løsning for å lese pdf-fil  :book:


## Installasjon

For å installere pakken fra GitHub :octocat:, kan følgende kode kjøres i R:

```r
source("https://raw.githubusercontent.com/helseprofil/misc/main/utils.R")
kh_install(lespdf)
```

Hvis installasjon mislykkes bør du starte opp R eller RStudio på nytt og kjør komandoen på nytt. :curly_loop:

## Bruk

Pakken må først lasteopp i R og funksjon `lespdf()` brukes for å lese pdf fil(er). Eksample:

```r
library(lespdf)

# spesifiserer mappen til pdf-filer
pdfSti <- "F:\\Prosjekter\\Kommuneprofiler\\PDF_filer\\Kommune\\2019\\Nynorsk"

# Alle pdf filer i mappen
mydata <- lespdf(pdfSti)

# Spesifisert pdf-filnavn og sider
mypdf <- lespdf(pdfmappe=pdfSti, filnavn="filnavn.pdf", valgside=c(1,4))

# Slå sammen delt kolonne for side 1 til 3
mypdf <- lespdf(pdfmappe=pdfSti, filnavn="filenavn.pdf", col=TRUE)

# Fin duplikater ord 
mydata <- find_duplicate(pdfmappe = pdfSti)
mydata$dup #duplicated text

```
