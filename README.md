<div align="center">

<img src="https://img.shields.io/badge/R-Shiny-276DC3?style=for-the-badge&logo=r&logoColor=white"/>
<img src="https://img.shields.io/badge/Plotly-Interactive_Charts-3F4F75?style=for-the-badge&logo=plotly&logoColor=white"/>
<img src="https://img.shields.io/badge/shinyapps.io-Deployed-00A98F?style=for-the-badge"/>
<img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge"/>

# 📊 Dynamic Reporting Tool

### A production-ready, interactive data analytics & reporting dashboard built with R Shiny

*A group academic project featuring real-time filtering, 6 chart types, automated report generation, and a premium dark glassmorphism UI*

**[🚀 Live Demo →](https://abhishek7439.shinyapps.io/dynamic-reporting-tool)**

---

</div>

## 🖼️ Screenshots

| Dashboard | Visualizations |
|---|---|
| ![Dashboard](screenshots/dashboard.png) | ![Scatter with Trend Line](screenshots/trend_line.png) |

| Faceted Charts | Report Export |
|---|---|
| ![Faceted Small Multiples](screenshots/faceted_charts.png) | ![Report Export](screenshots/report_export.png) |

| Dataset Switching | About |
|---|---|
| ![Iris Dataset](screenshots/iris_dataset.png) | ![About Tab](screenshots/about_tab.png) |

---

## ✨ Features

### 📈 Interactive Dashboard
- **4 live KPI boxes** — Total Rows, Variables, Numeric Variables, Missing Values
- **Distribution Overview** — Auto-rendered histogram for the primary numeric variable
- **Correlation Heatmap** — Cyan-to-indigo custom colour scale using plotly
- **Statistical Summary** — Full R `summary()` output with dark-styled verbatim panel
- **Dataset Snapshot** — Top-8 rows of the active dataset

### 🔍 Real-Time Filtering
- **Numeric sliders** for up to 3 numeric variables (auto-generated per dataset)
- **Multi-select pickers** for up to 2 categorical variables with live search
- **Apply Filters** button with row-count notification
- **Reset** button restores all filters instantly

### 📊 6 Chart Types (Interactive Plotly)
| Chart | Description |
|---|---|
| **Scatter Plot** | X vs Y with optional OLS trend line |
| **Bar Chart** | Aggregated mean per group |
| **Box Plot** | Distribution with IQR + whiskers |
| **Histogram** | Frequency distribution |
| **Line Chart** | Ordered connected points |
| **Violin Plot** | Density + box + mean line |

- **Colour-by-variable** grouping with 8-colour neon palette
- **Faceted small-multiples** (up to 12 panels per categorical variable)
- **Dark chart theme** with transparent backgrounds + Inter typography

### 🗃️ Data Explorer
- **Fully searchable / sortable** DT table with scroller
- **Column selector** — choose which columns to display
- **Sort direction toggle** — ascending/descending
- **Export buttons** — CSV, Excel (.xlsx), PDF, Print, Copy

### 📄 Automated Report Generation
- **Live preview** of the report before download
- **HTML & PDF** output formats
- **Configurable sections** — KPI Summary, Statistical Summary, Data Table, Visualisations
- **Custom title, author, and analysis notes**
- **Pandoc auto-detection** — falls back to a self-contained dark HTML report if Pandoc is unavailable

### 🎨 Premium UI/UX
- **Deep space dark theme** (`#080c14` base) with glassmorphism cards
- **Neon accents** — indigo `#6366f1`, cyan `#06b6d4`, emerald `#10b981`
- **Inter typeface** via Google Fonts
- **Micro-animations** — fadeUp tab transitions, hover lifts on KPI cards
- **Custom scrollbar**, dark notification toasts, dark Shiny disconnected overlay

---

## 📦 Tech Stack

| Package | Purpose |
|---|---|
| `shiny` | Core reactive framework |
| `shinydashboard` | Layout — sidebar, boxes, value boxes |
| `shinyWidgets` | Enhanced UI widgets (pickerInput) |
| `plotly` | Interactive charts |
| `dplyr` | Data manipulation |
| `DT` | Interactive data tables |
| `ggplot2` | Base plotting (ggplot theme helpers) |
| `scales` | Formatting helpers |
| `openxlsx` | Excel export |
| `rmarkdown` + `knitr` | Report rendering |
| `htmltools` | Safe HTML generation for fallback reports |

---

## 🗂️ Project Structure

```
Dynamic Reporting Tool/
├── app.R               # Entry point — sources ui.R + server.R
├── ui.R                # Complete dashboard UI + 500-line premium CSS
├── server.R            # All reactive logic, filtering, charts, export
├── global.R            # Package auto-install + global helpers
├── report_template.Rmd # Parameterised Rmd (optional, for rmarkdown path)
├── www/
│   └── report.css      # CSS for generated HTML reports
└── screenshots/        # README screenshots
```

---

## 🚀 Run Locally

### Prerequisites
- R ≥ 4.0 ([download](https://cran.r-project.org/))
- RStudio (recommended)

### Steps

```r
# 1. Clone the repo
# git clone https://github.com/Abhishek7439/dynamic-reporting-tool.git

# 2. Open R / RStudio in the project directory
# All packages install automatically on first run via global.R

# 3. Run the app
shiny::runApp(".", launch.browser = TRUE, port = 3838)
```

Or from the terminal:
```powershell
Rscript -e "shiny::runApp('.', launch.browser=TRUE)"
```

### Optional: PDF Reports
```r
tinytex::install_tinytex()   # one-time setup for PDF export
```

---

## 🌐 Deploy to shinyapps.io (Free Hosting)

```r
# 1. Install rsconnect
install.packages("rsconnect")

# 2. Authenticate (get token from https://www.shinyapps.io/admin/#/tokens)
rsconnect::setAccountInfo(
  name   = "YOUR_ACCOUNT_NAME",
  token  = "YOUR_TOKEN",
  secret = "YOUR_SECRET"
)

# 3. Deploy
rsconnect::deployApp(
  appDir  = ".",
  appName = "dynamic-reporting-tool"
)
```

---

## 📊 Built-in Datasets

| Dataset | Rows | Variables | Description |
|---|---|---|---|
| `mtcars` | 32 | 11 | Motor Trend 1974 car road tests |
| `iris` | 150 | 5 | Fisher's iris flower measurements |
| `airquality` | 153 | 6 | NY air quality May–Sep 1973 |
| Upload CSV | Any | Any | Your own data source |

---

## 👥 Authors

**Group Academic Project** — Dynamic Reporting Tool
> Built for live academic evaluation demonstrating R Shiny capabilities for interactive data analytics and automated reporting.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">

⭐ **Star this repo if it helped you!** ⭐

Made with ❤️ using R + Shiny

</div>
