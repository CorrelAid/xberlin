#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import fullPage
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  output$caption <- typed::renderTyped({
    #typed::typed(c("Freedom of Fake news^1000", "Freedom of Press Index^500<br>A Visualisation"), typeSpeed = 25, smartBackspace = TRUE)
    typed::typed(c("A contribution to the CorrelAid X Challenge 2020"), typeSpeed = 15)
  })
  
  tmap::tmap_options(basemaps = c(`Light Basemap` = "CartoDB.PositronNoLabels", `Dark Basemap` = "CartoDB.DarkMatterNoLabels", `Colored Basemap` = "CartoDB.VoyagerNoLabels"), 
                     overlays = c(Labels = "CartoDB.PositronOnlyLabels"))
  
  callModule(mod_intro_server, "intro")
  callModule(mod_cities_server, "cities")
  callModule(mod_districts_server, "districts")
  callModule(mod_map_accidents_server, "map_accidents")
  callModule(mod_types_server, "types")
  callModule(mod_map_traffic_server, "map_traffic")
  callModule(mod_about_server, "about")
  callModule(mod_methods_server, "methods")
}
