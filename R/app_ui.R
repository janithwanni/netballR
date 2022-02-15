#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    fluidPage(
      shinyjs::useShinyjs(), # Initialize shinyJS
      titlePanel("netballR"),
      
        tabsetPanel(
          tabPanel("Dashboard",fluidRow(h4("Dashboard goes here"))),
          tabPanel("Player Information",
                   fluidRow(textInput("pinfo_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "pinfo", "Player Info"))
                   ),
          tabPanel("Team A Information",
                   fluidRow(textInput("ta_info_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "ta_info", 
                                            mod_team_info_form_ui("team_info_form_ui_1","A")))
                   ),
          tabPanel("Team A Match",
                   fluidRow(textInput("team_a_match_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "team_a_match", 
                                            mod_event_seq_creator_ui("event_seq_creator_ui_1")))
                   ),
          tabPanel("Team B Information",
                   fluidRow(textInput("tb_info_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "tb_info", 
                                            mod_team_info_form_ui("team_info_form_ui_2","B")))
                   ),
          tabPanel("Team B Match",
                   fluidRow(textInput("team_b_match_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "team_b_match",
                                            mod_event_seq_creator_ui("event_seq_creator_ui_2")))
                   ),
          tabPanel("Admin",h1("Control Panel"),
                   fluidRow(textInput("admin_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "admin",mod_control_panel_ui("control_panel_ui_1")))
                   )
        )
      
    ,style="width: 80%")
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
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'netballR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

