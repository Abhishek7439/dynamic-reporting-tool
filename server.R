# =============================================================================
#  Dynamic Reporting Tool â€” server.R
#  Authors : Group Academic Project
#  Date    : 2026-03-31
# =============================================================================

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)
library(shinyWidgets)
library(scales)
library(openxlsx)

# â”€â”€ Safe package loader â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
safe_require <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message("Installing: ", pkg)
    install.packages(pkg, repos = "https://cran.rstudio.com/")
  }
  library(pkg, character.only = TRUE)
}

# â”€â”€ Helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
numeric_vars <- function(df) names(df)[sapply(df, is.numeric)]
factor_vars  <- function(df) names(df)[sapply(df, function(x) is.factor(x) || is.character(x))]

# â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
server <- function(input, output, session) {

  # â”€â”€ 1. Reactive: load chosen dataset â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  base_data <- reactive({
    req(input$dataset_choice)
    df <- switch(input$dataset_choice,
      "mtcars"     = {
        d <- mtcars
        d$car_name  <- rownames(mtcars)
        d$cyl       <- factor(d$cyl)
        d$vs        <- factor(d$vs,  labels = c("V-shaped", "Straight"))
        d$am        <- factor(d$am,  labels = c("Automatic", "Manual"))
        d$gear      <- factor(d$gear)
        d$carb      <- factor(d$carb)
        d
      },
      "iris"       = iris,
      "airquality" = {
        d <- airquality
        d$Month <- factor(d$Month,
          labels = c("May","Jun","Jul","Aug","Sep"))
        d
      },
      "upload"     = {
        req(input$csv_upload)
        tryCatch(
          read.csv(input$csv_upload$datapath, stringsAsFactors = TRUE),
          error = function(e) {
            showNotification(paste("CSV Error:", e$message), type = "error")
            NULL
          }
        )
      }
    )
    validate(need(!is.null(df), "Dataset could not be loaded."))
    df
  })

  # â”€â”€ 2. Dynamic sidebar filters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$dynamic_filters <- renderUI({
    df <- base_data()
    req(df)

    num_vars <- numeric_vars(df)
    cat_vars <- factor_vars(df)

    filter_list <- list()

    # Numeric sliders (up to 3)
    for (v in head(num_vars, 3)) {
      rng <- range(df[[v]], na.rm = TRUE)
      filter_list[[paste0("slider_", v)]] <- sliderInput(
        inputId = paste0("filter_num_", v),
        label   = paste("ðŸ“", v),
        min     = floor(rng[1]),
        max     = ceiling(rng[2]),
        value   = c(floor(rng[1]), ceiling(rng[2])),
        step    = round((rng[2] - rng[1]) / 20, 2)
      )
    }

    # Categorical pickers (up to 2)
    for (v in head(cat_vars, 2)) {
      lvls <- levels(factor(df[[v]]))
      filter_list[[paste0("pick_", v)]] <- pickerInput(
        inputId  = paste0("filter_cat_", v),
        label    = paste("ðŸ·", v),
        choices  = lvls,
        selected = lvls,
        multiple = TRUE,
        options  = list(`actions-box` = TRUE, `live-search` = TRUE,
                        `selected-text-format` = "count > 2",
                        `count-selected-text` = "{0} selected")
      )
    }

    do.call(tagList, filter_list)
  })

  # â”€â”€ 3. Reactive: apply filters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  filtered_data <- eventReactive(
    eventExpr = list(input$apply_filters, base_data()),
    ignoreNULL = FALSE, {
      df <- base_data()
      req(df)

      num_vars <- numeric_vars(df)
      cat_vars <- factor_vars(df)

      # Apply numeric sliders
      for (v in head(num_vars, 3)) {
        fid <- paste0("filter_num_", v)
        if (!is.null(input[[fid]])) {
          df <- df[!is.na(df[[v]]) &
                     df[[v]] >= input[[fid]][1] &
                     df[[v]] <= input[[fid]][2], ]
        }
      }

      # Apply categorical pickers
      for (v in head(cat_vars, 2)) {
        fid <- paste0("filter_cat_", v)
        if (!is.null(input[[fid]]) && length(input[[fid]]) > 0) {
          df <- df[as.character(df[[v]]) %in% input[[fid]], ]
        }
      }

      validate(need(nrow(df) > 0, "âš ï¸ No rows match the current filters."))
      df
    }
  )

  # â”€â”€ Reset filters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  observeEvent(input$reset_filters, {
    df <- base_data()
    num_vars <- numeric_vars(df)
    cat_vars <- factor_vars(df)

    for (v in head(num_vars, 3)) {
      rng <- range(df[[v]], na.rm = TRUE)
      updateSliderInput(session, paste0("filter_num_", v),
                        value = c(floor(rng[1]), ceiling(rng[2])))
    }
    for (v in head(cat_vars, 2)) {
      lvls <- levels(factor(df[[v]]))
      updatePickerInput(session, paste0("filter_cat_", v), selected = lvls)
    }
    showNotification("âœ… Filters reset successfully", type = "message", duration = 2)
  })

  # â”€â”€ 4. Update explorer selects â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  observe({
    df <- filtered_data()
    req(df)
    nm <- names(df)
    updateSelectInput(session, "col_select", choices = nm, selected = nm)
    updateSelectInput(session, "sort_col",   choices = nm, selected = nm[1])
  })

  # â”€â”€ 5. Update visualisation selects â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  observe({
    df <- filtered_data()
    req(df)
    nv  <- numeric_vars(df)
    all <- names(df)
    fv  <- factor_vars(df)

    updateSelectInput(session, "x_var",     choices = all, selected = all[1])
    updateSelectInput(session, "y_var",     choices = nv,  selected = nv[min(2, length(nv))])
    updateSelectInput(session, "color_var", choices = c("None" = "none", fv, nv),
                      selected = "none")
    updateSelectInput(session, "facet_var", choices = c("None" = "none", fv),
                      selected = "none")
  })

  # â”€â”€ 6. KPI Value Boxes â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$vbox_rows    <- renderValueBox({
    valueBox(nrow(filtered_data()), "Total Rows", icon = icon("database"),
             color = "blue")
  })
  output$vbox_cols    <- renderValueBox({
    valueBox(ncol(filtered_data()), "Variables", icon = icon("columns"),
             color = "green")
  })
  output$vbox_numeric <- renderValueBox({
    valueBox(length(numeric_vars(filtered_data())), "Numeric Variables",
             icon = icon("hashtag"), color = "yellow")
  })
  output$vbox_missing <- renderValueBox({
    n_miss <- sum(is.na(filtered_data()))
    valueBox(n_miss, "Missing Values", icon = icon("exclamation-triangle"),
             color = if (n_miss == 0) "green" else "red")
  })

  # â”€â”€ 7. Dashboard Distribution Plot â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$dashboard_dist_plot <- renderPlotly({
    df  <- filtered_data()
    nv  <- numeric_vars(df)
    req(length(nv) >= 1)

    v <- nv[1]

    plot_ly(df, x = ~get(v), type = "histogram",
            marker = list(
              color = "rgba(99,102,241,0.85)",
              line  = list(color = "rgba(165,180,252,0.4)", width = 1)
            ),
            name = v) %>%
      layout(
        title  = list(text = paste("Distribution of", v),
                      font = list(color = "#e2e8f0", size = 14, family = "Inter, sans-serif")),
        xaxis  = list(title = v, color = "#94a3b8", gridcolor = "rgba(255,255,255,0.06)", zerolinecolor = "rgba(255,255,255,0.06)"),
        yaxis  = list(title = "Count", color = "#94a3b8", gridcolor = "rgba(255,255,255,0.06)"),
        plot_bgcolor  = "rgba(8,12,20,0)",
        paper_bgcolor = "rgba(8,12,20,0)",
        font          = list(family = "Inter, sans-serif", color = "#94a3b8"),
        margin        = list(t = 50, l = 50)
      )
  })

  # â”€â”€ 8. Dataset Snapshot â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$dashboard_snapshot <- renderTable({
    df <- filtered_data()
    head(df[, head(names(df), 5)], 8)
  }, striped = FALSE, hover = FALSE, bordered = TRUE, digits = 2)

  # â”€â”€ 9. Correlation Heatmap â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$corr_heatmap <- renderPlotly({
    df  <- filtered_data()
    nv  <- numeric_vars(df)
    validate(need(length(nv) >= 2, "Need >= 2 numeric variables for a correlation heatmap."))

    corr_mat <- cor(df[, nv], use = "pairwise.complete.obs")

    # Custom indigo -> dark -> cyan scale
    custom_scale <- list(
      list(0,   "#06b6d4"),
      list(0.5, "#1e1b4b"),
      list(1,   "#6366f1")
    )

    plot_ly(
      x = colnames(corr_mat),
      y = rownames(corr_mat),
      z = corr_mat,
      type        = "heatmap",
      colorscale  = custom_scale,
      zmin = -1, zmax = 1,
      showscale   = TRUE,
      colorbar    = list(tickfont = list(color = "#94a3b8"), title = list(text="r", font=list(color="#94a3b8")))
    ) %>%
      layout(
        title        = list(text = "Correlation Heatmap", font = list(color="#e2e8f0", size=14, family="Inter")),
        xaxis        = list(title = "", color = "#94a3b8", tickfont = list(size=11)),
        yaxis        = list(title = "", color = "#94a3b8", tickfont = list(size=11)),
        plot_bgcolor  = "rgba(8,12,20,0)",
        paper_bgcolor = "rgba(8,12,20,0)",
        font          = list(family = "Inter, sans-serif", color = "#94a3b8")
      )
  })

  # â”€â”€ 10. Statistical Summary â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$summary_output <- renderPrint({
    df <- filtered_data()
    summary(df)
  })

  # â”€â”€ 11. Data Table (Explorer Tab) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$data_table <- renderDT({
    df  <- filtered_data()
    req(df)

    cols <- if (!is.null(input$col_select) && length(input$col_select) > 0)
              input$col_select else names(df)
    df   <- df[, intersect(cols, names(df)), drop = FALSE]

    # Sort
    if (!is.null(input$sort_col) && input$sort_col %in% names(df)) {
      df <- df[order(df[[input$sort_col]],
                     decreasing = (input$sort_dir == "desc")), ]
    }

    datatable(
      df,
      extensions = c("Buttons", "Scroller"),
      options    = list(
        dom        = "Bfrtip",
        buttons    = list("copy", "csv", "excel", "pdf", "print"),
        scrollX    = TRUE,
        scrollY    = "350px",
        scroller   = TRUE,
        pageLength = 20,
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color':'#2196f3','color':'#fff'});",
          "}"
        )
      ),
      rownames = FALSE,
      class    = "cell-border stripe hover"
    )
  })

  # â”€â”€ 12. CSV Download â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$download_csv <- downloadHandler(
    filename = function() paste0("report_data_", Sys.Date(), ".csv"),
    content  = function(file) write.csv(filtered_data(), file, row.names = FALSE)
  )

  # â”€â”€ 13. Excel Download â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$download_xlsx <- downloadHandler(
    filename = function() paste0("report_data_", Sys.Date(), ".xlsx"),
    content  = function(file) {
      wb <- createWorkbook()
      addWorksheet(wb, "Data")
      writeData(wb, "Data", filtered_data())
      addWorksheet(wb, "Summary")
      writeData(wb, "Summary",
                data.frame(capture.output(summary(filtered_data()))))
      saveWorkbook(wb, file, overwrite = TRUE)
    }
  )

  # â”€â”€ 14. Main Interactive Chart â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$main_chart <- renderPlotly({
    df    <- filtered_data()
    xvar  <- req(input$x_var)
    yvar  <- req(input$y_var)
    ctype <- input$chart_type
    theme <- input$chart_theme

    validate(
      need(xvar %in% names(df), "X variable not found in dataset."),
      need(yvar %in% names(df), "Y variable not found in dataset.")
    )

    color_col <- if (input$color_var != "none" && input$color_var %in% names(df))
                   as.character(df[[input$color_var]]) else NULL

    # Neon colour palette for dark theme
    neon_colors <- c("#6366f1","#06b6d4","#10b981","#f59e0b","#ef4444","#a855f7","#ec4899","#84cc16")

    p <- switch(ctype,
      "scatter" = {
        if (!is.null(color_col)) {
          plot_ly(df, x = ~get(xvar), y = ~get(yvar),
                  color = ~color_col, colors = neon_colors,
                  type = "scatter", mode = "markers",
                  marker = list(size = input$point_size * 2, opacity = 0.85))
        } else {
          plot_ly(df, x = ~get(xvar), y = ~get(yvar),
                  type = "scatter", mode = "markers",
                  marker = list(size = input$point_size * 2,
                                color = "rgba(99,102,241,0.85)",
                                line  = list(color="rgba(165,180,252,0.4)", width=1)))
        }
      },
      "bar" = {
        agg <- df %>%
          group_by(across(all_of(xvar))) %>%
          summarise(value = mean(get(yvar), na.rm = TRUE), .groups = "drop")
        plot_ly(agg, x = ~get(xvar), y = ~value, type = "bar",
                marker = list(
                  color = neon_colors[1:nrow(agg)],
                  line  = list(color = "rgba(255,255,255,0.15)", width = 1)
                ))
      },
      "box" = {
        if (!is.null(color_col)) {
          plot_ly(df, x = ~color_col, y = ~get(yvar), type = "box",
                  color = ~color_col, colors = neon_colors)
        } else {
          plot_ly(df, y = ~get(yvar), type = "box",
                  fillcolor = "rgba(99,102,241,0.3)",
                  line = list(color = "#6366f1"),
                  marker = list(color = "#a5b4fc"))
        }
      },
      "histogram" = {
        plot_ly(df, x = ~get(xvar), type = "histogram",
                marker = list(color = "rgba(139,92,246,0.8)",
                              line  = list(color = "rgba(165,180,252,0.4)", width = 1)),
                nbinsx = 25)
      },
      "line" = {
        df_s <- df[order(df[[xvar]]), ]
        if (!is.null(color_col)) {
          plot_ly(df_s, x = ~get(xvar), y = ~get(yvar),
                  color = ~color_col, colors = neon_colors,
                  type = "scatter", mode = "lines+markers")
        } else {
          plot_ly(df_s, x = ~get(xvar), y = ~get(yvar),
                  type = "scatter", mode = "lines+markers",
                  line   = list(color = "#06b6d4", width = 2.5),
                  marker = list(color = "#a5b4fc", size  = input$point_size + 2))
        }
      },
      "violin" = {
        if (!is.null(color_col)) {
          plot_ly(df, x = ~color_col, y = ~get(yvar), type = "violin",
                  color = ~color_col, colors = neon_colors,
                  box      = list(visible = TRUE),
                  meanline = list(visible = TRUE))
        } else {
          plot_ly(df, y = ~get(yvar), type = "violin",
                  fillcolor = "rgba(6,182,212,0.25)",
                  line     = list(color = "#06b6d4"),
                  box      = list(visible = TRUE, fillcolor = "rgba(99,102,241,0.4)"),
                  meanline = list(visible = TRUE, color = "#10b981"))
        }
      }
    )

    dark_axis <- list(
      color      = "#94a3b8",
      gridcolor  = if (input$show_grid) "rgba(255,255,255,0.06)" else "transparent",
      zerolinecolor = "rgba(255,255,255,0.08)"
    )

    p <- p %>% layout(
      xaxis  = c(dark_axis, list(title = list(text=xvar, font=list(color="#94a3b8")))),
      yaxis  = c(dark_axis, list(title = list(text=yvar, font=list(color="#94a3b8")))),
      title  = list(text = paste(tools::toTitleCase(ctype), ":", xvar, "vs", yvar),
                    font = list(color="#e2e8f0", size=14, family="Inter")),
      template      = theme,
      plot_bgcolor  = "rgba(8,12,20,0)",
      paper_bgcolor = "rgba(8,12,20,0)",
      legend        = list(orientation="h", x=0, y=-0.2,
                           font=list(color="#94a3b8", size=11),
                           bgcolor="rgba(0,0,0,0)"),
      font   = list(family = "Inter, sans-serif"),
      margin = list(t=60, l=60, r=20, b=60)
    )

    if (input$show_trend && ctype == "scatter") {
      if (is.numeric(df[[xvar]]) && is.numeric(df[[yvar]])) {
        fit <- lm(reformulate(xvar, yvar), data = df)
        df2 <- df[order(df[[xvar]]), ]
        p   <- p %>% add_lines(
          x    = df2[[xvar]],
          y    = predict(fit, newdata = df2),
          name = "Trend Line",
          line = list(color = "red", dash = "dash"),
          inherit = FALSE
        )
      }
    }
    p
  })

  # â”€â”€ 15. Faceted Chart â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$facet_chart <- renderPlotly({
    df   <- filtered_data()
    xvar <- req(input$x_var)
    yvar <- req(input$y_var)
    fvar <- input$facet_var

    validate(
      need(xvar %in% names(df), "X variable not in dataset."),
      need(yvar %in% names(df), "Y variable not in dataset.")
    )

    if (fvar == "none" || !fvar %in% names(df)) {
      return(plot_ly() %>% layout(
        title = "Select a facet variable above to view small-multiple charts."
      ))
    }

    lvls <- unique(df[[fvar]])
    validate(need(length(lvls) <= 12, "Too many facet levels (max 12). Choose a variable with fewer categories."))

    plots <- lapply(lvls, function(lv) {
      sub <- df[df[[fvar]] == lv, ]
      plot_ly(sub, x = ~get(xvar), y = ~get(yvar),
              type = "scatter", mode = "markers",
              marker = list(size = 6, color = "#6366f1"),
              name  = as.character(lv)) %>%
        layout(
          annotations = list(
            list(text = paste(fvar, "=", lv), showarrow = FALSE,
                 x = 0.5, y = 1.05, xref = "paper", yref = "paper",
                 font = list(size = 11, color = "#94a3b8"))
          ),
          plot_bgcolor  = "rgba(8,12,20,0)",
          paper_bgcolor = "rgba(8,12,20,0)"
        )
    })

    n     <- length(plots)
    ncols <- min(3, n)
    nrows <- ceiling(n / ncols)

    subplot(plots, nrows = nrows, shareX = FALSE, shareY = FALSE,
            titleX = TRUE, titleY = TRUE) %>%
      layout(
        title        = list(text = paste("Faceted by:", fvar),
                            font = list(color = "#e2e8f0", size = 14, family = "Inter")),
        plot_bgcolor  = "rgba(8,12,20,0)",
        paper_bgcolor = "rgba(8,12,20,0)",
        font          = list(family = "Inter, sans-serif", color = "#94a3b8"),
        margin        = list(t = 60)
      )
  })

  # â”€â”€ 16. Report Preview â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  output$report_preview <- renderUI({
    df       <- filtered_data()
    nv       <- numeric_vars(df)
    n_miss   <- sum(is.na(df))
    sections <- input$report_sections

    preview <- tagList(
      tags$h3(input$report_title,
              style = "color:#a5b4fc; border-bottom:2px solid rgba(99,102,241,0.3); padding-bottom:8px;"),
      tags$p(tags$b("Author: "), input$report_author),
      tags$p(tags$b("Date: "),   format(Sys.Date(), "%B %d, %Y")),
      tags$p(tags$b("Dataset: "), input$dataset_choice),
      tags$hr(style = "border-color:rgba(99,102,241,0.2);")
    )

    if ("kpi" %in% sections) {
      preview <- tagList(preview,
        tags$h4("ðŸ“Š KPI Summary", style = "color:#06b6d4;"),
        tags$ul(
          tags$li(paste("Rows:", nrow(df))),
          tags$li(paste("Variables:", ncol(df))),
          tags$li(paste("Numeric Variables:", length(nv))),
          tags$li(paste("Missing Values:", n_miss))
        )
      )
    }

    if ("stats" %in% sections) {
      preview <- tagList(preview,
        tags$h4("ðŸ“‹ Analysis Notes", style = "color:#06b6d4;"),
        tags$p(input$report_notes)
      )
    }

    tagList(preview,
      tags$em(style = "color:#475569;",
              "Full data table and charts will appear in the downloaded report.")
    )
  })

  # â”€â”€ 17. Report Export â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  # Helper: register pandoc from common Windows install locations
  find_and_set_pandoc <- function() {
    if (rmarkdown::pandoc_available()) return(TRUE)

    candidates <- c(
      file.path(Sys.getenv("LOCALAPPDATA"), "Pandoc", "pandoc.exe"),
      "C:/Program Files/Pandoc/pandoc.exe",
      "C:/Program Files (x86)/Pandoc/pandoc.exe",
      file.path(Sys.getenv("APPDATA"), "Pandoc", "pandoc.exe")
    )
    for (p in candidates) {
      if (file.exists(p)) {
        rmarkdown::find_pandoc(dir = dirname(p), cache = FALSE)
        if (rmarkdown::pandoc_available()) {
          message("[DRT] Pandoc found at: ", p)
          return(TRUE)
        }
      }
    }
    return(FALSE)
  }

  # Helper: build a self-contained HTML report without pandoc
  build_html_report <- function(title, author, date_str, dataset_name,
                                notes, df, sections) {
    nv     <- names(df)[sapply(df, is.numeric)]
    n_miss <- sum(is.na(df))

    # â”€â”€ Table rows helper â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    df_html <- function(d, max_rows = 50) {
      d   <- head(d, max_rows)
      hdr <- paste0("<th>", names(d), "</th>", collapse = "")
      rows <- apply(d, 1, function(r) {
        paste0("<tr><td>",
               paste(as.character(r), collapse = "</td><td>"),
               "</td></tr>")
      })
      paste0(
        '<div class="table-wrap"><table>',
        "<thead><tr>", hdr, "</tr></thead>",
        "<tbody>", paste(rows, collapse = ""), "</tbody>",
        "</table></div>"
      )
    }

    # â”€â”€ Summary helper â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    summary_html <- function(d) {
      smry <- capture.output(summary(d))
      paste0('<pre>', paste(smry, collapse = "\n"), '</pre>')
    }

    # â”€â”€ KPI cards â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    kpi_html <- if ("kpi" %in% sections) {
      paste0(
        '<h2>&#128202; KPI Summary</h2>',
        '<div class="kpi-grid">',
        '<div class="kpi-card blue"><div class="kpi-val">', nrow(df), '</div><div class="kpi-lbl">Total Rows</div></div>',
        '<div class="kpi-card green"><div class="kpi-val">', ncol(df), '</div><div class="kpi-lbl">Variables</div></div>',
        '<div class="kpi-card purple"><div class="kpi-val">', length(nv), '</div><div class="kpi-lbl">Numeric Vars</div></div>',
        '<div class="kpi-card ', if (n_miss == 0) "green" else "red", '"><div class="kpi-val">', n_miss, '</div><div class="kpi-lbl">Missing Values</div></div>',
        '</div>'
      )
    } else ""

    stats_html <- if ("stats" %in% sections)
      paste0('<h2>&#128202; Statistical Summary</h2>', summary_html(df))
    else ""

    table_html <- if ("table" %in% sections)
      paste0('<h2>&#128202; Filtered Data <span class="badge">', nrow(df), ' rows</span></h2>',
             df_html(df))
    else ""

    charts_html <- if ("charts" %in% sections)
      '<h2>&#128202; Visualisations</h2><p class="note">Interactive charts are available in the live dashboard at <strong>http://127.0.0.1:3838</strong></p>'
    else ""

    # â”€â”€ Assemble full HTML â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    paste0('<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>', htmltools::htmlEscape(title), '</title>
