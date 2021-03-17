#' mod_methods UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_methods_ui <- function(id){
 ns <- NS(id)
 fullPage::pageContainer(
   tags$style(type = "text/css",
              "p {font-weight:300;font-size:.9vw;}
               strong {font-weight:400;font-size:.95vw;font-family:'Bebas Neue', sans-serif;}
               li {color:#063a2b; font-family:'Arbutus Slab', serif; font-size:.75vw;}
               header shadow-light {font-size:1.05vw;}
               a {color: #2d896e;}"),
   h1(class = "header shadow-light",
    "Methodology"), 
  br(),
  p("For our assessment we used 3 major data sources:"),
  tags$ul(
    tags$li(tags$a(href="https://datenguidepy.readthedocs.io/en/latest/readme/", code("datenguidepy")), 
            "– A Python package created by",
            tags$a(href="https://correlaid.org/en", "CorrelAid"), 
            "containing regional data (NUTS1-3) on various topics such as economics, finance or environmental and social affairs. The data source is the", 
            tags$a(href="https://www.destatis.de/EN/Home/_node.html", "German Federal Statistical Office"), 
            "that collects, checks and verifies the data on a yearly basis."), br(),
    tags$li(tags$a(href="https://unfallatlas.statistikportal.de/_opendata2020.html/", code("Unfallatlas")), 
            "– An ongoing project by the",
            tags$a(href="https://www.destatis.de/EN/Home/_node.html", "German Federal Statistical Office (Destatis)"), 
            "since 2016. For each year, destatis collects regional data on car, bike, motorcycle, pedestrian, and lorry accidents with personal injuries on a NUTS1-3 level from several German states and converts them into an open source geographical dataset. Additional data such as the month, day, time and the geographical location of the incident as well as road and light conditions during the accident are also included. For our work we selected the latest data on (bike) accidents in Berlin. In 2019 there were 5,005 recorded bike accidents within the city state."), br(), 
    tags$li(tags$a(href="https://data.technologiestiftung-berlin.de/", code("Technologiestiftung Berlin")), 
            "– A non-profit foundation that is commited to the digitization of Berlin by providing open information, software and infrastructure. We used geodata on",
            tags$a(href="https://data.technologiestiftung-berlin.de/dataset/teil_verkehrszellen/en", "traffic cells (“Teilverkehrszellen”)"),
            "and",
            tags$a(href="https://data.technologiestiftung-berlin.de/dataset/radverkehrsanlagen/en", "bike traffic infrastructures (“Radverkehrsanlagen”)"),
            "in Berlin. Overall, there are 15 different bike lane categories. For our analysis, we aggregated the categories to five major classes, based on structural appearance (true bike paths, bike paths combined with sidewalk, bike lanes on roads and bus lanes) and whether the use is mandatory or advisory."), 
    br()
  ),
  p(strong("Step 1:"), "We matched the bike lane data with the accident data from 2019. We added a 4-meter buffer to each bike lane that is represented by a geographical linestring. Any accident point that falls within the buffer will be associated with the specific bike lane segment and therefore the bicycle infrastructure. All accidents that did not fall in any of the five categories was classified as “road only”. We used the merged data sets to explore the bike accidents and the bicycle infrastructure in Berlin."),
  p(strong("Step 2:"), "Next, we aimed to investigate the number of accidents that occurred on bike infrastructures as a proportion of all accidents and where the hotspots can be located. We matched the dataset obtained in Step 1 with 1,223 subtraffic cells. Most bike accidents happened on roads and not on bike infrastructure. However, in both cases the hotspots can be found near Berlin city centre."),
  p(strong("Future steps:"), "While this data already reveals interesting patterns, some open questions remain. In future steps we would like to explore whether and by how much certain bicycle infrastructures reduce the risks of accidents. For analyzing this question, we want to relate number of accidents with injuries in each subtraffic cell with the coverage of bike infrastructure and traffic volumes. Therefore, data sources on traffic volumes (by separate modes of transportation) are explored. Publicly available counter data is one potential source but there are only a few spots where traffic volumes were actually counted. Private providers of fitness or routing apps may be another source of data for traffic data.")
 )
}
  
#' mod_methods Server Function
#'
#' @noRd 
mod_methods_server <- function(input, output, session){
 ns <- session$ns
 
}
  
## To be copied in the UI
# mod_methods_ui("mod_methodsui_1")
  
## To be copied in the server
# callModule(mod_methods_server, "mod_methods_ui_1")
 
