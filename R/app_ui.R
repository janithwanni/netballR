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
      titlePanel("Team SL"),
      fluidRow(column(12,
                      h3("Attack mode") # TODO need to make dynamic
                      )),
      fluidRow(
        column(6,
               h1("Event sequence"),
               mod_event_seq_creator_ui("event_seq_creator_ui_1")
               ),
        column(6,
               h1("Special Events"))
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

