#' append_sheet 
#'
#' @description append dataframe from google sheets
#'
#' @param sheet_name The name of the sheet to append to
#' @param df_row The dataframe row to append to the sheet_name
#' @return None
#'
#' @noRd
append_gsheet <- function(sheet_name,df_row){
  ssid <- get_gsheet_spec()
  sheet_names <- googlesheets4::sheet_names(ssid)
  if(sheet_name %in% sheet_names){
    googlesheets4::sheet_append(ssid,df_row,sheet=sheet_name)
  }else{
    print(paste("Creating New Sheet",sheet_name))
    add_wsheet(sheet_name,data.frame(matrix(colnames(df_row),ncol=ncol(df_row))))
    googlesheets4::sheet_append(ssid,df_row,sheet=sheet_name)
  }
}