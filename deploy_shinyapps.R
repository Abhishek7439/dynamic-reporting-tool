# =============================================================================
#  Deploy to shinyapps.io — Dynamic Reporting Tool
#  Run this script ONCE to publish the app for free hosting
# =============================================================================

# Step 1: Install rsconnect if needed
if (!requireNamespace("rsconnect", quietly = TRUE)) {
  install.packages("rsconnect")
}
library(rsconnect)

# Step 2: Authenticate — get your token from:
#   https://www.shinyapps.io/admin/#/tokens
#   Click "Show" then "Copy to clipboard"
# Paste the three values below:

rsconnect::setAccountInfo(
  name   = "YOUR_SHINYAPPS_ACCOUNT_NAME",   # e.g. "abhishek7439"
  token  = "YOUR_TOKEN_HERE",
  secret = "YOUR_SECRET_HERE"
)

# Step 3: Deploy!
rsconnect::deployApp(
  appDir   = "c:/Users/Cloud Automator/Desktop/Dynamic Reporting Tool",
  appName  = "dynamic-reporting-tool",
  appTitle = "Dynamic Reporting Tool",
  forceUpdate = TRUE
)

# Your app will be live at:
#   https://YOUR_ACCOUNT.shinyapps.io/dynamic-reporting-tool
