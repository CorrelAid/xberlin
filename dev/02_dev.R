# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package( "thinkr" )
usethis::use_package( "ggplot2" )
usethis::use_package( "dplyr" )
usethis::use_package( "tidyr" )
usethis::use_package( "usethis" )
usethis::use_package( "stringr" )
usethis::use_package( "shinyWidgets" )
usethis::use_package( "fullPage" )
usethis::use_package( "shinycssloaders" )
usethis::use_package( "typed" )
usethis::use_package( "emo" )
usethis::use_package( "echarts4r" )
usethis::use_package( "tmap" )
usethis::use_package( "leaflet" )
usethis::use_package( "rcartocolor" )

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "intro" ) # Name of the module
golem::add_module( name = "cities" ) # Name of the module
golem::add_module( name = "districts" ) # Name of the module
golem::add_module( name = "map_accidents" ) # Name of the module
golem::add_module( name = "types" ) # Name of the module
golem::add_module( name = "map_traffic" ) # Name of the module
golem::add_module( name = "methods" ) # Name of the module
golem::add_module( name = "about" ) # Name of the module

## Add helper functions ----
## Creates ftc_* and utils_*
golem::add_fct( "helpers" )
golem::add_utils( "helpers" )

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw( name = "datenguide", open = TRUE )
usethis::use_data_raw( name = "traffic_cells", open = TRUE )
usethis::use_data_raw( name = "bike_lanes", open = TRUE )
usethis::use_data_raw( name = "bike_accidents_sum", open = TRUE )
usethis::use_data_raw( name = "bike_accidents_match", open = TRUE )
usethis::use_data_raw( name = "risk_map", open = TRUE )

## Tests ----
## Add one line by test you want to create
usethis::use_test( "app" )

# Documentation

## Vignette ----
usethis::use_vignette("xberlin")
devtools::build_vignettes()

## Code coverage ----
## (You'll need GitHub there)
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
  