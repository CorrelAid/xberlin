#' mod_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_intro_ui <- function(id){
 ns <- NS(id)
 fullPage::pageContainer(
   p("Re-thinking mobility is crucial to improve air quality and CO2 consumption in traffic. For this reason, Berlin has set itself the", 
   tags$a(href="https://www.berlin.de/sen/uvk/verkehr/verkehrsplanung/radverkehr/mobilitaetsgesetz/", "goal of getting away from a car based concept of mobility."),
   "Instead, Berlin wants to promote cycling as an environmentally friendly and sustainable mode of transportation."),
  br(), br(), 
  p("At the same time, cyclists are the most at-risk group of all traffic participants. According to the accident statistics around a quarter of all accidents involve cyclists. And while accident numbers have generally declined over the last fifteen years in Berlin, they have recently remained rather stable with little improvements. In contrast, accident numbers have continued falling In other large German cities. The data also reveals that most bike accidents happen on roads without any sort of bike lane or on advisory bike lane paths. In around 80% of these accidents cars are involved putting cyclists at serious risk of getting injured or even killed."), #Among accidents with serious injury or fatalities, cyclists are involved in []%."),
  br(), br(),
  p("While many people want to switch to cycling, safety concerns are deterring many people from using bikes more often. Perceived and actual risk of biking is a",
   tags$a(href="https://nationaler-radverkehrsplan.de/de/forschung/schwerpunktthemen/subjektive-sicherheit-im-radverkehr", "key determinant in mobility decisions."),
   "The importance ofthese risk considerations can be seen during the Corona epidemic when commuters",
   tags$a(href="https://www.adac.de/verkehr/standpunkte-studien/mobilitaets-trends/corona-mobilitaet/", "have switched from public transit"), 
   "(where infection seems more likely) to",
   tags$a(href="https://www.handelsblatt.com/unternehmen/industrie/mobilitaet-zurueck-zum-individualverkehr-in-der-krise-waechst-die-lust-am-eigenen-auto/25799626.html", "cars"), 
   "and",
   tags$a(href="https://www.zeit.de/mobilitaet/2020-09/radfahrer-coronavirus-fahrrad-boom-staedte-zahlen-verkehr", "bicycles."),
   "To get people on the bike, safety has therefore to be improved. The recent change in mobility patters during the Corona epidemic has further increased the need to improve bike safety. But first, we need to understand where and why cyclists are at risk of having accidents."),
  br(), br(),
  p("Using publicly available data on accidents with injuries from the",
    tags$a(href="https://www.destatis.de/EN/Home/_node.html", "German Federal Statistical Office"), 
    "— provided by the",
   tags$a(href="https://datenguidepy.readthedocs.io/en/latest/readme/", code("datenguidepy")),
   "wrapper and the",
   tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html", "“Unfallatlas”"),
   "— as well as information on ",
   tags$a(href="https://data.technologiestiftung-berlin.de/dataset/radverkehrsanlagen", "bicycle infrastructure"), 
   "and",
   tags$a(href="https://data.technologiestiftung-berlin.de/dataset/teil_verkehrszellen", "traffic cells"), 
   ", the relevant areal unit for data collection and planning in Berlin, these questions are explored on the following pages."
  ),
  br(),
  pageButtonDown("Start!", style = "color:#11a579;font-family:'Bebas Neue', serif;font-size:1.65vw;")
 )
}
  
#' mod_overview Server Function
#'
#' @noRd 
mod_intro_server <- function(input, output, session){
 ns <- session$ns
 
}
  
## To be copied in the UI
# mod_intro_ui("mod_intro_ui_1")
  
## To be copied in the server
# callModule(mod_intro_server, "mod_intro_ui_1")
 
