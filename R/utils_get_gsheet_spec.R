#' get_gsheet_spec 
#'
#' @description gets the Google Sheets specification
#'
#' @return a Google sheet specification
#'
#' @noRd
get_gsheet_spec <- function(){
  SHEET <- "https://docs.google.com/spreadsheets/d/1GVLadVyxDkcAxZkQeAMpPpOjla2bi6GtLdwpCyGmBCk/edit?usp=sharing"
  googlesheets4::gs4_auth(cache="secrets",email="janithcwanni@gmail.com")
  return(googlesheets4::as_sheets_id(SHEET))
}
