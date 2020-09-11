#' map_2 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList 
mod_map_traffic_ui <- function(id){
  ns <- NS(id)
  fullPage::pageContainer(
    tags$style(type = "text/css", 
               "strong {font-weight:600;} 
               div.info.legend.leaflet-control {text-align:left; font-family:'Bebas Neue', sans-serif;} 
               div.leaflet-control-layers-expanded {text-align:left;}
               div.leaflet-touch .leaflet-control-attribution {font-family:'Arbutus Slab', serif;}"),
    fluidRow(
      column(2),
      column(
        8,
        shinyWidgets::radioGroupButtons(
          inputId = ns("data"),
          label = "Choose set of bike accidents",
          choices = c("All bike accidents", "Accidents on roads", "Accidents on bicycle infrastructure"),
          checkIcon = list(
            yes = icon("ok",
                       lib = "glyphicon")
          )
        )
      )
    ),
    shinycssloaders::withSpinner(tmapOutput(ns("map"), height = 530)),
    br(),
    pageButtonDown("Curious about the project? Read more about our motivation and methodology!", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:12pt;"),
    h3(class = "source footer",
       "Source: Statistische Ämter des Bundes und der Länder via", tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html", "Unfallatlas"), "• Geoportal Berlin via", tags$a(href="https://data.technologiestiftung-berlin.de/", "Technologiestiftung Berlin"))
  )
}


    
#' map_2 Server Function
#'
#' @noRd 
mod_map_traffic_server <- function(input, output, session){
  ns <- session$ns
  
  traffic_summary_int <- xberlin::traffic_summary
  sf::st_crs(traffic_summary_int) <- 3068 
    
  output$map <- renderTmap({
    
    tm_shape(traffic_summary_int, name = "Ratio Map") + 
      tm_polygons(
        id = "NAME.x", 
        col = "road", 
        title = "Bike Accidents on Bicycle Infrastructures", 
        palette = rev(rcartocolor::carto_pal(n = 5, "ag_Sunset")),
        breaks = c(1, 5, 10, 15, 20, 25, 30, Inf),
        alpha = .75, border.col = "white", 
        legend.reverse = TRUE,
        textNA = "No Accidents in 2019"
        )
  })
  observe({
    if(input$data == "Accidents on roads") { var <- "road" }
    if(input$data == "Accidents on bicycle infrastructure") { var <- "bike" }
    if(input$data == "All bike accidents") { var <- "total" }
    
    tmapProxy("map", session, {
      tm_shape(traffic_summary_int, name = "Ratio Map") +
        tm_polygons(
          id = "NAME.x",
          col = var,
          title = "Number of bike accidents",
          palette = rev(rcartocolor::carto_pal(n = 5, "ag_Sunset")),
          breaks = c(1, 5, 10, 15, 20, 25, 30, Inf),
          alpha = .75, border.col = "white",
          legend.reverse = TRUE,
          textNA = "No Accidents in 2019",
          popup.vars = c("District:" = "Gemeinde_name",
                         "Total number of bike accidents:" = "n_total", 
                         "Accidents on bicycle infrastructure:" = "n_bike", 
                         "Proportion:" = "perc_bike")
        )
    })
  })
}
    
## To be copied in the UI
# mod_map_traffic_ui("map_traffic_ui_1")
    
## To be copied in the server
# callModule(mod_map_traffic_server, "map_traffic_ui_1")
 
