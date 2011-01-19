\name{obsSensCCC}
\alias{obsSensCCC}
\alias{obsSensCCN}
\alias{obsSensCNN}
\alias{obsSensNCC}
\alias{obsSensNCN}
\alias{obsSensNNN}
\alias{obsSensSCC}
\alias{obsSensSCN}
\alias{obsSensSNN}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Compute Sensitivity analysis for Observational Studies }
\description{
  Computes a Sensitivity analysis for a coefficient from a regression
  model (linear, logistic, Cox) on Observational data.  Computes new
  coefficient estimate and confidence interval for various relationships
  between the response, predictor of interest, and an unmeasured
  variable.  The last 3 letters of each function refer to the type of
  the variables in the order Y, X, U with C meaning categorical, N
  meaning normal (continuous), and S being a survival object.
}
\usage{
obsSensCCC(model, which = 2, g0 = c(2, 6, 10), g1, p0 = seq(0, 1, 0.2), p1 = p0, logOdds = FALSE, method = c("approx", "sim"))

obsSensCCN(model, which = 2, gamma = round(seq(0, 2 * bstar, length = 6), 4), delta = seq(0, 3, 0.5), logOdds = FALSE, method = c("approx", "sim"))

obsSensCNN(model, which = 2, gamma = round(seq(0, 2 * bstar, length = 6), 4), rho = c(0, 0.5, 0.75, 0.85, 0.9, 0.95, 0.98, 0.99), sdx, logOdds = FALSE, method = c("approx", "sim"))

obsSensNCC(model, which = 2, g0 = c(2, 6, 10), g1, p0 = seq(0, 1, 0.2), p1 = p0, log = TRUE, method = c("approx", "sim"))

obsSensNCN(model, which = 2, gamma = round(seq(0, 3, length = 6), 4), delta = seq(0, 3, 0.5), log = TRUE, method = c("approx", "sim"))

obsSensNNN(model, which = 2, gamma = round(seq(0, 2 * bstar, length =
6), 4), rho = c(0, 0.5, 0.75, 0.85, 0.9, 0.95, 0.98, 0.99), sdx, log = TRUE, method = c("approx", "sim"))

obsSensSCC(model, which = 2, g0 = c(2, 6, 10), g1, p0 = seq(0, 1, 0.2), p1 = p0, logHaz = FALSE, method = c("approx", "sim"))

obsSensSCN(model, which = 2, gamma = round(seq(0, 3, length = 6), 4), delta = seq(0, 3, 0.5), logHaz = FALSE, method = c("approx", "sim"))

obsSensSNN(model, which = 2, gamma = round(seq(0, 3, length = 6), 4), rho = c(0, 0.5, 0.75, 0.85, 0.9, 0.95, 0.98, 0.99), sdx, logHaz = FALSE, method = c("approx", "sim"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{A regression model object (result of \code{lm},
    \code{glm}, or \code{coxph} or
    other object with a \code{coef} method) or a single numerical value
    representing the estimated coefficient from a regression model.}
  \item{which}{Which coefficient (in the results from
    \code{coef(model)}) corresponds to the predictor of interest.  If
    \code{model} is a number then this should be a 2 element vector with
  the initial confidence interval for \code{model}.}
  \item{g0}{The slopes on the unmeasured variable when x=0 (on the log
    scale, not response). }
  \item{g1}{The slopes on the unmeasured variable when x=1, if missing
    then g1=g0=gamma is assumed. }
  \item{p0}{Probability that U=1 given x=0.  }
  \item{p1}{Probability that U=1 given x=1. }
  \item{logOdds}{Should the resulting table be on the log scale or
    response scale. }
  \item{log}{Should the resulting table be on the log scale or not. }
  \item{logHaz}{Should the resulting table be on the log Hazard ratio
    scale or Hazard ratio scale. }
  \item{method}{Either "approx" or "sim", only approx is currently implemented. }
  \item{gamma}{Slopes for U (unmeasured variable). }
  \item{delta}{ The difference between the mean of U|x=0 and mean of U|x=1. }
  \item{rho}{Correlation coefficient between x and U. }
  \item{sdx}{Standard Deviation of x (default will try to extract this
    from \code{model}, it will need to be provided if \code{model} is a
    number rather than a model object).}
}
\details{
  These functions are all used to do sensitivity analysis on regression
  models for observational data.  Currently it works with linear
  regression, logistic regression (using \code{glm}), and survival
  regressions (using \code{coxph}).  All models are of the general form:

  y = b1*x + gamma*U + Beta*Z

  Where y is the response (or function of the response).  The first
  letter in the triplet at the end of each function name corresponds to
  the type of response variable, N-normal/numeric (continuous),
  C-Categorical (binary, logistic regression), and S-Survival (coxph
  models).

  The x variable is the coefficient of interest (usually the treatment
  variable, or primary predictor of interest).  The 2nd letter in the
  triplet can be C-Categorical (x is 0 or 1, usually control
  vs. treatment) or N-Numeric, a continuous variable.

  The U variable is an unmeasured potential confounder that we believe
  may be related to y and x.  The final letter in the final triplet
  refers to the type of unmeasured variable that we want to correct for:
  C-Categorical/binary (0-1, present-absent) or N-Numerical/continuous
  (in this case it is assumed to be normal with mean 0 and sd 1).

  The Z represents additional covariates in the model that are not of
  primary interest in the sensitivity analysis.  It is assumed that Z
  and U are independent of each other.

  For all the functions you specify the potential relationships between
  U and y (\code{gamma}, \code{g0}, and \code{g1}) and potential
  relationships between x and U (\code{p0}, \code{p1}, \code{delta}, and
  \code{rho}).  Then the functions compute a new estimate of b1 (the
  slope for x, the variable of interest) and its confidence interval
  given each combination of the relationships between U, y, and x.

  Currently only the approximation method by Lin et. al. is available.
  In the future a simulation method will also be implemented.
}
\value{
  An obsSens object (S3) stored as a list with the following elements:
  \item{beta}{A matrix/array with the adjusted slopes for the different
  conditions.}
  \item{lcl}{A matrix/array with the lower confidence intervals for the
    slopes.}
  \item{ucl}{A matrix/array with the upper confidence intervals for the
    slopes.}
  \item{log}{A logical indicating if the values are on the log scale.}
  \item{xname}{The 'name' of the x variable of interest}
  \item{type}{Character field with the type of y variable, can be
    'cat', 'surv', or 'num'.}
}
\note{
  Note:  Currently there are no checks on whether the conditions will be
  appropriate for the approximation to be close.  See the first paper
  below for the conditions when the approximation is good.
}
\references{
Lin, DY and Psaty, BM and Kronmal, RA. (1998): Assessing the Sensitivity
of Regression Results to Unmeasured Confounders in Observational
Studies.  Biometrics, 54 (3), Sep, pp. 948-963.

Baer, VL et. als (2007): Do Platelet Transfusions in the NICU Adversely
Affect Survival? Analysis of 1600 Thrombocytopenic neonates in a
mulihospital healthcare system.  Journal of Perinatology, 27, pp. 790-796.
}
\author{Greg Snow \email{greg.snow@imail.org}}
\seealso{ \code{\link{print.obsSens}}, \code{\link{summary.obsSens}} }
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
\keyword{ regression }
\keyword{ survival }