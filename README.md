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

Pakken må først lasteopp i R og funksjon `run_app()` brukes for å aktivere appen.

```r
library(lespdf)
lespdf(pdfmappe, filnavn, valgside)

```
