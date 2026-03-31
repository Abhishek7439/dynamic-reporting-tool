# ─────────────────────────────────────────────────────────────────────────────
#  Dynamic Reporting Tool — app.R  (single-file launcher)
#  Use this file if you prefer a single-file structure.
#  It simply sources global.R, ui.R, and server.R then launches the app.
# ─────────────────────────────────────────────────────────────────────────────
library(shiny)

# Source modular files
source("global.R")
source("ui.R")
source("server.R")

# Launch
shinyApp(ui = ui, server = server)
