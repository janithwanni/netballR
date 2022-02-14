#' control_panel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_control_panel_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' control_panel Server Functions
#'
#' @noRd 
mod_control_panel_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
