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
    ## change setting in both map modules to become active!!!!!!!!!!!!!!!!!!!!!!
    tags$style(type = "text/css",  
               "strong {font-weight:300; font-size:1.1vw;} 
               span {font-weight:300; font-family:'Arbutus Slab', serif; font-size:.9vw;}
               div.info.legend.leaflet-control {text-align:left; font-family:'Bebas Neue', sans-serif; font-weight:300; font-size:.95vw;} 
               div.leaflet-control-layers-expanded {text-align:left; font-size:1.15vw;}
               div.leaflet-touch .leaflet-control-attribution {font-family:'Arbutus Slab', serif; font-size:.8vw;}"),
    shinycssloaders::withSpinner(tmapOutput(ns("map"), height = 600)),
    br(),
    pageButtonDown("Next: Compare Reported Bike Accidents with Injuries by Bicycle Infrastructure and Opponent", style = "color:#2d896e;font-family:'Bebas Neue', serif;font-size:1.65vw;"),
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
    
    traffic_cells_int <- sf::st_as_sf(as.data.frame(xberlin::traffic_cells))
    bike_lanes_int <- sf::st_as_sf(as.data.frame(xberlin::bike_lanes))
    bike_accidents_int <- sf::st_as_sf(as.data.frame(xberlin::bike_accidents))
    
    sf::st_crs(traffic_cells_int) <- 3068 
    sf::st_crs(bike_lanes_int) <- 3068 
    sf::st_crs(bike_accidents_int) <- 3068 
    
    tm_shape(traffic_cells_int, name = "Traffic cells") +
      tm_polygons(
        id = "NAME",
        border.col = "#85858533", alpha = 0, 
        popup.vars = c("Traffic Cell ID:" = "spatial_name",
                      "District:" = "Gemeinde_name", 
                      "LOR Area Code:" = "I_LOR_PRR")
      ) +
      tm_shape(bike_lanes_int, name = "Bicycle infrastructure") +
        tm_lines(
          id = "street", 
          col = "cat", lwd = 1.75, 
          palette = viridis::plasma(5, end = .87),
          title.col = "Bicycle infrastructure:", 
          popup.vars = c("Bicycle infrastructure:" = "cat",  "Obligation of use:" = "mandatory")
        ) +
      tm_shape(bike_accidents_int, name = "Bike accidents 2019") +
        tm_dots(
          id = "Category",
          size = .04, #col = "grey80",
          col = "Light", palette = viridis::cividis(3, begin = .07, end = .93, direction = -1), border.col = "white",
          title = "Light condition:",
          popup.vars = c("Opponent:" = "Opponent",
                         "Month:" = "Month", "Weekday:" = "Weekday",
                         "Hour:" = "Hour", "Street condition:" = "Condition",
                         "Light condition:" = "Light")
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
