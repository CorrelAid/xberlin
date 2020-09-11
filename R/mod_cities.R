#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
mod_cities_ui <- function(id){
  ns <- NS(id)
  fullPage::pageContainer(
    pageContainer(
      h2("Accidents with injuries through time in major German cities"),
      br(),
      fluidRow(
        column(
          6,
          uiOutput(ns("city_select_generated"))
        ),
        column(
          6,
          shinyWidgets::radioGroupButtons(
            inputId = ns("value"),
            label = "Choose a statistic",
            choices = c("per 10,000 inhabitants", "per 10,000 cars", "total"),
            checkIcon = list(
              yes = icon("ok",
                         lib = "glyphicon")
            )
          )
        )
      ),
      shinycssloaders::withSpinner(echarts4r::echarts4rOutput(ns("trend"), height = "50vh")),
      br(), br(),
      pageButtonDown("Next: Who is most frequently involved in accidents with injuries in Berlin?", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:12pt;"),
      h3(class = "source footer",
         "Source: Statistische Ämter des Bundes und der Länder via", tags$a(href="https://datenguidepy.readthedocs.io/en/latest/readme/", code("datenguidepy")))
    )
  )
}
    
#' map Server Function
#'
#' @noRd 
mod_cities_server <- function(input, output, session){
  ns <- session$ns 
 
  output$city_select_generated <- renderUI({
    cns <- xberlin::datenguide %>% 
      dplyr::distinct(name) %>% 
      dplyr::pull(name)
    
    selectizeInput(
      ns("city_select"),
      "Search a city (sorted by population density)",
      choices = cns,
      selected = c("Berlin", "München"),
      multiple = TRUE
    )
  })
  
  output$trend <- echarts4r::renderEcharts4r({
    req(input$city_select)
    
    echarts4r::e_common(
      font_family = "Overpass",
      theme = NULL
    )
    
    # var to color mapping
    my_colors <- tibble::tibble(
      name = c("München", "Berlin", "Stuttgart", "Frankfurt am Main", 
               "Essen", "Düsseldorf", "Köln", "Hamburg", 
               "Dortmund", "Leipzig", "Bremen", "Dresden"),
      color = c("#7F3C8D", "#11A579", "#3969AC", "#F2B701",
                "#E73F74", "#80BA5A", "#E68310", "#008695",
                "#CF1C90", "#F97B72", "#4B4B8F", "#A5AA99")
    )
    
    # requires a city selected
    validate(
      need(length(input$city_select) > 0, message = "Select at least one city")
    )
    
    # filter selected and match with color
    dat <- xberlin::datenguide %>% 
      dplyr::filter(name %in% input$city_select) %>%
      dplyr::left_join(my_colors, by = "name")
    
    ## plot
    dat %>% 
      dplyr::group_by(name) %>% 
      echarts4r::e_charts(year) %>% 
      echarts4r::e_line_(input$value) %>% 
      echarts4r::e_tooltip(trigger = "axis") %>% 
      echarts4r::e_mark_point(input$city_select, data = list(type = "max")) %>% 
      echarts4r::e_legend(type = "scroll") %>% 
      echarts4r::e_color(unique(dat$color)) %>% 
      echarts4r::e_toolbox(bottom = 0) %>% 
      echarts4r::e_toolbox_feature(feature = "dataZoom") %>% 
      echarts4r::e_toolbox_feature(feature = "dataView") 
  })
}
    
## To be copied in the UI
# mod_cities_ui("comp_ui_1")
    
## To be copied in the server
# callModule(mod_cities_server, "comp_ui_1")
