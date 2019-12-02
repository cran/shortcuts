#' Creates a file copying current code without comments and tabuations
#'
#' @return clear code to be executed
#' @export
#' 
#' @importFrom utils read.table
#' @importFrom rstudioapi getActiveDocumentContext
#' @importFrom utils head
#'
#' @examples
#'
#' \donttest{
#' # Copy and paste all the following code in RStudio
#' }
#' 1+1
#' 
#' clear.code()
#'
clear.code <- function(){
    ctx<-try(rstudioapi::getActiveDocumentContext(),silent=TRUE)
    if (!inherits(ctx,"try-error")){
        contenido<-ctx[["contents"]]
        file_w <- file("new.R")
        writeLines(((contenido)),file_w)
        writeLines(as.character(parse("new.R")),file_w)
        utils::file.edit("new.R")
    }
    return(invisible())
}