#' event_seq_creator UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_event_seq_creator_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(column(12,textOutput(ns("ball_holder")))),
    fluidRow(
      column(4,
             fluidRow(column(12,actionButton(ns("from_C"),label = "C",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GD"),label = "GD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_WD"),label = "WD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_WA"),label = "WA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GA"),label = "GA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GS"),label = "GS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GK"),label = "GK",width = "100%")))
             ),
      column(4,
             fluidRow(column(12,actionButton(ns("e_pass"),label = "PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_shoot"),label = "SHOOT",width = "100%")))
             ),
      column(4,
             fluidRow(column(12,actionButton(ns("to_C"),label = "C",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GD"),label = "GD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_WD"),label = "WD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_WA"),label = "WA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GA"),label = "GA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GS"),label = "GS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GK"),label = "GK",width = "100%")))
             )
    ),
    fluidRow(column(12,tableOutput(ns("event_seq_table"))))
  )
}
    
#' event_seq_creator Server Functions
#'
#' @noRd 
mod_event_seq_creator_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    from <- reactiveValues(pos = NULL)
    to <- reactiveValues(pos = NULL)
    transit <- reactiveValues(pos = NULL)
    event <- reactiveValues(str = NULL)
    
    POSITIONS <- c("C","GD","WD","WA","GA","GS","GK")
    lapply(POSITIONS,function(pos_val){
      event_key <- paste0("from_",pos_val)
      observeEvent(input[[event_key]],{
        from$pos <- pos_val
      })
    })
    lapply(POSITIONS,function(pos_val){
      event_key <- paste0("to_",pos_val)
      observeEvent(input[[event_key]],{
        to$pos <- pos_val
        event$str <- rbind(event$str,
                           data.frame(FROM = from$pos,EVENT = transit$event,TO = to$pos))
        from$pos <- pos_val
        to$pos <- NULL
        transit$event <- NULL
      })
    })
    
    observeEvent(input$e_shoot,{
      transit$event <- "Shoot"
      event$str <- rbind(event$str,
                         data.frame(FROM = from$pos,EVENT = transit$event,TO = NA))
      from$pos <- NULL
      to$pos <- NULL
      transit$event <- NULL
    })
    
    observeEvent(input$e_pass,{
      transit$event <- "Pass"
    })
    
    output$event_seq_table <- renderTable({
      return(event$str)
    })
    
    output$ball_holder <- renderText({
      if(is.null(from$pos)){
        holder <- "No one"
      }else{
        holder <- from$pos
      }
      return(paste(holder,"is holding the ball currently"))
    })
  })
}

#' append dataframe to google sheets
#'
#' @noRd
append_sheets <- function(df){
  # TODO implement
}
