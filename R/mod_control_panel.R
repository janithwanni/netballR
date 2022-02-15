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
    fluidRow(textOutput(ns("cur_qt"))),
    fluidRow(column(4,
                    actionButton(ns("start_q1"),"Start Quarter 1",width="100%"),
                    actionButton(ns("start_q2"),"Start Quarter 2",width="100%"),
                    actionButton(ns("start_q3"),"Start Quarter 3",width="100%"),
                    actionButton(ns("start_q4"),"Start Quarter 4",width="100%")
                    ),
             column(4,
                    actionButton(ns("stop_q1"),"Stop Quarter 1",width="100%"),
                    actionButton(ns("stop_q1"),"Stop Quarter 2",width="100%"),
                    actionButton(ns("stop_q1"),"Stop Quarter 3",width="100%"),
                    actionButton(ns("stop_q1"),"Stop Quarter 4",width="100%"),))
  )
}
    
#' control_panel Server Functions
#'
#' @noRd 
mod_control_panel_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    cur_qt <- reactiveValues(qt = 0)
    lapply(seq(4),function(i){
      observeEvent(input[[paste0("start_q",i)]],{
        config <- read_gsheet("Config")
        config$Value[config$Key == "current_quarter"] <- i
        cur_qt$qt <- i
        config$Value[config$Key == paste0("q",i,"_start_time")] <- as.numeric(Sys.time())
        googlesheets4::sheet_write(config,get_gsheet_spec(),"Config")
      })
    })
    
    lapply(seq(4),function(i){
      observeEvent(input[[paste0("stop_q",i)]],{
        config <- read_gsheet("Config")
        config$Value[config$Key == "current_quarter"] <- 0
        cur_qt$qt <- 0
        # config$Value[config$Key == paste0("q",i,"_start_time")] <- as.numeric(Sys.time())
        googlesheets4::sheet_write(config,get_gsheet_spec(),"Config")
      })
    })
    
    output$cur_qt <- renderText({
      paste("Current Quarter:",cur_qt$qt)
    })
  })
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
