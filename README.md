<div align="center">

<!-- â–ˆâ–ˆ LIVE APP LINK â€” click to open â–ˆâ–ˆ -->
<a href="https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/" target="_blank">
  <img src="https://img.shields.io/badge/ðŸŒ%20LIVE%20APP%20-%20Click%20to%20Launch-6366f1?style=for-the-badge&logoColor=white&labelColor=0d111e" width="320"/>
</a>

<br/><br/>

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=200&section=header&text=Dynamic%20Reporting%20Tool&fontSize=40&fontColor=fff&animation=twinkling&fontAlignY=38&desc=Real-Time%20Interactive%20Data%20Analytics%20%7C%20R%20Shiny&descAlignY=58&descSize=16&descColor=a5b4fc" width="100%"/>

<!-- Typing animation -->
<img src="https://readme-typing-svg.demolab.com?font=Inter&weight=600&size=20&duration=2500&pause=700&color=6366F1&center=true&vCenter=true&width=650&lines=Real-Time+Interactive+Dashboard;Dynamic+Filtering+%26+Drill-Down;6+Chart+Types+Powered+by+Plotly;Automated+HTML+%2F+PDF+Reports;Premium+Dark+Glassmorphism+UI;Live+on+shinyapps.io" alt="Typing SVG"/>

<br/><br/>

