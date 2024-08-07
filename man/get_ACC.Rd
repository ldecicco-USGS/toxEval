% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_ACC.R
\name{get_ACC}
\alias{get_ACC}
\title{Get the ACC values for a selection of chemicals}
\usage{
get_ACC(CAS)
}
\arguments{
\item{CAS}{Vector of CAS.}
}
\value{
data frame with columns CAS, chnm, flags, endPoint, ACC, MlWt, and ACC_value
}
\description{
The \code{get_ACC} function retrieves the activity concentration at cutoff
(ACC) values for specified chemicals.
}
\details{
The function \code{get_ACC} will
convert the ACC values in the ToxCast database from units of (\eqn{\mu}M)
to units of \eqn{\mu}g/L, and reformat the data as input to toxEval.
}
\examples{
CAS <- c("121-00-6", "136-85-6", "80-05-7", "84-65-1", "5436-43-1", "126-73-8")
ACC <- get_ACC(CAS)
head(ACC)
}
