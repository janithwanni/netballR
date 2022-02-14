#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  r <- reactiveValues(mode = "Attack")
  observeEvent(input$pinfo_creds,{
    if(input$pinfo_creds == "1234"){
      shinyjs::showElement(id="pinfo")
      shinyjs::hideElement(id="pinfo_creds")
    }
  })
  observeEvent(input$tinfo_creds,{
    if(input$tinfo_creds == "1234"){
      shinyjs::showElement(id="tinfo")
      shinyjs::hideElement(id="tinfo_creds")
    }
  })
  observeEvent(input$team_a_match_creds,{
    if(input$team_a_match_creds == "1234"){
      shinyjs::showElement(id="team_a_match")
      shinyjs::hideElement(id="team_a_match_creds")
    }
  })
  observeEvent(input$team_b_match_creds,{
    if(input$team_b_match_creds == "1234"){
      shinyjs::showElement(id="team_b_match")
      shinyjs::hideElement(id="team_b_match_creds")
    }
  })
  mod_event_seq_creator_server("event_seq_creator_ui_1",r)
  mod_event_seq_creator_server("event_seq_creator_ui_2",r)
  # mod_event_seq_defence_server("event_seq_defence_ui_1",r)
}
