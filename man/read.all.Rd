% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.all.R
\name{read.all}
\alias{read.all}
\title{Read all documents in a folder and subfolders assigning them to the global environment; just extensions ".txt" and ".csv" are allowed}
\usage{
read.all(dir = getwd())
}
\arguments{
\item{dir}{directory to read}
}
\value{
data frame objects
}
\description{
Read all documents in a folder and subfolders assigning them to the global environment; just extensions ".txt" and ".csv" are allowed
}
\examples{


lib<-getwd()

read.all(lib)


}
