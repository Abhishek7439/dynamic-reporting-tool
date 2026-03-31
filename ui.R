# =============================================================================
#  Dynamic Reporting Tool â€” ui.R   (DARK PREMIUM THEME)
#  Authors : Group Academic Project  |  Date: 2026-03-31
# =============================================================================

library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(shinyWidgets)

# â”€â”€ Custom dark CSS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
dark_css <- "
/* â”€â”€ Google Font â”€â”€ */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   BASE
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
*, *::before, *::after { box-sizing: border-box; }

body, .wrapper {
  font-family: 'Inter', 'Segoe UI', sans-serif !important;
  background: #080c14 !important;
  color: #e2e8f0 !important;
  -webkit-font-smoothing: antialiased;
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   SCROLLBAR
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
::-webkit-scrollbar { width:6px; height:6px; }
::-webkit-scrollbar-track { background:#0d1117; }
::-webkit-scrollbar-thumb { background:#6366f1; border-radius:3px; }
::-webkit-scrollbar-thumb:hover { background:#818cf8; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   HEADER / NAVBAR
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.skin-blue .main-header .navbar,
.skin-blue .main-header .logo {
  background: linear-gradient(90deg, #0d1117 0%, #161b2e 100%) !important;
  border-bottom: 1px solid rgba(99,102,241,0.25) !important;
  box-shadow: 0 4px 30px rgba(0,0,0,0.6) !important;
}
.skin-blue .main-header .logo {
  font-size: 15px !important;
  font-weight: 700 !important;
  letter-spacing: 0.3px;
  color: #e2e8f0 !important;
}
.skin-blue .main-header .logo:hover { background: #161b2e !important; }
.skin-blue .main-header .navbar .sidebar-toggle { color: #94a3b8 !important; }
.skin-blue .main-header .navbar .sidebar-toggle:hover { background: rgba(99,102,241,0.15) !important; color:#818cf8 !important; }

/* Dropdown menu in header */
.skin-blue .main-header .navbar .dropdown-menu {
  background: #161b2e !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  border-radius: 12px !important;
  box-shadow: 0 20px 60px rgba(0,0,0,0.6) !important;
}
.skin-blue .main-header .navbar .dropdown-menu > li > a {
  color: #cbd5e1 !important;
  padding: 10px 20px;
}
.skin-blue .main-header .navbar .dropdown-menu > li > a:hover {
  background: rgba(99,102,241,0.15) !important;
  color: #a5b4fc !important;
}
.skin-blue .main-header .navbar .notifications-menu .dropdown-menu a {
  color: #cbd5e1 !important;
  border-bottom: 1px solid rgba(255,255,255,0.05) !important;
}
.skin-blue .main-header .navbar .nav > li > a { color:#94a3b8 !important; }
.skin-blue .main-header .navbar .nav > li > a > .label { background:#6366f1 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   SIDEBAR
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.skin-blue .main-sidebar {
  background: #0d1117 !important;
  border-right: 1px solid rgba(99,102,241,0.12) !important;
  box-shadow: 4px 0 30px rgba(0,0,0,0.5) !important;
}

/* Nav items */
.skin-blue .main-sidebar .sidebar .sidebar-menu > li > a {
  color: #64748b !important;
  font-size: 13px !important;
  font-weight: 500 !important;
  letter-spacing: 0.2px;
  padding: 12px 15px 12px 18px !important;
  border-left: 3px solid transparent !important;
  transition: all 0.2s ease !important;
  border-radius: 0 8px 8px 0;
  margin: 2px 8px 2px 0;
}
.skin-blue .main-sidebar .sidebar .sidebar-menu > li > a:hover {
  background: rgba(99,102,241,0.08) !important;
  color: #a5b4fc !important;
  border-left-color: rgba(99,102,241,0.5) !important;
}
.skin-blue .main-sidebar .sidebar .sidebar-menu > li.active > a {
  background: linear-gradient(90deg, rgba(99,102,241,0.18) 0%, rgba(99,102,241,0.05) 100%) !important;
  color: #a5b4fc !important;
  border-left-color: #6366f1 !important;
  font-weight: 600 !important;
}
.skin-blue .main-sidebar .sidebar .sidebar-menu > li > a > .fa,
.skin-blue .main-sidebar .sidebar .sidebar-menu > li > a > .glyphicon {
  color: inherit !important;
  width: 20px;
}

/* Sidebar section headers */
.sidebar-section-header {
  padding: 16px 18px 6px 18px;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  color: #334155 !important;
}

/* Sidebar form controls */
.sidebar .form-control,
.sidebar .selectize-input,
.sidebar select {
  background: rgba(255,255,255,0.04) !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  color: #cbd5e1 !important;
  border-radius: 8px !important;
  font-size: 12px !important;
}
.sidebar .form-control:focus,
.sidebar .selectize-input.focus {
  border-color: #6366f1 !important;
  box-shadow: 0 0 0 3px rgba(99,102,241,0.15) !important;
}
.sidebar label { color: #94a3b8 !important; font-size: 11.5px !important; font-weight: 500 !important; margin-bottom: 4px !important; }
.sidebar hr { border-color: rgba(255,255,255,0.05) !important; margin: 14px 0 !important; }
.sidebar h5 { color: #475569 !important; font-size: 10px !important; font-weight: 700 !important; letter-spacing: 1.5px !important; text-transform: uppercase !important; }

/* Slider */
.irs-bar, .irs-bar-edge { background: #6366f1 !important; border-color: #6366f1 !important; }
.irs-slider { border-color: #6366f1 !important; background: #818cf8 !important; width:16px !important; height:16px !important; top:20px !important; }
.irs-line { background: rgba(255,255,255,0.08) !important; border-color: transparent !important; }
.irs-min, .irs-max { background: rgba(255,255,255,0.06) !important; color:#64748b !important; border-radius:4px !important; font-size:10px !important; }
.irs-from, .irs-to, .irs-single {
  background: #6366f1 !important; color:#fff !important;
  border-radius:6px !important; font-size:10px !important;
  box-shadow: 0 2px 8px rgba(99,102,241,0.5) !important;
}

/* Bootstrap Select (shinyWidgets picker) */
.bootstrap-select .dropdown-toggle,
.bootstrap-select > .btn {
  background: rgba(255,255,255,0.04) !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  color: #cbd5e1 !important;
  border-radius: 8px !important;
  font-size: 12px !important;
}
.bootstrap-select .dropdown-menu {
  background: #161b2e !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  border-radius: 10px !important;
  box-shadow: 0 20px 60px rgba(0,0,0,0.6) !important;
}
.bootstrap-select .dropdown-menu > li > a { color: #cbd5e1 !important; font-size:12px !important; }
.bootstrap-select .dropdown-menu > li > a:hover,
.bootstrap-select .dropdown-menu > li.selected > a { background: rgba(99,102,241,0.15) !important; color:#a5b4fc !important; }
.bootstrap-select .bs-searchbox .form-control {
  background: rgba(255,255,255,0.06) !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  color: #e2e8f0 !important;
}

/* Action buttons in sidebar */
.btn-drt-primary {
  background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%) !important;
  border: none !important;
  color: #fff !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  padding: 9px 16px !important;
  width: 100% !important;
  cursor: pointer;
  transition: all 0.25s ease !important;
  box-shadow: 0 4px 15px rgba(99,102,241,0.4) !important;
}
.btn-drt-primary:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(99,102,241,0.6) !important; }

.btn-drt-reset {
  background: transparent !important;
  border: 1px solid rgba(239,68,68,0.4) !important;
  color: #f87171 !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  padding: 9px 16px !important;
  width: 100% !important;
  cursor: pointer;
  transition: all 0.25s ease !important;
}
.btn-drt-reset:hover { background: rgba(239,68,68,0.1) !important; border-color: #ef4444 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   CONTENT AREA
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.content-wrapper, .main-footer { background: #080c14 !important; }
.content { padding: 20px !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   VALUE BOXES (KPI Cards)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.small-box {
  border-radius: 16px !important;
  overflow: hidden !important;
  border: 1px solid rgba(255,255,255,0.07) !important;
  box-shadow: 0 8px 32px rgba(0,0,0,0.5) !important;
  transition: transform 0.25s ease, box-shadow 0.25s ease !important;
  backdrop-filter: blur(10px) !important;
}
.small-box:hover {
  transform: translateY(-4px) !important;
  box-shadow: 0 16px 48px rgba(0,0,0,0.7) !important;
}
.small-box h3 { font-size: 38px !important; font-weight: 800 !important; letter-spacing:-1px; margin-bottom:0 !important; }
.small-box p  { font-size: 11px !important; font-weight: 600 !important; letter-spacing: 0.8px; text-transform: uppercase; opacity:0.85; }
.small-box .icon { opacity: 0.12 !important; }
.small-box .icon > i { font-size: 70px !important; }

/* Individual KPI colours */
.bg-blue   { background: linear-gradient(135deg, #3b55e6 0%, #6366f1 100%) !important; }
.bg-green  { background: linear-gradient(135deg, #059669 0%, #10b981 100%) !important; }
.bg-yellow { background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%) !important; }
.bg-red    { background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%) !important; }
.bg-aqua   { background: linear-gradient(135deg, #0e7490 0%, #06b6d4 100%) !important; }
.bg-purple { background: linear-gradient(135deg, #7c3aed 0%, #a855f7 100%) !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   BOXES / CARDS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.box {
  background: rgba(13,17,30,0.92) !important;
  border: 1px solid rgba(99,102,241,0.12) !important;
  border-radius: 16px !important;
  box-shadow: 0 8px 32px rgba(0,0,0,0.4) !important;
  /* NOTE: NO backdrop-filter here â€” it creates a CSS stacking context
     that clips child dropdowns behind sibling boxes. */
  overflow: visible !important;
}
.box-header {
  background: transparent !important;
  border-bottom: 1px solid rgba(99,102,241,0.1) !important;
  border-radius: 16px 16px 0 0 !important;
  padding: 14px 18px !important;
}
.box-header .box-title {
  font-size: 13.5px !important;
  font-weight: 650 !important;
  color: #e2e8f0 !important;
  letter-spacing: 0.1px;
}

/* Box border top accent per status */
.box.box-primary { border-top: 2px solid #6366f1 !important; }
.box.box-success  { border-top: 2px solid #10b981 !important; }
.box.box-warning  { border-top: 2px solid #f59e0b !important; }
.box.box-danger   { border-top: 2px solid #ef4444 !important; }
.box.box-info     { border-top: 2px solid #06b6d4 !important; }

/* Collapsible box toggle */
.box-tools .btn { color: #64748b !important; background: transparent !important; border: none !important; }
.box-tools .btn:hover { color: #a5b4fc !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   TABS (Explorer, Visuals, etc.)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.nav-tabs-custom { background: transparent !important; border: none !important; }
.nav-tabs-custom > .nav-tabs { background: transparent !important; border-bottom: 1px solid rgba(99,102,241,0.15) !important; }
.nav-tabs-custom > .nav-tabs > li > a {
  color: #64748b !important;
  background: transparent !important;
  border: none !important;
  font-size: 12.5px !important;
  font-weight: 500 !important;
  padding: 10px 18px !important;
  transition: color 0.2s !important;
}
.nav-tabs-custom > .nav-tabs > li.active > a,
.nav-tabs-custom > .nav-tabs > li > a:hover { color: #a5b4fc !important; }
.nav-tabs-custom > .nav-tabs > li.active { border-top-color: #6366f1 !important; }
.nav-tabs-custom > .tab-content { background: transparent !important; padding: 12px 0 0 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   DT TABLE
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.dataTables_wrapper { color: #e2e8f0 !important; }
table.dataTable { background: transparent !important; color: #cbd5e1 !important; border-collapse: collapse !important; }
table.dataTable thead th {
  background: rgba(99,102,241,0.2) !important;
  color: #a5b4fc !important;
  border-bottom: 1px solid rgba(99,102,241,0.3) !important;
  font-size: 12px !important;
  font-weight: 600 !important;
  letter-spacing: 0.4px;
  padding: 11px 14px !important;
}
table.dataTable tbody tr { background: transparent !important; }
table.dataTable tbody tr:nth-child(even) { background: rgba(255,255,255,0.02) !important; }
table.dataTable tbody tr:hover { background: rgba(99,102,241,0.08) !important; }
table.dataTable tbody td { border-bottom: 1px solid rgba(255,255,255,0.04) !important; font-size: 12px !important; padding: 9px 14px !important; }
.dataTables_filter input,
.dataTables_length select {
  background: rgba(255,255,255,0.05) !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  color: #e2e8f0 !important;
  border-radius: 8px !important;
  padding: 5px 10px !important;
  font-size: 12px !important;
}
.dataTables_info, .dataTables_paginate { color: #64748b !important; font-size: 12px !important; margin-top: 10px !important; }
.paginate_button { color: #64748b !important; border-radius: 6px !important; padding: 4px 10px !important; }
.paginate_button.current,
.paginate_button:hover {
  background: rgba(99,102,241,0.2) !important;
  color: #a5b4fc !important;
  border: 1px solid rgba(99,102,241,0.3) !important;
}
/* DT Buttons toolbar */
.dt-buttons .btn {
  background: rgba(99,102,241,0.12) !important;
  border: 1px solid rgba(99,102,241,0.25) !important;
  color: #a5b4fc !important;
  border-radius: 7px !important;
  font-size: 11px !important;
  padding: 5px 12px !important;
  margin-right: 4px !important;
  font-weight: 600 !important;
  transition: all 0.2s !important;
}
.dt-buttons .btn:hover { background: rgba(99,102,241,0.25) !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   FORM CONTROLS (main body)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.form-control, .selectize-input {
  background: rgba(255,255,255,0.05) !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  color: #e2e8f0 !important;
  border-radius: 8px !important;
  font-size: 13px !important;
}
.form-control:focus { border-color: #6366f1 !important; box-shadow: 0 0 0 3px rgba(99,102,241,0.2) !important; }
/* â”€â”€ Selectize dropdowns: must float above ALL cards â”€â”€ */
.selectize-dropdown {
  background: #161b2e !important;
  border: 1px solid rgba(99,102,241,0.3) !important;
  border-radius: 10px !important;
  box-shadow: 0 20px 60px rgba(0,0,0,0.8) !important;
  z-index: 9999 !important;   /* above every .box stacking context */
}
.selectize-dropdown-content .option { color: #cbd5e1 !important; font-size:13px !important; }
.selectize-dropdown-content .option:hover,
.selectize-dropdown-content .option.active { background: rgba(99,102,241,0.15) !important; color: #a5b4fc !important; }

/* Bootstrap-select / shinyWidgets picker dropdowns */
.bootstrap-select.open .dropdown-menu,
.open > .dropdown-menu {
  z-index: 9999 !important;
}

/* Standard HTML select rendered by shiny (selectInput) */
.shiny-input-container .selectize-control { position: relative; z-index: auto; }
.shiny-input-container .selectize-control.single .selectize-dropdown { position: absolute; z-index: 9999 !important; }

/* Make row/column containers non-clipping */
.row, .col-sm-3, .col-sm-4, .col-sm-6, .col-sm-8, .col-sm-9, .col-sm-12 {
  overflow: visible !important;
}
.box-body { overflow: visible !important; }
label { color: #94a3b8 !important; font-size: 12.5px !important; font-weight: 500 !important; }
.radio label, .checkbox label { color: #cbd5e1 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   DOWNLOAD / ACTION BUTTONS (body)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.btn-success {
  background: linear-gradient(135deg, #059669, #10b981) !important;
  border: none !important;
  border-radius: 9px !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  box-shadow: 0 4px 15px rgba(16,185,129,0.3) !important;
  transition: all 0.25s !important;
}
.btn-success:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(16,185,129,0.5) !important; }

.btn-info {
  background: linear-gradient(135deg, #0e7490, #06b6d4) !important;
  border: none !important;
  border-radius: 9px !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  box-shadow: 0 4px 15px rgba(6,182,212,0.3) !important;
  transition: all 0.25s !important;
}
.btn-info:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(6,182,212,0.5) !important; }

.btn-primary {
  background: linear-gradient(135deg, #4f46e5, #6366f1) !important;
  border: none !important;
  border-radius: 9px !important;
  font-weight: 600 !important;
  font-size: 12px !important;
  box-shadow: 0 4px 15px rgba(99,102,241,0.4) !important;
  transition: all 0.25s !important;
}
.btn-primary:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(99,102,241,0.6) !important; }

.btn-lg { padding: 12px 24px !important; font-size: 14px !important; }
.btn-block { width: 100% !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   RADIO BUTTONS
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
input[type='radio']:checked { accent-color: #6366f1; }
input[type='checkbox']:checked { accent-color: #6366f1; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   VERBATIM TEXT (summary output)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
pre.shiny-text-output, pre {
  background: rgba(0,0,0,0.35) !important;
  border: 1px solid rgba(99,102,241,0.12) !important;
  color: #94a3b8 !important;
  border-radius: 10px !important;
  font-size: 11px !important;
  padding: 14px !important;
  font-family: 'JetBrains Mono', 'Fira Code', monospace !important;
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   TABLE (snapshot)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.shiny-html-output table {
  color: #cbd5e1 !important;
  font-size: 12px !important;
  border-collapse: collapse !important;
  width: 100% !important;
  background: transparent !important;
}
.shiny-html-output table thead th {
  background: rgba(99,102,241,0.2) !important;
  color: #a5b4fc !important;
  padding: 9px 12px !important;
  border-bottom: 1px solid rgba(99,102,241,0.25) !important;
  font-size: 11px !important;
  font-weight: 600 !important;
  letter-spacing: 0.4px;
}
/* Force ALL tbody rows dark â€” override Bootstrap white default */
.shiny-html-output table tbody tr,
.shiny-html-output table tbody tr td,
.shiny-html-output table.table-striped > tbody > tr:nth-child(odd) > td,
.shiny-html-output table.table-striped > tbody > tr:nth-child(even) > td { 
  background: #0d111e !important; 
  background-color: #0d111e !important;
  color: #cbd5e1 !important;
  padding: 9px 12px !important;
  border-color: rgba(99,102,241,0.12) !important;
}
.shiny-html-output table tbody tr:nth-child(even),
.shiny-html-output table tbody tr:nth-child(even) td { 
  background: #111827 !important; 
  background-color: #111827 !important;
}
.shiny-html-output table tbody tr:hover,
.shiny-html-output table tbody tr:hover td { 
  background: rgba(99,102,241,0.15) !important; 
  background-color: rgba(99,102,241,0.15) !important;
}
.shiny-html-output table tbody td {
  color: #cbd5e1 !important;
  padding: 8px 12px !important;
  border-bottom: 1px solid rgba(255,255,255,0.05) !important;
}
/* Also target Bootstrap's .table-striped which overrides tr bg */
.shiny-html-output .table-striped > tbody > tr:nth-of-type(odd) > * { background-color: #0d111e !important; color: #cbd5e1 !important; }
.shiny-html-output .table-striped > tbody > tr:nth-of-type(even) > * { background-color: #111827 !important; color: #cbd5e1 !important; }
.shiny-html-output .table > tbody > tr > td { background-color: inherit !important; color: #cbd5e1 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   NOTIFICATION
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.shiny-notification {
  background: #161b2e !important;
  border-left: 4px solid #6366f1 !important;
  color: #e2e8f0 !important;
  border-radius: 10px !important;
  box-shadow: 0 8px 30px rgba(0,0,0,0.5) !important;
  font-size: 13px !important;
}
.shiny-notification-message { border-left-color: #10b981 !important; }
.shiny-notification-error   { border-left-color: #ef4444 !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   REPORT PREVIEW card
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.report-preview-card {
  background: rgba(0,0,0,0.3) !important;
  padding: 22px !important;
  border-radius: 12px !important;
  border: 1px solid rgba(99,102,241,0.15) !important;
  min-height: 340px !important;
}
.report-preview-card h3 {
  color: #a5b4fc !important;
  border-bottom: 2px solid rgba(99,102,241,0.3) !important;
  padding-bottom: 10px !important;
  font-size: 18px !important;
  font-weight: 700 !important;
}
.report-preview-card h4 { color: #06b6d4 !important; font-size: 13px !important; font-weight: 600 !important; margin-top: 16px !important; }
.report-preview-card ul { padding-left: 18px !important; }
.report-preview-card ul li { color: #94a3b8 !important; font-size: 12.5px !important; margin-bottom: 4px !important; }
.report-preview-card p, .report-preview-card em { color: #64748b !important; font-size: 12.5px !important; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   GLOW PULSE on chart wrappers
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
@keyframes glowPulse {
  0%, 100% { box-shadow: 0 0 0 rgba(99,102,241,0); }
  50%       { box-shadow: 0 0 20px rgba(99,102,241,0.15); }
}
.plotly-chart-wrapper { animation: glowPulse 4s ease-in-out infinite; }

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   STAT BADGE (inline metric pill)
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.stat-pill {
  display: inline-block;
  background: rgba(99,102,241,0.14);
  border: 1px solid rgba(99,102,241,0.25);
  color: #a5b4fc;
  border-radius: 20px;
  padding: 3px 12px;
  font-size: 11.5px;
  font-weight: 600;
  letter-spacing: 0.3px;
}

/* â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
   MISC FIXES
â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• */
.shiny-progress-indicator { background: #6366f1 !important; }
.shiny-spinner-output-container { background: transparent !important; }
.modal-content {
  background: #161b2e !important;
  border: 1px solid rgba(99,102,241,0.2) !important;
  border-radius: 16px !important;
  color: #e2e8f0 !important;
}
.modal-header { border-bottom: 1px solid rgba(99,102,241,0.1) !important; }
.modal-footer { border-top:  1px solid rgba(99,102,241,0.1) !important; }

/* Keep plotly modebar dark */
.modebar { background: rgba(13,17,30,0.85) !important; border-radius: 8px !important; }
.modebar-btn path { fill: #64748b !important; }
.modebar-btn:hover path { fill: #a5b4fc !important; }

/* â”€â”€ Stacking context safety net â”€â”€ */
.tab-pane, .tab-content { overflow: visible !important; }
.content-wrapper { overflow: visible !important; }
.plotly-chart-wrapper { position: relative; z-index: 1; overflow: hidden; }

/* â”€â”€ Shiny disconnected / grey overlay â”€â”€ */
/* Override the default white/grey reconnecting screen */
#shiny-disconnected-overlay {
  background: rgba(8, 12, 20, 0.92) !important;
  cursor: default !important;
}
.shiny-busy-indicator,
.shiny-progress-container {
  background: transparent !important;
}
/* Reconnecting banner */
.shiny-server-busy {
  color: #6366f1 !important;
  background: rgba(8, 12, 20, 0.95) !important;
  border: 1px solid rgba(99,102,241,0.3) !important;
  border-radius: 12px !important;
  padding: 12px 20px !important;
  font-family: Inter, sans-serif !important;
}
/* Grey overlay that appears on session error */
.shiny-shiny-shiny-shiny-busy { opacity: 0 !important; }
"

# â”€â”€ UI â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
ui <- dashboardPage(
  skin = "blue",

  # â”€â”€ Header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  dashboardHeader(
    title = tags$span(
      tags$span(
        style = "display:inline-flex; align-items:center; gap:8px;",
        tags$span(
          style = paste0(
            "width:28px; height:28px; border-radius:8px;",
            "background:linear-gradient(135deg,#6366f1,#8b5cf6);",
            "display:inline-flex; align-items:center; justify-content:center;",
            "box-shadow:0 4px 12px rgba(99,102,241,0.5);"
          ),
          tags$i(class = "fa fa-chart-bar", style = "color:#fff; font-size:13px;")
        ),
        tags$span("Dynamic Reporting", style = "font-weight:700; font-size:14px; color:#e2e8f0;"),
        tags$span("Tool", style = "font-weight:300; font-size:14px; color:#6366f1;")
      )
    ),
    titleWidth = 270,
    dropdownMenu(
      type        = "notifications",
      badgeStatus = "warning",
      notificationItem(text = "Report ready to export",    icon = icon("file-export"), status = "success"),
      notificationItem(text = "Filters applied",           icon = icon("filter"),      status = "info"),
      notificationItem(text = "New dataset loaded",        icon = icon("database"),    status = "warning")
    )
  ),

  # â”€â”€ Sidebar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  dashboardSidebar(
    width = 255,
    sidebarMenu(
      id = "sidebar_menu",
      tags$div(class = "sidebar-section-header", "Navigation"),
      menuItem("Dashboard",       tabName = "dashboard",  icon = icon("th-large")),
      menuItem("Data Explorer",   tabName = "explorer",   icon = icon("table")),
      menuItem("Visualizations",  tabName = "visuals",    icon = icon("chart-bar")),
      menuItem("Report Export",   tabName = "export",     icon = icon("file-export")),
      menuItem("About",           tabName = "about",      icon = icon("info-circle"))
    ),

    tags$div(
      style = "padding:0 14px;",

      tags$div(class = "sidebar-section-header", "Dataset"),
      selectInput(
        inputId = "dataset_choice",
        label   = NULL,
        choices = c(
          "Motor Trend Cars (mtcars)" = "mtcars",
          "Iris Flowers"              = "iris",
          "Air Quality (NY)"          = "airquality",
          "Upload CSV"                = "upload"
        ),
        selected = "mtcars"
      ),
      conditionalPanel(
        condition = "input.dataset_choice == 'upload'",
        fileInput("csv_upload", NULL, accept = ".csv",
                  buttonLabel = tags$span(icon("upload"), " Browse"),
                  placeholder = "No file selected")
      ),

      tags$div(class = "sidebar-section-header", style="margin-top:8px;", "Filters"),
      uiOutput("dynamic_filters"),

      tags$div(
        style = "margin-top:14px;",
        tags$button(
          id = "apply_filters",
          class = "btn-drt-primary action-button",
          icon("filter"), " Apply Filters"
        ),
        tags$div(style = "height:8px;"),
        tags$button(
          id = "reset_filters",
          class = "btn-drt-reset action-button",
          icon("undo"), " Reset"
        )
      )
    )
  ),

  # â”€â”€ Body â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  dashboardBody(
    tags$head(
      tags$style(HTML(dark_css)),
      tags$style(HTML("
        /* Extra micro-animations */
        @keyframes fadeUp {
          from { opacity:0; transform:translateY(14px); }
          to   { opacity:1; transform:translateY(0); }
        }
        .tab-content > .tab-pane.active { animation: fadeUp 0.35s ease; }
      "))
    ),

    tabItems(

      # ============================================================ #
      #  TAB 1 â€” Dashboard                                           #
      # ============================================================ #
      tabItem(
        tabName = "dashboard",

        # KPI Row
        fluidRow(
          valueBoxOutput("vbox_rows",    width = 3),
          valueBoxOutput("vbox_cols",    width = 3),
          valueBoxOutput("vbox_numeric", width = 3),
          valueBoxOutput("vbox_missing", width = 3)
        ),

        # Chart row 1
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-chart-bar", style="color:#6366f1; margin-right:7px;"),
              "Distribution Overview"
            ),
            status = "primary", solidHeader = FALSE, width = 8, height = 430,
            tags$div(class = "plotly-chart-wrapper",
              plotlyOutput("dashboard_dist_plot", height = "370px")
            )
          ),
          box(
            title = tags$span(
              tags$i(class="fa fa-table", style="color:#06b6d4; margin-right:7px;"),
              "Dataset Snapshot"
            ),
            status = "info", solidHeader = FALSE, width = 4, height = 430,
            tableOutput("dashboard_snapshot")
          )
        ),

        # Chart row 2
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-th", style="color:#10b981; margin-right:7px;"),
              "Correlation Heatmap"
            ),
            status = "success", solidHeader = FALSE, width = 6, height = 420,
            tags$div(class = "plotly-chart-wrapper",
              plotlyOutput("corr_heatmap", height = "355px")
            )
          ),
          box(
            title = tags$span(
              tags$i(class="fa fa-list-alt", style="color:#f59e0b; margin-right:7px;"),
              "Statistical Summary"
            ),
            status = "warning", solidHeader = FALSE, width = 6, height = 420,
            verbatimTextOutput("summary_output")
          )
        )
      ),

      # ============================================================ #
      #  TAB 2 â€” Data Explorer                                       #
      # ============================================================ #
      tabItem(
        tabName = "explorer",
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-search", style="color:#6366f1; margin-right:7px;"),
              "Filtered Data Table"
            ),
            status = "primary", solidHeader = FALSE, width = 12,
            fluidRow(
              column(4,
                selectInput("col_select", "ðŸ“Œ Display Columns",
                            choices = NULL, multiple = TRUE)
              ),
              column(4,
                selectInput("sort_col", "â†• Sort By", choices = NULL)
              ),
              column(4,
                tags$div(style = "padding-top:4px;",
                  radioButtons("sort_dir", "Direction",
                               choices = c("Ascending" = "asc", "Descending" = "desc"),
                               inline = TRUE)
                )
              )
            ),
            tags$div(style = "height:1px; background:rgba(99,102,241,0.1); margin:8px 0 16px;"),
            DTOutput("data_table"),
            tags$div(style = "height:16px;"),
            fluidRow(
              column(6, downloadButton("download_csv",  tags$span(icon("download"), " Download CSV"),  class = "btn btn-success")),
              column(6, downloadButton("download_xlsx", tags$span(icon("file-excel"), " Download Excel"), class = "btn btn-info"))
            )
          )
        )
      ),

      # ============================================================ #
      #  TAB 3 â€” Visualizations                                      #
      # ============================================================ #
      tabItem(
        tabName = "visuals",
        fluidRow(
          # Control panel
          box(
            title = tags$span(
              tags$i(class="fa fa-sliders-h", style="color:#6366f1; margin-right:7px;"),
              "Chart Controls"
            ),
            status = "primary", solidHeader = FALSE, width = 3,
            selectInput("chart_type", "Chart Type",
                        choices = c("Scatter Plot" = "scatter",
                                    "Bar Chart"    = "bar",
                                    "Box Plot"     = "box",
                                    "Histogram"    = "histogram",
                                    "Line Chart"   = "line",
                                    "Violin Plot"  = "violin")),
            selectInput("x_var",     "X-Axis Variable", choices = NULL),
            selectInput("y_var",     "Y-Axis Variable", choices = NULL),
            selectInput("color_var", "Color By",        choices = c("None" = "none")),
            tags$div(style="height:4px;"),
            checkboxInput("show_trend", "Show Trend Line", value = FALSE),
            checkboxInput("show_grid",  "Show Grid Lines", value = TRUE),
            sliderInput("point_size", "Point / Bar Size", min = 1, max = 12, value = 5),
            selectInput("chart_theme", "Chart Theme",
                        choices = c("Dark"       = "plotly_dark",
                                    "Dark Simple"= "simple_white",
                                    "Light"      = "plotly_white",
                                    "Seaborn"    = "seaborn"))
          ),

          # Main chart
          box(
            title = tags$span(
              tags$i(class="fa fa-chart-line", style="color:#10b981; margin-right:7px;"),
              "Interactive Chart"
            ),
            status = "success", solidHeader = FALSE, width = 9, height = 540,
            tags$div(class = "plotly-chart-wrapper",
              plotlyOutput("main_chart", height = "475px")
            )
          )
        ),

        # Faceted
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-border-all", style="color:#f59e0b; margin-right:7px;"),
              "Faceted Small-Multiples"
            ),
            status = "warning", solidHeader = FALSE, width = 12,
            collapsible = TRUE, collapsed = TRUE,
            fluidRow(
              column(4,
                selectInput("facet_var", "Facet By Variable",
                            choices = c("None" = "none"), width = "100%")
              )
            ),
            tags$div(class = "plotly-chart-wrapper",
              plotlyOutput("facet_chart", height = "400px")
            )
          )
        )
      ),

      # ============================================================ #
      #  TAB 4 â€” Report Export                                       #
      # ============================================================ #
      tabItem(
        tabName = "export",
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-file-alt", style="color:#6366f1; margin-right:7px;"),
              "Configure Report"
            ),
            status = "primary", solidHeader = FALSE, width = 6,
            textInput("report_title",  "Report Title",  value = "Dynamic Report â€” Analysis Summary"),
            textInput("report_author", "Author Name",   value = "Group Academic Project"),
            textAreaInput("report_notes", "Analysis Notes",
                          value = "This report was generated using the Dynamic Reporting Tool built with R Shiny.",
                          rows = 4),
            tags$div(style="height:4px;"),
            checkboxGroupInput("report_sections", "Include Sections",
                               choices  = c("KPI Summary"        = "kpi",
                                            "Data Table"         = "table",
                                            "Visualizations"     = "charts",
                                            "Statistical Summary" = "stats"),
                               selected = c("kpi","table","charts","stats")),
            selectInput("report_format", "Export Format",
                        choices = c("HTML Report" = "html", "PDF Report" = "pdf")),
            tags$div(style="height:12px;"),
            downloadButton("export_report",
                           tags$span(icon("rocket"), " Generate & Download Report"),
                           class = "btn btn-primary btn-lg btn-block")
          ),

          box(
            title = tags$span(
              tags$i(class="fa fa-eye", style="color:#06b6d4; margin-right:7px;"),
              "Live Preview"
            ),
            status = "info", solidHeader = FALSE, width = 6,
            tags$div(class = "report-preview-card",
              uiOutput("report_preview")
            )
          )
        )
      ),

      # ============================================================ #
      #  TAB 5 â€” About                                               #
      # ============================================================ #
      tabItem(
        tabName = "about",
        fluidRow(
          box(
            title = tags$span(
              tags$i(class="fa fa-info-circle", style="color:#6366f1; margin-right:7px;"),
              "About This Application"
            ),
            status = "primary", solidHeader = FALSE, width = 12,
            tags$div(
              style = "padding: 8px 4px;",

              # Hero section
              tags$div(
                style = paste0(
                  "background:linear-gradient(135deg,rgba(99,102,241,0.12) 0%,rgba(139,92,246,0.08) 100%);",
                  "border:1px solid rgba(99,102,241,0.2); border-radius:14px; padding:28px 32px; margin-bottom:24px;"
                ),
                tags$h2("Dynamic Reporting Tool",
                  style="color:#a5b4fc; font-weight:800; font-size:26px; margin:0 0 8px;"),
                tags$p("A group academic project built using R Shiny for interactive data exploration,",
                       " dynamic filtering, and automated report generation.",
                  style="color:#94a3b8; font-size:14px; margin:0;")
              ),

              fluidRow(
                column(6,
                  tags$h4("ðŸ›  Technology Stack",
                    style="color:#e2e8f0; font-weight:700; font-size:14px; margin-bottom:12px;"),
                  tags$div(
                    lapply(
                      list(
                        list("R + Shiny",         "#6366f1", "Core framework"),
                        list("shinydashboard",     "#8b5cf6", "Dashboard layout"),
                        list("plotly",             "#06b6d4", "Interactive charts"),
                        list("DT",                 "#10b981", "Interactive tables"),
                        list("dplyr",              "#f59e0b", "Data manipulation"),
                        list("rmarkdown",          "#ef4444", "Report generation"),
                        list("openxlsx",           "#06b6d4", "Excel export"),
                        list("shinyWidgets",       "#a855f7", "Enhanced UI controls")
                      ),
                      function(item) {
                        tags$div(
                          style = "display:flex; align-items:center; gap:10px; padding:8px 0; border-bottom:1px solid rgba(255,255,255,0.04);",
                          tags$span(
                            style = paste0("width:8px; height:8px; border-radius:50%; background:", item[[2]], "; flex-shrink:0;")
                          ),
                          tags$span(item[[1]], style = "color:#e2e8f0; font-weight:600; font-size:13px; min-width:140px;"),
                          tags$span(item[[3]], style = "color:#64748b; font-size:12px;")
                        )
                      }
                    )
                  )
                ),
                column(6,
                  tags$h4("âœ¨ Key Features",
                    style="color:#e2e8f0; font-weight:700; font-size:14px; margin-bottom:12px;"),
                  tags$div(
                    lapply(
                      list(
                        "Real-time filtering via sidebar controls",
                        "KPI value boxes with live metric counts",
                        "Correlation heatmap for numeric variables",
                        "6 chart types: Scatter, Bar, Box, Histogram, Line, Violin",
                        "Colour-by-variable & OLS trend line overlays",
                        "Faceted small-multiple chart panels",
                        "Sortable, searchable DT data table",
                        "CSV, Excel, HTML & PDF data/report export"
                      ),
                      function(feat) {
                        tags$div(
                          style = "display:flex; align-items:flex-start; gap:10px; padding:7px 0; border-bottom:1px solid rgba(255,255,255,0.04);",
                          tags$span(icon("check-circle"), style="color:#10b981; flex-shrink:0; margin-top:1px;"),
                          tags$span(feat, style="color:#94a3b8; font-size:13px;")
                        )
                      }
                    )
                  )
                )
              ),

              tags$div(style="height:20px;"),
              tags$h4("ðŸ“¦ Built-in Datasets",
                style="color:#e2e8f0; font-weight:700; font-size:14px; margin-bottom:12px;"),
              fluidRow(
                lapply(
                  list(
                    list("mtcars",     "#6366f1", "32 obs",  "11 vars", "Motor Trend 1974 car tests"),
                    list("iris",       "#10b981", "150 obs", "5 vars",  "Fisher's flower measurements"),
                    list("airquality", "#06b6d4", "153 obs", "6 vars",  "NY air quality Mayâ€“Sep 1973"),
                    list("Upload CSV", "#f59e0b", "Any",     "Any",     "Your own data source")
                  ),
                  function(d) {
                    column(3,
                      tags$div(
                        style = paste0(
                          "background:rgba(255,255,255,0.03); border:1px solid rgba(99,102,241,0.15);",
                          "border-top:2px solid ", d[[2]], ";",
                          "border-radius:12px; padding:16px; text-align:center;"
                        ),
                        tags$div(d[[1]], style=paste0("color:", d[[2]], "; font-weight:700; font-size:14px; margin-bottom:8px;")),
                        tags$div(
                          style="display:flex; justify-content:center; gap:8px; margin-bottom:8px;",
                          tags$span(class="stat-pill", d[[3]]),
                          tags$span(class="stat-pill", d[[4]])
                        ),
                        tags$div(d[[5]], style="color:#64748b; font-size:11.5px;")
                      )
                    )
                  }
                )
              )
            )
          )
        )
      )

    ) # /tabItems
  ) # /dashboardBody
) # /dashboardPage
