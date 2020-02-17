# lespdf
En løsning for å lese pdf-fil


## Installasjon

For å installere pakken, kan følgende kode kjøres i R:

```r
if (!require("remotes")) install.package("remotes")
remotes::install_github("folkehelseprofil/lespdf", dependencies=TRUE)
```

Hvis installasjon mislykkes bør du starte opp R eller RStudio på nytt og kjør komandoen på nytt.

## Bruk

Pakken må først lasteopp i R og funksjon `lespdf()` brukes for å lese pdf fil(er). Eksample:

```r
library(lespdf)

# spesifiserer mappen til pdf-filer
pdfSti <- "F:\\Prosjekter\\Kommuneprofiler\\PDF_filer\\Kommune\\2019\\Nynorsk"

mydata <- lespdf(pdfSti)

```
