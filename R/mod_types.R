#' types UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_types_ui <- function(id){
ns <- NS(id)
  fullPage::pageContainer(
    pageContainer(
      h2("Bike Accidents in Berlin in 2019 by Bicycle Infrastructure and Opponent"),
      br(),
      fluidRow(
        column(
          1
        ),
        column(
          6,
          uiOutput(ns("opponent_select_generated"))
        ),
        column(
          4,
          shinyWidgets::radioGroupButtons(
            inputId = ns("chart"),
            label = "Choose chart type",
            choices = c("Dodged bars", "Stacked bars"),
            selected = "Dodged bars",
            checkIcon = list(
              yes = icon("ok",
                         lib = "glyphicon")
            )
          )
        )
      ),
      shinycssloaders::withSpinner(echarts4r::echarts4rOutput(ns("bars"), height = "50vh")),
      br(), br(),
      pageButtonDown("Next: Explore areas of high bike accident rates", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:12pt;"),
      h3(class = "source footer",
         "Source: Statistische Ämter des Bundes und der Länder via", tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html", "Unfallatlas"), "• Geoportal Berlin via", tags$a(href="https://data.technologiestiftung-berlin.de/", "Technologiestiftung Berlin"))
    )
  )
}

#' types Server Function
#'
#' @noRd 
mod_types_server <- function(input, output, session){
  ns <- session$ns
  
  output$opponent_select_generated <- renderUI({
    
    selectizeInput(
      ns("opponent_select"),
      "Choose accident opponent",
      choices = c("Bikes", "Cars", "Motorcycles", "Pedestrians"),
      selected = c("Bikes", "Cars", "Motorcycles", "Pedestrians"),
      multiple = TRUE
    )
  })
  
  output$bars <- echarts4r::renderEcharts4r({
    req(input$opponent_select)
    
    echarts4r::e_common(
      font_family = "Overpass",
      theme = NULL
    )
    
    # var to color mapping
    my_colors <- tibble::tibble(
      Opponent_agg = c("Bikes", "Cars", "Motorcycles", "Pedestrians"),
      color = c("#b03a47", "#293c55", "#6ab0b8", "#e98f6f")
    )
    
    dat <- xberlin::bike_accidents %>% 
      sf::st_drop_geometry() %>% 
      dplyr::filter(!is.na(Category)) %>% 
      dplyr::filter(Opponent_agg %in% input$opponent_select) %>%
      dplyr::count(Opponent_agg, Category) %>% 
      dplyr::left_join(my_colors, by = "Opponent_agg")
    
    # requires a group selected
    validate(
      need(length(input$opponent_select) > 0, message = "Select at least group")
    )
    
    e <- dat %>%
      group_by(Opponent_agg) %>% 
      echarts4r::e_charts(Category) %>% 
      echarts4r::e_x_axis(axisTick = list(interval = 0), axisLabel = list(rotate = 30), nameGap = 35) %>% 
      echarts4r::e_grid(bottom = 70) %>% 
      echarts4r::e_color(unique(dat$color)) %>%  
      echarts4r::e_toolbox(bottom = 0) %>% 
      echarts4r::e_toolbox_feature(feature = "dataZoom") %>% 
      echarts4r::e_toolbox_feature(feature = "dataView")
    
    if (input$chart == "Dodged bars") {
      e %>% echarts4r::e_bar(n)
    } else {
      e %>% echarts4r::e_bar(n, stack = "grp")
    }
  })
}

    
## To be copied in the UI
# mod_types_ui("types_ui_1")
    
## To be copied in the server
# callModule(mod_types_server, "types_ui_1")
 
