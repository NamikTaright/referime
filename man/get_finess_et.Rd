% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{get_finess_et}
\alias{get_finess_et}
\title{~ api : recuperer les finess etablissement Etalab}
\usage{
get_finess_et(
  departement = c("75", "77", "78", "91", "92", "93", "94", "95"),
  def_url = "http://referime.aphp.fr/v0.1/"
)
}
\description{
~ api : recuperer les finess etablissement Etalab
}
\examples{
\dontrun{
get_finess_et()
get_finess_et(departement = '75')
get_finess_et(departement = c('36', '15'))
}
}
\author{
G. Pressiat
}
