#' team_info_form UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_team_info_form_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(h1("Team Information")),
    fluidRow(column(6,h1("Team A")),column(6,h1("Team B")))
  )
}
    
#' team_info_form Server Functions
#'
#' @noRd 
mod_team_info_form_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
