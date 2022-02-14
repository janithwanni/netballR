#' add_sheet 
#'
#' @description Adds a worksheet to a google sheet
#' 
#' @param sheet_name Name of the sheet to add
#' @param col_tib An empty tibble with the columns specified
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
add_wsheet <- function(sheet_name,col_tib){
  ssid <- get_gsheet_spec()
  sheet_names <- googlesheets4::sheet_names(ssid)
  if(sheet_name %in% sheet_names){
    print("Sheet already exists")
  }else{
    googlesheets4::sheet_add(ssid,sheet=sheet_name)
    googlesheets4::sheet_append(ssid,col_tib,sheet=sheet_name)  
  }
  
}