#' Compiles and installs all libraries in the current RStudio script where the word library is written
#'
#' @return libraries compiled
#' @export
#'
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#'
#' @examples
#' \donttest{
#' # Copy and paste all the following code in RStudio
#' }
#' loaded_pkgs<-(.packages())
#'
#' \donttest{
#' # library(ggplot2)
#' # library(dplyr)
#' }
#' libraries()
#'
#' loaded_pkgs2<-(.packages())
#'
#'
#' loaded_pkgs2[!loaded_pkgs2 %in% loaded_pkgs]
#' 
#'
libraries<-function(){
  ctx<-try(rstudioapi::getActiveDocumentContext(),silent=TRUE)
  if (!inherits(ctx,"try-error")){
    contenido<-ctx[["contents"]]
    contenido<-contenido[nchar(contenido)!= 0]
    libr<-nchar(contenido)-as.integer(sapply(contenido,function(x)nchar(gsub("library","",x))))
    libs<-contenido[libr!=0]
    libs_2<-contenido[libr>7]
    libs_<-sapply(libs,function(x)(gsub("library[()]","",gsub("[)]","",x))))
    installed<-installed.packages()[,1]
    install_cond<-libs_ %in% installed
    libs_installed<-libs_[install_cond]
    libs_check<-libs[!install_cond]
    libs_check_<-do.call(c,strsplit(libs_check,";"))
    cond_l1<-libs_check_ %in% installed
    l111<-sapply(libs_check_,function(x)(gsub("library[()]","",gsub("[)]","",x))))
    c2<-l111 %in% installed
    l112<-l111[!c2]
    l111<-l111[c2]
    libs_installed<-c(libs_installed,l111)
    libs_check_2<-libs_check_[!c2]
    chc<-c()
    for( l in libs_check_2){
      if(grepl("library",l)){
        sep<-strsplit(l,"[(]")[[1]][-1]
        sep<-strsplit(sep,"[)]")[[1]][1]
        chc<-c(chc,strsplit(sep,",")[[1]][1])
      }
    }
    libs_installed<-c(libs_installed,chc)
    libs_installed<-libs_installed[!duplicated(libs_installed)]
    ins<-libs_installed %in% installed
    if(length(libs_installed[!ins])) try(install.packages(c(libs_installed[!ins]),repos = "http://cran.rstudio.com/",dependencies = TRUE),silent = T)
    lapply(libs_installed,function(x){try(library(x,character.only=TRUE),silent = T)})
    return(invisible())
  }
}