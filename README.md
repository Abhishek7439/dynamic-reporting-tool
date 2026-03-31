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



## 🚀 Dynamic Reporting Tool

> ⚡ Generate real-time insights with interactive dashboards and dynamic reports using **R Shiny**



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

## 📊 Features

### 📌 Dashboard

* 📦 **4 Live KPI Boxes** — Total Rows, Variables, Numeric Variables, Missing Values (auto-update on filter)
* 📈 **Distribution Histogram** — Auto-renders for selected numeric variable
* 🔥 **Correlation Heatmap** — Interactive plotly heatmap
* 📋 **Statistical Summary** — Full `R summary()` output in styled panel
* 👀 **Dataset Snapshot** — Top 8 rows preview

---

### ⚙️ Real-Time Filtering

* 🎚️ **Numeric range sliders** — Auto-generated filters
* 🔍 **Multi-select pickers** — For categorical data with search
* 🔄 **Apply / Reset Buttons** — One-click filtering with notifications

---

### 📉 Interactive Visualizations (6 Types)

| 📊 Chart Type   | 📖 Description                  |
| --------------- | ------------------------------- |
| 📍 Scatter Plot | X vs Y with optional trend line |
| 📊 Bar Chart    | Aggregated values per category  |
| 📦 Box Plot     | Distribution with outliers      |
| 📉 Histogram    | Frequency distribution          |
| 📈 Line Chart   | Ordered trends                  |
| 🎻 Violin Plot  | Density + distribution          |

* 🎨 Color grouping with neon palette
* 🧩 Faceted small-multiples (up to 12 panels)
* 🌙 Dark theme visualizations

---

### 🧾 Data Explorer

* 🔎 Searchable, sortable **DT table**
* 🧩 Column selector
* 🔄 Sorting toggle
* 📤 Export options: CSV, Excel, PDF, Print, Copy

---

### 📄 Automated Report Generation

* 👁️ Live preview before download
* 📥 Export formats: HTML & PDF
* 🛠️ Configurable sections (KPI, Charts, Tables, Analysis)
* ✍️ Custom title, author, notes
* ⚡ Smart fallback (HTML if PDF not available)

---

### 🎨 Premium UI/UX

* 🌌 Dark theme with glassmorphism design
* 💡 Neon accents (Indigo, Cyan, Emerald)
* 🔤 Inter font for clean typography
* ✨ Smooth animations & hover effects
* 🔔 Toast notifications & polished UI

---

## 🛠️ Tech Stack

| ⚙️ Package       | 📌 Role            |
| ---------------- | ------------------ |
| `shiny`          | Core framework     |
| `shinydashboard` | UI layout          |
| `shinyWidgets`   | Advanced inputs    |
| `plotly`         | Interactive charts |
| `dplyr`          | Data manipulation  |
| `DT`             | Data tables        |
| `ggplot2`        | Visualization      |
| `openxlsx`       | Excel export       |
| `rmarkdown`      | Report generation  |

---

## 📂 Project Structure

```
Dynamic Reporting Tool/
├── app.R
├── ui.R
├── server.R
├── global.R
├── report_template.Rmd
├── deploy_shinyapps.R
├── www/
│   └── report.css
└── screenshots/
```

---

## ⚙️ Installation & Setup

### ✅ Prerequisites

* R ≥ 4.0
* RStudio (recommended)

---

### ▶️ Run Locally

```r
shiny::runApp(".", launch.browser = TRUE, port = 3838)
```

---

### 📄 Enable PDF Reports (Optional)

```r
tinytex::install_tinytex()
```

---

## 🧑‍💻 Usage Instructions

1. 📂 Select dataset (or upload CSV)
2. 🎛️ Apply filters
3. 📊 Explore data in tables
4. 📈 Generate visualizations
5. 📥 Export reports

---

## 🌐 Live Demo

🔗 https://abhishekkothe.shinyapps.io/dynamic-reporting-tool/

---

## 📊 Built-in Datasets

| Dataset      | 📌 Description |
| ------------ | -------------- |
| `mtcars`     | Car data       |
| `iris`       | Flower dataset |
| `airquality` | Air data       |
| CSV Upload   | Custom data    |

---

## 🚀 Future Enhancements

* 🔐 User Authentication
* 🤖 Machine Learning Integration
* 📡 Real-time API data
* 🔗 Multi-dataset joins
* 🌗 Light/Dark toggle
* ⏰ Scheduled reports

---

## 👨‍💻 Contributors

* **Abhishek** — Lead Developer
* 👥 Team Members — Project Contributors

---

## 📜 License

📝 MIT License — Free to use and modify

---

## 🙌 Acknowledgements

* 💙 R Shiny Community
* 📊 Plotly
* 🛠️ Open Source Contributors

---

<div align="center">

⭐ If you like this project, consider giving it a star!

Made with ❤️ using **R + Shiny**

</div>

</div>
