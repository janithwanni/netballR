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
    # Initialize shinyJS
    # Your application UI logic 
    fluidPage(
      shinyjs::useShinyjs(),
      titlePanel("Team SL"),
      # fluidRow(
      #   column(6,
      #          h1("Attack mode"),
      #          mod_event_seq_creator_ui("event_seq_creator_ui_1")
      #          ),
      #   column(6,
      #          h1("Defence mode"),
      #          mod_event_seq_defence_ui("event_seq_defence_ui_1")
      #          )
      # )
      mainPanel(
        tabsetPanel(
          tabPanel("Dashboard",fluidRow(h4("Dashboard goes here"))),
          tabPanel("Player Information",h1("Player information"),
                   fluidRow(textInput("pinfo_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "pinfo", "I AM PANEL A"))
                   ),
          tabPanel("Team Information",h1("Team Information"),
                   fluidRow(textInput("tinfo_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "tinfo", "I AM PANEL A"))
                   ),
          tabPanel("Team A Match",h1("Team A Match Data"),
                   fluidRow(textInput("team_a_match_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "team_a_match", 
                                            mod_event_seq_creator_ui("event_seq_creator_ui_1")))
                   ),
          tabPanel("Team B Match",h1("Team B Match Data"),
                   fluidRow(textInput("team_b_match_creds","Enter Credentials")),
                   shinyjs::hidden(fluidRow(id = "team_b_match",
                                            mod_event_seq_creator_ui("event_seq_creator_ui_2")))
                   )
        )
      )
    )
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

