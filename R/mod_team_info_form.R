#' team_info_form UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_team_info_form_ui <- function(id,team_letter){
  ns <- NS(id)
  POSITIONS <- c("C","GD","WD","WA","GA","GS","GK")
  POSITIONS <- c(POSITIONS,paste("Substitute",POSITIONS))
  name_tib <- read_gsheet("Player information")
  tagList(
    fluidRow(column(12,h1(paste("Team ",team_letter)),
                    textInput(ns("team_name"),"Team Name"),
                    actionButton(ns("refresh_pnames"),"Refresh Player Names"),
                    lapply(1:14,function(i){
                      fluidRow(
                        column(6,selectInput(ns(paste0("t",team_letter,"_p",i)),
                                             paste("Player",i,"Name"),
                                             choices = c(name_tib$Name,"None"))),
                        column(6,selectInput(ns(paste0("t",team_letter,"_pos",i)),
                                             paste("Player",i,"Position"),
                                    choices = POSITIONS,width = "50%",selected = POSITIONS[i]))
                      )
                    }),
                    actionButton(ns("submit"),"Submit")
                    )
             )
  )
}
    
#' team_info_form Server Functions
#'
#' @noRd 
mod_team_info_form_server <- function(id,team_letter){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$submit,{
      req(input$team_name)
      team_name <- input$team_name
      
      col_df <- data.frame("Team_letter","Team_name",
                           "Player_name","Position")
      add_wsheet("Team Information",col_df)
      
      for(i in 1:14){
        player_name <- input[[paste0("t",team_letter,"_p",i)]]
        position <- input[[paste0("t",team_letter,"_pos",i)]]
        row <- data.frame(Team_letter = team_letter,Team_name = team_name,
                          Player_name = player_name,Position = position)
        append_gsheet(sheet = "Team Information",row)
      }
    })
    
    observeEvent(input$refresh_pnames,{
      names_tib <- read_gsheet("Player information")
      updateSelectInput(choices = c(names_tib$Name,"None"))
    })
  })
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