<style>
  @import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap");
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: Inter, sans-serif; background: #080c14; color: #e2e8f0;
         line-height: 1.6; padding: 0; }
  .hero { background: linear-gradient(135deg,#0d1117 0%,#161b2e 100%);
          border-bottom: 1px solid rgba(99,102,241,.3);
          padding: 40px 60px 36px; }
  .hero h1 { font-size: 28px; font-weight: 800; color: #a5b4fc; margin-bottom: 6px; }
  .meta { font-size: 13px; color: #64748b; display: flex; gap: 24px; flex-wrap: wrap; margin-top: 12px; }
  .meta span { display: flex; align-items: center; gap: 6px; }
  .meta b { color: #94a3b8; }
  main { max-width: 1100px; margin: 0 auto; padding: 40px 32px 80px; }
  h2 { font-size: 17px; font-weight: 700; color: #e2e8f0;
       margin: 40px 0 16px; padding-bottom: 8px;
       border-bottom: 2px solid rgba(99,102,241,.3); }
  .notes-box { background: rgba(99,102,241,.08); border: 1px solid rgba(99,102,241,.2);
               border-left: 4px solid #6366f1; border-radius: 10px;
               padding: 20px 24px; margin-bottom: 8px; color: #cbd5e1; font-size: 14px; }
  /* KPI cards */
  .kpi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px,1fr)); gap: 16px; margin-top: 4px; }
  .kpi-card { border-radius: 14px; padding: 24px 20px; border: 1px solid rgba(255,255,255,.07);
              text-align: center; transition: transform .2s; }
  .kpi-card:hover { transform: translateY(-3px); }
  .kpi-card.blue   { background: linear-gradient(135deg,#3b55e6,#6366f1); }
  .kpi-card.green  { background: linear-gradient(135deg,#059669,#10b981); }
  .kpi-card.purple { background: linear-gradient(135deg,#7c3aed,#a855f7); }
  .kpi-card.red    { background: linear-gradient(135deg,#dc2626,#ef4444); }
  .kpi-val { font-size: 40px; font-weight: 800; color: #fff; letter-spacing: -1px; }
  .kpi-lbl { font-size: 11px; font-weight: 600; color: rgba(255,255,255,.75);
             text-transform: uppercase; letter-spacing: 1px; margin-top: 4px; }
  /* Table */
  .table-wrap { overflow-x: auto; border-radius: 12px; border: 1px solid rgba(99,102,241,.15);
                margin-top: 4px; }
  table { width: 100%; border-collapse: collapse; font-size: 12.5px; }
  thead { background: rgba(99,102,241,.2); }
  thead th { color: #a5b4fc; padding: 11px 14px; text-align: left; font-weight: 600;
             letter-spacing: .4px; border-bottom: 1px solid rgba(99,102,241,.25); }
  tbody tr:nth-child(even) { background: rgba(255,255,255,.02); }
  tbody tr:hover { background: rgba(99,102,241,.08); }
  tbody td { padding: 8px 14px; border-bottom: 1px solid rgba(255,255,255,.04); color: #cbd5e1; }
  /* Pre / code */
  pre { background: rgba(0,0,0,.4); border: 1px solid rgba(99,102,241,.12);
        border-radius: 10px; padding: 16px 20px; font-size: 11.5px; color: #94a3b8;
        font-family: "JetBrains Mono",monospace; overflow-x: auto; margin-top: 4px; }
  .badge { display: inline-block; background: rgba(99,102,241,.2);
           border: 1px solid rgba(99,102,241,.35); color: #a5b4fc;
           border-radius: 20px; padding: 2px 12px; font-size: 12px;
           font-weight: 600; margin-left: 10px; vertical-align: middle; }
  .note { background: rgba(6,182,212,.08); border: 1px solid rgba(6,182,212,.2);
          border-left: 4px solid #06b6d4; border-radius: 10px;
          padding: 16px 20px; color: #94a3b8; font-size: 13.5px; }
  footer { text-align: center; padding: 32px; font-size: 12px; color: #334155;
           border-top: 1px solid rgba(255,255,255,.05); margin-top: 40px; }
</style>
</head>
<body>
<div class="hero">
  <h1>', htmltools::htmlEscape(title), '</h1>
  <div class="meta">
    <span><b>Author:</b> ', htmltools::htmlEscape(author), '</span>
    <span><b>Date:</b> ', date_str, '</span>
    <span><b>Dataset:</b> ', htmltools::htmlEscape(dataset_name), '</span>
    <span><b>Rows (filtered):</b> ', nrow(df), '</span>
  </div>
</div>
<main>
  <h2>&#128203; Analysis Notes</h2>
  <div class="notes-box">', htmltools::htmlEscape(notes), '</div>
  ', kpi_html, '
  ', stats_html, '
  ', table_html, '
  ', charts_html, '
</main>
<footer>Generated by <strong>Dynamic Reporting Tool</strong> &mdash; Group Academic Project &mdash; ', date_str, '</footer>
</body>
</html>')
  }

  output$export_report <- downloadHandler(
    filename = function() {
      ext <- if (input$report_format == "pdf") ".pdf" else ".html"
      paste0("dynamic_report_", Sys.Date(), ext)
    },
    content = function(file) {
      df       <- filtered_data()
      nv       <- numeric_vars(df)
      n_miss   <- sum(is.na(df))
      sections <- input$report_sections

      pandoc_ok <- find_and_set_pandoc()

      # â”€â”€ Try rmarkdown render â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
      if (pandoc_ok) {
        tmpdir   <- tempdir()
        rmd_file <- file.path(tmpdir, paste0("report_", format(Sys.time(), "%H%M%S"), ".Rmd"))

        kpi_md <- if ("kpi" %in% sections) paste0(
          "## KPI Summary\n\n",
          "| Metric | Value |\n|---|---|\n",
          "| Total Rows | ", nrow(df), " |\n",
          "| Variables | ", ncol(df), " |\n",
          "| Numeric Variables | ", length(nv), " |\n",
          "| Missing Values | ", n_miss, " |\n\n"
        ) else ""

        stats_md <- if ("stats" %in% sections) paste0(
          "## Statistical Summary\n\n```\n",
          paste(capture.output(summary(df)), collapse = "\n"),
          "\n```\n\n"
        ) else ""

        table_md <- if ("table" %in% sections) paste0(
          "## Filtered Data (first 50 rows)\n\n",
          knitr::kable(head(df, 50), format = "markdown"), "\n\n"
        ) else ""

        charts_md <- if ("charts" %in% sections)
          "## Visualisations\n\n*Interactive charts are available in the live dashboard.*\n\n"
        else ""

        out_fmt <- if (input$report_format == "pdf") "pdf_document" else
          "html_document"

        rmd_body <- paste0(
          '---\ntitle: "', gsub('"', "'", input$report_title), '"\n',
          'author: "', gsub('"', "'", input$report_author), '"\n',
          'date: "', format(Sys.Date(), "%B %d, %Y"), '"\n',
          'output:\n',
          if (input$report_format == "pdf")
            '  pdf_document:\n    toc: true\n    latex_engine: xelatex\n'
          else
            '  html_document:\n    toc: true\n    toc_float: true\n    theme: flatly\n    highlight: tango\n',
          '---\n\n',
          '## Analysis Notes\n\n', input$report_notes, '\n\n',
          kpi_md, stats_md, table_md, charts_md
        )

        writeLines(rmd_body, rmd_file)

        result <- tryCatch({
          rmarkdown::render(
            rmd_file,
            output_format = out_fmt,
            output_file   = file,
            envir         = new.env(),
            quiet         = TRUE
          )
          "ok"
        }, error = function(e) e$message)

        if (result == "ok") {
          showNotification(
            paste0("âœ… Report generated successfully (", input$report_format, ")"),
            type = "message", duration = 4
          )
          return(invisible(NULL))
        }

        # rmarkdown failed â€” fall through to HTML fallback
        showNotification(
          paste("rmarkdown failed â€” generating HTML instead:", result),
          type = "warning", duration = 6
        )
      }

      # â”€â”€ Pure HTML fallback (no pandoc needed) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
      html_out <- build_html_report(
        title        = input$report_title,
        author       = input$report_author,
        date_str     = format(Sys.Date(), "%B %d, %Y"),
        dataset_name = input$dataset_choice,
        notes        = input$report_notes,
        df           = df,
        sections     = sections
      )

      # Ensure file extension is .html for fallback
      writeLines(html_out, file)

      showNotification(
        "âœ… HTML report downloaded (open in any browser)",
        type = "message", duration = 5
      )
    }
  )

  # â”€â”€ Notify on filter application â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  observeEvent(input$apply_filters, {
    showNotification(
      paste("âœ… Filters applied â€”", nrow(filtered_data()), "rows selected"),
      type = "message", duration = 3
    )
  })

} # /server
