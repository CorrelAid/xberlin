#' mod_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_about_ui <- function(id){
  ns <- NS(id)
  fullPage::pageContainer(
    h1(class = "header shadow-dark", "About the Project"),
    p(""),
    p(class = "about",
      "A Shiny app created with", emo::ji('coffee'), "and", emo::ji('heart'), "for the CorrelAidX Challenge 2020", 
      br(),
      em("“Analysing and visualising German regional statistics with datenguidepy”"),
      br(),
      "by Cédric Scherer, Andreas Neumann, Saleh Hamed & Steffen Reinhold"),
    br(),
    img(src = 'www/CorrelAid_X-Icon_dark_grey.png', align = "center", height = 120, width = 120),
    img(src = 'www/CorrelAid_Dach-Icon_darkgrey.png', align = "center", height = 110, width = 110),
    p(class = "about",
      "CorrelAidX Berlin, a local chapter of CorrelAid",
      br(),
      em("Good Causes. Better Effects. Local Implementation.")),
    br(),
    p(class = "correl",
      "CorrelAid is a network of young data analysts who want to change the world with a more inclusive, integrated and innovative approach to data analysis. The organization builds on three pillars: We take a pioneer role in analytics consulting for nonprofit organisations. We connect young, driven data scientists and offer them the possability to apply and develop their skills on real-world problems. Last but not least, we start a dialogue on the potential of data and analytics for the civic society."),
    br(), br(),
    p(class = "correl",
      "You want more?"),
    tags$a(href="https://correlaid.org/en", "Learn more about CorrelAid", style = "font-size:1.15vw;"),
    br(),
    pageButtonDown("Read more about our methodology", style = "font-size:1.15vw;"),
    br(),
    tags$a(href="https://github.com/CorrelAid/xberlin", "Get the code from GitHub", style = "font-size:1.15vw;")
  )
}
    
#' mod_overview Server Function
#'
#' @noRd 
mod_about_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_about_ui("mod_about_ui_1")
    
## To be copied in the server
# callModule(mod_about_server, "mod_about_ui_1")
 
