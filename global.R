# =============================================================================
#  Dynamic Reporting Tool — global.R
#  Runs once at startup; installs and loads all required packages.
# =============================================================================

required_packages <- c(
  "shiny",
  "shinydashboard",
  "shinyWidgets",
  "dplyr",
  "ggplot2",
  "plotly",
  "DT",
  "scales",
  "openxlsx",
  "rmarkdown",
  "knitr",
  "tools"
)

install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(sprintf("[DRT] Installing missing package: %s", pkg))
    install.packages(pkg, repos = "https://cran.rstudio.com/", quiet = TRUE)
  }
}

invisible(lapply(required_packages, install_if_missing))
invisible(lapply(required_packages, library, character.only = TRUE))

message("[DRT] All packages loaded. Starting Dynamic Reporting Tool …")
