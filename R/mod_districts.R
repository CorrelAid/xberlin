#' districts UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_districts_ui <- function(id){
  ns <- NS(id)
  fullPage::pageContainer(
    pageContainer(
      h2("Participants involved in Accidents with Injuries in Berlin in 2019"),
      br(),
      fluidRow(
        column(
          4,
          shinyWidgets::radioGroupButtons(
            inputId = ns("data"),
            label = "Choose data",
            choices = c("All accidents", "Bike accidents"),
            checkIcon = list(
              yes = icon("ok",
                         lib = "glyphicon")
            )
          )
        ),
        column(
          4,
          uiOutput(ns("types_select_generated"))
        ),
        column(
          4,
          shinyWidgets::radioGroupButtons(
            inputId = ns("chart"),
            label = "Choose chart type",
            choices = c("Dodged bars", "Stacked bars"),
            selected = "Stacked bars",
            checkIcon = list(
              yes = icon("ok",
                         lib = "glyphicon")
            )
          )
        )
      ),
      shinycssloaders::withSpinner(echarts4r::echarts4rOutput(ns("bars"), height = "50vh")),
      br(), br(),
      pageButtonDown("Next: Explore Reported Bike Accidents with Injuries and Bicycle Infrastructures in Berlin", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:1.65vw;"),
      h3(class = "source footer",
         "Source: Statistische Ämter des Bundes und der Länder via", tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html", "Unfallatlas"))
    )
  )
}
    
#' districts Server Function
#'
#' @noRd 
mod_districts_server <- function(input, output, session){
  ns <- session$ns
 
  output$types_select_generated <- renderUI({
    
    selectizeInput(
      ns("types_select"),
      "Choose road user",
      choices = c("Bikes", "Cars", "Motorcycles", "Pedestrians"),
      selected = c("Bikes", "Cars"),
      multiple = TRUE
    )
  })
  
  output$bars <- echarts4r::renderEcharts4r({
    req(input$types_select)
    
    echarts4r::e_common(
      font_family = "Overpass",
      theme = NULL
    )
    
    # var to color mapping
    my_colors <- tibble::tibble(
      type = c("Bikes", "Cars", "Motorcycles", "Pedestrians"),
      color = c("#b03a47", "#293c55", "#6ab0b8", "#e98f6f")
    )
    
    if (input$data == "All accidents") { dat <- xberlin::accidents_sum_all }
    if (input$data == "Bike accidents") { dat <- xberlin::accidents_sum_bikes }
    
    dat <- dat %>% 
      dplyr::filter(type %in% input$types_select) %>%
      dplyr::left_join(my_colors, by = "type")
    
    # requires a group selected
    validate(
      need(length(input$types_select) > 0, message = "Select at least one group")
    )
    
    e <- dat %>%
      group_by(type) %>% 
      echarts4r::e_charts(Gemeinde_name) %>% 
      echarts4r::e_x_axis(axisTick = list(interval = 0), axisLabel = list(rotate = 30), nameGap = 35) %>% 
      echarts4r::e_grid(bottom = 100, left = 150) %>% 
      echarts4r::e_color(unique(dat$color)) %>%  
      echarts4r::e_toolbox(bottom = 0) %>% 
      echarts4r::e_toolbox_feature(feature = "dataZoom") %>% 
      echarts4r::e_toolbox_feature(feature = "dataView")
    
    if (input$chart == "Dodged bars") {
      e %>% echarts4r::e_bar(accidents)
    } else {
      e %>% echarts4r::e_bar(accidents, stack = "grp")
    }
  })
}
    
## To be copied in the UI
# mod_districts_ui("districts_ui_1")
    
## To be copied in the server
# callModule(mod_districts_server, "districts_ui_1")
 
