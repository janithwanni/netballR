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
  observeEvent(input$ta_info_creds,{
    if(input$ta_info_creds == "1234"){
      shinyjs::showElement(id="ta_info")
      shinyjs::hideElement(id="ta_info_creds")
    }
  })
  observeEvent(input$tb_info_creds,{
    if(input$tb_info_creds == "1234"){
      shinyjs::showElement(id="tb_info")
      shinyjs::hideElement(id="tb_info_creds")
    }
  })
  observeEvent(input$team_a_match_creds,{
    if(input$team_a_match_creds == ""){
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
  observeEvent(input$admin_creds,{
    if(input$admin_creds == "1234"){
      shinyjs::showElement(id="admin")
      shinyjs::hideElement(id="admin_creds")
    }
  })
  mod_event_seq_creator_server("event_seq_creator_ui_1",r)
  mod_event_seq_creator_server("event_seq_creator_ui_2",r)
  mod_team_info_form_server("team_info_form_ui_1","A")
  mod_team_info_form_server("team_info_form_ui_2","B")
  mod_control_panel_server("control_panel_ui_1")
  # mod_event_seq_defence_server("event_seq_defence_ui_1",r)
}
