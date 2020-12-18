#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import fullPage
#' @import echarts4r
#' @noRd

app_ui <- function(request) {

  options <- list(easing = "linear", scrollingSpeed = 400, keyboardScrolling = TRUE)
  
  options(spinner.color="#11a579", spinner.size = .8, spinner.type = 7)
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    fullPage::pagePiling(
      sections.color = c('#ebebeb', '#f1f1f1', '#dddddd', 
                         '#f1f1f1', '#f1f1f1', '#f1f1f1', '#f1f1f1', 
                         '#3d3d3c', '#cacaca'),
      opts = options,
      menu = c(
        "home" = "home",
        "intro" ="intro",
        "cities" = "cities",
        "districts" = "districts",
        "map_bikes" = "map",
        "types" = "types",
        "map_ratio" = "map2",
        "methods" = "methods",
        "about" = "about"
      ),
      tags$style(type = "text/css", 
                 "#tocMenu li, #tocMenu li.active {display:none;}
                  #tocMenu li a, #tocMenu li.active a {display:none;}"),
      fullPage::pageSectionImage(
        center = TRUE,
        img = "www/Movement_BerlinByBike_shiny.png",
        menu = "home",      
        h1(class = "title top shadow-dark", "Moving Through Berlin By Bike"),
        h2(class = "subtitle shadow-light", "Analysing Accidents and Bicycle", br(), "Infrastructure in Berlin"),
        h3(class = "caption footer", typed::typedOutput("caption"))
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "intro",
        mod_intro_ui("intro")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "cities",
        mod_cities_ui("cities")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "districts",
        mod_districts_ui("districts")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "map_accidents",
        mod_map_accidents_ui("map_accidents")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "types",
        mod_types_ui("types")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "map_traffic",
        mod_map_traffic_ui("map_traffic")
      ),
      fullPage::pageSection(
        center = TRUE,
        menu = "about",
        mod_about_ui("about")
      ),
      fullPage::pageSection(
        center = FALSE,
        menu = "methods",
        mod_methods_ui("methods")
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd

utils::globalVariables(c("datenguide", "name", "year", "accidents_sum_all", 
                         "accidents_sum_bikes", "type", "Gemeinde_name", 
                         "accidents", "risk_map", "bike_lanes", "bike_accidents",
                         "Category", "Opponent_agg", "n")) 

golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "www/css/custom.css"),
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'xberlin'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
