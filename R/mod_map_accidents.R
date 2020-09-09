#' map _accidents UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList 
#' @import tmap

mod_map_accidents_ui <- function(id){
  ns <- NS(id)
  fullPage::pageContainer(
    tags$style(type = "text/css", 
               "strong {font-weight:600;} 
               div.info.legend.leaflet-control {text-align:left; font-family:'Bebas Neue', sans-serif;} 
               div.leaflet-control-layers-expanded {text-align:left;}
               div.leaflet-touch .leaflet-control-attribution {font-family:'Arbutus Slab', serif;}
               div.span {font-weight: 400;}"),
    shinycssloaders::withSpinner(tmapOutput(ns("map"), height = 600)),
    br(),
    pageButtonDown("Next: Compare Bike Accidents with Injuries in Berlin by Bicycle Infrastructure and Opponent", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:12pt;"),
    h3(class = "source footer",
       "Source: Statistische Ämter des Bundes und der Länder via", tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html", "Unfallatlas"), "• Geoportal Berlin via", tags$a(href="https://data.technologiestiftung-berlin.de/", "Technologiestiftung Berlin"))
  )
}
    
#' map Server Function
#'
#' @noRd 
mod_map_accidents_server <- function(input, output, session){
  ns <- session$ns
  
  output$map <- renderTmap({
    
    sf::st_crs(traffic_cells) <- 3068 
    sf::st_crs(bike_lanes) <- 3068 
    sf::st_crs(bike_accidents) <- 3068 
    
    tm_shape(traffic_cells, name = "Traffic cells") +
      tm_polygons(
        id = "NAME",
        border.col = "#85858533", alpha = 0, 
        popup.vars = c("Traffic cell name:" = "NAME", "Traffic Cell ID:" = "spatial_name",
                      "District:" = "Gemeinde_name", "LOR Area Code:" = "I_LOR_PRR")
      ) +
      tm_shape(bike_lanes, name = "Bicycle infrastructure") +
        tm_lines(
          id = "street", 
          col = "cat", lwd = 1.75, 
          palette = viridis::plasma(5, end = .87),
          title.col = "Bicycle infrastructure:", 
          popup.vars = c("Bicycle infrastructure:" = "cat",  "Obligation of use:" = "mandatory")
        ) +
      tm_shape(bike_accidents, name = "Bike accidents 2019") +
        tm_dots(
          id = "Category",
          size = .03, #col = "grey80",
          col = "Light", palette = viridis::cividis(3, begin = .07, end = .93, direction = -1), border.col = "white",
          title = "Light condition:",
          popup.vars = c("Category:" = "Category", "Opponent:" = "Opponent",
                         "Month:" = "Month", "Weekday:" = "Weekday",
                         "Hour:" = "Hour", "Street condition:" = "Condition")
        )
      ## dots colored by opponent
      # tm_dots(
      #   id = "Category",
      #   size = .02, #col = "grey80", 
      #   col = "Opponent_agg", palette = "viridis",
      #   title = "Opponent:", 
      #   popup.vars = c("Opponent:" = "Opponent", 
      #                  "Month:" = "Month", "Weekday:" = "Weekday", 
      #                  "Hour:" = "Hour", "Light condition:" = "Light",
      #                  "Street condition:" = "Condition") 
      # ) 
    
  })
 
}
    
## To be copied in the UI
# mod_map_accidents_ui("map_accidents_ui_1")
    
## To be copied in the server
# callModule(mod_map_accidents_server, "map_accidents_ui_1")