[![Live Demo](https://img.shields.io/badge/LIVE%20DEMO-shinyapps.io-6366f1?style=for-the-badge&logo=r&logoColor=white)](https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/)
[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Abhishek7439/dynamic-reporting-tool)

<br/>

![R](https://img.shields.io/badge/R-4.5.2-276DC3?style=flat-square&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-Framework-00A2FF?style=flat-square&logo=rstudio&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-Interactive-3F4F75?style=flat-square&logo=plotly&logoColor=white)
![DT](https://img.shields.io/badge/DT-Tables-FF6B35?style=flat-square)
![rmarkdown](https://img.shields.io/badge/rmarkdown-Reports-75AADB?style=flat-square)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/Abhishek7439/dynamic-reporting-tool?style=flat-square&color=10b981)
![Stars](https://img.shields.io/github/stars/Abhishek7439/dynamic-reporting-tool?style=flat-square&color=f59e0b)

</div>

---

## Overview

**Dynamic Reporting Tool** is a production-ready, interactive data analytics dashboard built entirely with **R Shiny**. It enables users to explore datasets through real-time filters, generate insightful visualizations across 6 chart types, and export fully customized reports â€” all within a premium deep-space dark themed UI.

> Developed as a **group academic project** for live demonstration and evaluation. Built with a focus on clean architecture, robust error handling, and an impressive user experience.

---

## Screenshots

| Dashboard | Scatter Plot with Trend Line |
|:---------:|:----------------------------:|
| ![Dashboard](screenshots/dashboard.png) | ![Visualizations](screenshots/trend_line.png) |

| Faceted Small-Multiples | Report Export |
|:-----------------------:|:-------------:|
| ![Faceted Charts](screenshots/faceted_charts.png) | ![Report Export](screenshots/report_export.png) |

| Iris Dataset Loaded | About Page |
|:-------------------:|:----------:|
| ![Iris Dataset](screenshots/iris_dataset.png) | ![About](screenshots/about_tab.png) |

---

## Features

### Dashboard
- **4 Live KPI Boxes** â€” Total Rows, Variables, Numeric Variables, Missing Values (update on every filter)
- **Distribution Histogram** â€” Auto-renders for the primary numeric variable
- **Correlation Heatmap** â€” Cyan-to-indigo plotly heatmap for all numeric columns
- **Statistical Summary** â€” Full `R summary()` output in a dark-styled panel
- **Dataset Snapshot** â€” Top 8 rows of the active dataset

### Real-Time Filtering
- **Numeric range sliders** â€” Auto-generated per dataset (up to 3 variables)
- **Multi-select pickers** â€” For categorical columns with live search
- **Apply / Reset** â€” One-click filter application and reset with notification

### Interactive Visualizations (6 Chart Types)

| Chart Type | Description |
|------------|-------------|
| **Scatter Plot** | X vs Y with optional OLS trend line |
| **Bar Chart** | Aggregated mean per category |
| **Box Plot** | IQR, whiskers, and outliers |
| **Histogram** | Frequency distribution |
| **Line Chart** | Ordered connected data points |
| **Violin Plot** | Density + box + mean marker |

- **Color-by-variable** grouping across 8-color neon palette
- **Faceted small-multiples** â€” up to 12 panels per categorical variable
- **Dark chart theme** â€” transparent canvas + Inter typography

### Data Explorer
- Searchable, sortable, paginated **DT table**
- **Column selector** â€” choose which columns to display
- **Sort direction toggle** â€” ascending / descending
- **Export:** CSV, Excel (.xlsx), PDF, Print, Copy

### Automated Report Generation
- **Live preview** panel before download
- **HTML & PDF** output formats
- **Configurable sections** â€” KPI Summary, Data Table, Visualizations, Statistical Analysis
- **Custom title, author name, analysis notes**
- **Pandoc auto-detection** â€” falls back to a self-contained R-only HTML report

### Premium UI/UX
- Deep-space dark theme `#080c14` with **glassmorphism cards**
- Neon accent palette â€” indigo `#6366f1`, cyan `#06b6d4`, emerald `#10b981`
- **Inter** typeface via Google Fonts
- Smooth **fadeUp tab transitions**, hover lift effects on KPI cards
- Custom scrollbar, dark notification toasts, dark disconnected overlay
- Dropdown **z-index fix** â€” no clipping behind sibling cards

---

## Tech Stack

| Package | Role |
|---------|------|
| `shiny` | Core reactive web framework |
| `shinydashboard` | Dashboard layout â€” sidebar, boxes, value boxes |
| `shinyWidgets` | Enhanced widgets (`pickerInput`, `sliderInput`) |
| `plotly` | Interactive, animated charts |
| `dplyr` | Fast, expressive data manipulation |
| `DT` | Interactive JavaScript data tables |
| `ggplot2` | Base plotting support |
| `scales` | Number formatting helpers |
| `openxlsx` | Excel (.xlsx) export |
| `rmarkdown` + `knitr` | Report rendering |
| `htmltools` | Safe HTML construction for fallback reports |

---

## Project Structure

```
Dynamic Reporting Tool/
â”œâ”€â”€ app.R                  # Entry point â€” sources ui.R + server.R
â”œâ”€â”€ ui.R                   # Full dashboard UI + 500+ line premium CSS
â”œâ”€â”€ server.R               # All reactive logic, filtering, charts, export
â”œâ”€â”€ global.R               # Package auto-install + global helpers
â”œâ”€â”€ report_template.Rmd    # Parameterised Rmd template (rmarkdown path)
â”œâ”€â”€ deploy_shinyapps.R     # One-click shinyapps.io deploy script
â”œâ”€â”€ www/
â”‚   â””â”€â”€ report.css         # Styles for generated HTML reports
â””â”€â”€ screenshots/           # README screenshot assets
```

---

## Installation & Setup

### Prerequisites
- **R >= 4.0** â€” [Download from CRAN](https://cran.r-project.org/)
- **RStudio** (recommended) â€” [Download](https://posit.co/download/rstudio-desktop/)

### Run Locally

```r
# 1. Clone the repository
# git clone https://github.com/Abhishek7439/dynamic-reporting-tool.git
# cd dynamic-reporting-tool

# 2. Open in RStudio or run directly
# All packages install automatically on first launch via global.R

# 3. Start the app
shiny::runApp(".", launch.browser = TRUE, port = 3838)
```

Or from terminal / PowerShell:

```powershell
Rscript -e "shiny::runApp('.', launch.browser=TRUE)"
```

### Optional: Enable PDF Reports

```r
tinytex::install_tinytex()   # One-time setup for LaTeX / PDF export
```

---

## Usage Instructions

1. **Select a dataset** from the sidebar dropdown (mtcars, iris, airquality, or upload CSV)
2. **Apply filters** using the auto-generated sliders and multi-select pickers, then click **Apply Filters**
3. Navigate to **Data Explorer** to browse, search, sort, and export the filtered table
4. Go to **Visualizations** â€” choose chart type, X/Y variables, color grouping, and chart theme
5. Toggle **Show Trend Line** on scatter plots or expand **Faceted Small-Multiples**
6. Visit **Report Export** â€” configure title, author, notes, sections, format then click **Generate & Download Report**

---

## Live Demo

> The app is publicly deployed on **shinyapps.io** (free tier)

**[Launch Live Demo](https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/)**

```
https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/
```

---

## Built-in Datasets

| Dataset | Rows | Variables | Description |
|---------|------|-----------|-------------|
| `mtcars` | 32 | 11 | Motor Trend 1974 car road tests |
| `iris` | 150 | 5 | Fisher's iris flower measurements |
| `airquality` | 153 | 6 | NY air quality May-Sep 1973 |
| Upload CSV | Any | Any | Your own custom dataset |

---

## Future Enhancements

- [ ] **User Authentication** â€” `shinymanager` integration for secure login
- [ ] **ML Clustering** â€” K-means or DBSCAN segmentation layer
- [ ] **Predictive Analytics** â€” Linear/logistic regression overlay on charts
- [ ] **Real-Time Data** â€” API-connected live feeds (stock prices, weather)
- [ ] **Multi-Dataset Join** â€” Merge two uploaded CSVs on a common key
- [ ] **Dashboard Themes** â€” Light mode toggle alongside dark glassmorphism
- [ ] **Scheduled Reports** â€” Email-triggered automated PDF delivery

---

## Contributors

| Name | Role |
|------|------|
| **Abhishek** | Lead Developer â€” UI, Server Logic, Deployment |
| **Group Members** | Academic Project Collaborators |

> **Group Academic Project** â€” Dynamic Reporting Tool
> Built for live academic evaluation demonstrating R Shiny capabilities.

---

## License

This project is licensed under the **[MIT License](LICENSE)** â€” free to use, modify, and distribute.

---

## Acknowledgements

- [Posit / RStudio](https://posit.co/) â€” for the incredible R Shiny ecosystem
- [Plotly R](https://plotly.com/r/) â€” for beautiful interactive charts
- [capsule-render](https://github.com/kyechan99/capsule-render) â€” animated banner
- [readme-typing-svg](https://github.com/DenverCoder1/readme-typing-svg) â€” typing animation
- [shields.io](https://shields.io/) â€” badge generation

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=120&section=footer" width="100%"/>

**Live App:** [abhishekkothe.shinyapps.io/dynamic-reporting-tool](https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/)
&nbsp;&bull;&nbsp;
**GitHub:** [Abhishek7439/dynamic-reporting-tool](https://github.com/Abhishek7439/dynamic-reporting-tool)

Made with :heart: using **R + Shiny** &nbsp;|&nbsp; Group Academic Project 2026

</div>
