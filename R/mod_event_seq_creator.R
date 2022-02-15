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
    h1("Team A Match Events"),
    fluidRow(column(4,h4(textOutput(ns("time")))),
             column(8,textOutput(ns("t_score")))),
    fluidRow(column(12,textOutput(ns("ball_holder")))),
    fluidRow(
      column(3,
             fluidRow(column(12,actionButton(ns("from_C"),label = "C",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GD"),label = "GD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_WD"),label = "WD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_WA"),label = "WA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GA"),label = "GA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GS"),label = "GS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("from_GK"),label = "GK",width = "100%")))
             ),
      column(3,
             fluidRow(column(12,actionButton(ns("e_pass"),label = "PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_shoot"),label = "SHOOT",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_miss_shot"),label = "MISSED SHOT",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_sideline"),label = "SIDELINE PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_backline"),label = "BACKLINE PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_freepass"),label = "FREE PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_penaltypass"),label = "PENALTY PASS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_intercept"),label = "WAS INTERCEPTED",width = "100%"))),
             fluidRow(column(12,actionButton(ns("e_turnover"),label = "WAS TURNED OVER",width = "100%")))
             ),
      column(3,
             fluidRow(column(12,actionButton(ns("to_C"),label = "C",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GD"),label = "GD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_WD"),label = "WD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_WA"),label = "WA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GA"),label = "GA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GS"),label = "GS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("to_GK"),label = "GK",width = "100%")))
             ),
      column(3,
             h3("Intercepted by"),
             fluidRow(column(12,actionButton(ns("def_from_C"),label = "C",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_GD"),label = "GD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_WD"),label = "WD",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_WA"),label = "WA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_GA"),label = "GA",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_GS"),label = "GS",width = "100%"))),
             fluidRow(column(12,actionButton(ns("def_from_GK"),label = "GK",width = "100%")))
             )
    ),
    fluidRow(column(12,actionButton(ns("undo"),"Undo"))),
    fluidRow(column(12,tableOutput(ns("event_seq_table"))))
  )
}
    
#' event_seq_creator Server Functions
#'
#' @noRd 
mod_event_seq_creator_server <- function(id,r,team_letter){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    from <- reactiveValues(pos = NULL)
    to <- reactiveValues(pos = NULL)
    transit <- reactiveValues(pos = NULL)
    event <- reactiveValues(str = NULL)
    
    sheet_name <- paste(team_letter,"Match")
    config <- read_gsheet("Config")
    cur_qt <- config$Value[config$Key == "current_quarter"]
    start_time <- as.numeric(config$Value[config$Key == paste0("q",cur_qt,"_start_time")])
    
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
        event_row <- create_row(from = from$pos,event = transit$event,to = to$pos)
        event$str <- rbind(event$str,event_row)
        append_gsheet(sheet_name,event_row)
        from$pos <- pos_val
        to$pos <- NULL
        transit$event <- NULL
        r$mode <- "Defence"
      })
    })
    
    # event observations
    observeEvent(input$e_shoot,{
      transit$event <- "Shoot"
      event_row <- create_row(from = from$pos,event = transit$event,to = NA) 
      # data.frame(FROM = from$pos,EVENT = transit$event,TO = NA)
      event$str <- rbind(event$str,event_row)
      append_gsheet(sheet_name,event_row)
      from$pos <- NULL
      to$pos <- NULL
      transit$event <- NULL
      r$mode <- "Defence"
      if(is.null(r[[paste0("t",team_letter,"_score")]])){
        r[[paste0("t",team_letter,"_score")]] <- 1
      }else{
        r[[paste0("t",team_letter,"_score")]] <- r[[paste0("t",team_letter,"_score")]] + 1
      }
    })
    
    observeEvent(input$e_pass,{
      transit$event <- "Pass"
    })
    
    observeEvent(input$e_intercept,{
      transit$event <- "Intercepted"
      event_row <- create_row(from = from$pos,event = transit$event,to = NA)
        # data.frame(FROM = from$pos,EVENT = transit$event,TO = NA)
      event$str <- rbind(event$str,event_row)
      append_gsheet(sheet_name,event_row)
      from$pos <- NULL
      to$pos <- NULL
      transit$event <- NULL
      r$mode <- "Defence"
    })
    
    observeEvent(input$e_turnover,{
      transit$event <- "Turned over"
      event_row <- create_row(from = from$pos,event = transit$event,to = NA)
      # data.frame(FROM = from$pos,EVENT = transit$event,TO = NA)
      event$str <- rbind(event$str,event_row)
      append_gsheet(sheet_name,event_row)
      from$pos <- NULL
      to$pos <- NULL
      transit$event <- NULL
    })
    
    observeEvent(input$e_sideline,{
      transit$event <- "Sideline Pass"
    })
    
    observeEvent(input$e_backline,{
      transit$event <- "Backline Pass"
    })
    
    observeEvent(input$e_freepass,{
      transit$event <- "Free Pass"
    })
    
    observeEvent(input$e_penalty,{
      transit$event <- "Penalty Pass"
    })
    
    output$event_seq_table <- renderTable({
      return(event$str)
    },width="100%")
    
    output$ball_holder <- renderText({
      if(is.null(from$pos)){
        holder <- "No one"
      }else{
        holder <- from$pos
      }
      return(paste(holder,"is holding the ball currently"))
    })
    
    output$time <- renderText({
      config <- read_gsheet("Config")
      cur_qt <- config$Value[config$Key == "current_quarter"]
      start_time <- as.numeric(config$Value[config$Key == paste0("q",cur_qt,"_start_time")])
      if(cur_qt == 0){
        return("Quarter has not started yet")
      }
      lapse_s <- floor(as.numeric(Sys.time()) - start_time)
      mins <- floor(lapse_s / 60)
      secs <- floor(lapse_s - (mins * 60))
      invalidateLater(1000, session)
      return(paste0(mins,":",secs))
    })
    
    output$t_score <- renderText({
      out <- ""
      for(name in names(r)[grep("^t[A-Z]_score$",names(r))]){
        out <- paste(out,"Team",stringr::str_extract_all(name,"[A-Z]",simplify = TRUE)[1,1],
                     "Score",r[[name]],"|")
      }
      return(out)
    })
  })
}

#' create dataframe row from attack mode data
#' 
#' @noRd
create_row <- function(from,event,to,team="SL"){
  return(data.frame(Team = "SL",Mode = "Attack",Time = as.numeric(Sys.time()),
                    From = from,Event = event,To = to))
}
