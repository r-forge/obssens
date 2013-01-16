\name{print.obsSens}
\alias{print.obsSens}
\alias{summary.obsSens}
\alias{print.summary.obsSens}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Print and Summarize ObsSens objects. }
\description{
  Print a nice table of the results from a sensitivity analysis on
  observational data.
}
\usage{
\method{print}{obsSens}(x, ...)

\method{summary}{obsSens}(object, digits=3, ...)

\method{print}{summary.obsSens}(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{An obsSens object or summary.obsSens object. }
  \item{object}{An obsSens object.}
  \item{digits}{Passed to \code{format}.}
  \item{\dots}{Additional arguments passed on to print methods for matrix/array. }
}
\details{
  These functions print and summarize the results of the obsSens
  functions.  The only difference in the print and summary methods is
  the return value (the information printed to the screen is the same).
  The \code{print} function returns a copy of the original object.  The \code{summary}
  function returns a matrix/array of character strings corresponding to
  what is printed that can hopefully be used along with other functions
  (latex, xtable, odfTable, ...) for typesetting results in other formats.
}
\value{
  The \code{print} method returns a copy of the original object.  The
  \code{summary} method returns a character array/matrix with the
  coefficients and confidence intervals to be passed to other
  typesetting/printing functions.
}
\author{Greg Snow \email{greg.snow@imail.org} }
\examples{
# Recreate tables from above references

obsSensCCC( log(23.1), log(c(6.9, 77.7)), g0=c(2,6,10),
  p0=seq(0,.5,.1), p1=seq(0,1,.2) )

obsSensSCC( log(1.21), log(c(1.09,1.25)),
  p0=seq(0,.5,.1), p1=seq(0,1,.1), g0=3 )


obsSensCNN( log(1.14), log(c(1.10,1.18)),
  rho=c(0,.5, .75, .85, .9, .95, .98, .99),
  gamma=seq(0,1,.2), sdx=4.5 )
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }
