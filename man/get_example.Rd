% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{get_example}
\alias{get_example}
\title{Run Shiny app example}
\usage{
get_example(path, view_code = knitr::is_html_output(), package = "OSUICode")
}
\arguments{
\item{path}{App location.}

\item{view_code}{Whether to print the app code.
TRUE if document is HTML output, FALSE otherwise.}

\item{package}{Where to take the example from. Default
to current package.}
}
\description{
Run Shiny app example
}
\examples{
if (interactive()) {
 get_example("dj-system")
}
}
