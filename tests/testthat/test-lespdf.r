context("File structure")
library(lespdf)

test_that("Error message", {

  expect_error(lespdf(), "Mangler sti til pdfmappen")
})
