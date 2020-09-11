#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#' @import fullPage
run_app <- function(
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      options = list(launch.browser = .rs.invokeShinyWindowExternal),
      server = app_server
    ), 
    golem_opts = list(...)
  )
}
