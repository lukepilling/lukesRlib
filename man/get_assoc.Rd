% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_assoc.R
\name{get_assoc}
\alias{get_assoc}
\title{Get tidy model output (just exposure of interest, with augmented output)}
\usage{
get_assoc(x, y, z, d, logistic = FALSE, af = FALSE, note = "", ...)
}
\arguments{
\item{x}{A string. The exposure variable name, found in `d`}

\item{y}{A string. The outcome variable name, found in `d`}

\item{z}{A string. The covariate formula (e.g., " + age + sex"), found in `d`}

\item{d}{A data.frame or tibble. The data}

\item{logistic}{Logical. Default is FALSE. Include `family=binomial(link="logit")` in `glm()`?}

\item{af}{Logical. Default is FALSE. Is `x` categorical? I.e., include in formula as `as.factor(x)`}

\item{note}{A string. If you want to include a note like "All", "Males", "C282Y homozygotes" to describe the model or sample.}

\item{...}{Other `tidy_ci()` options}
}
\value{
Returns a tibble - summary statistics from a model
}
\description{
To easily get tidy model output for a categorical or continuous exposure, including sample size (and N cases if logistic), outcome, and model info. Idea is to make quick loops easy.

For all exposures, it gets the N. For categorical exposures, the N is split by group, and a row is included for the reference category
}
\examples{
# for one outcome, equivalent to `tidy_ci(glm(weight ~ height +age+sex, d=ukb))` - with added `n`
get_assoc(y="weight", x="height", z="+age+sex", d=ukb)

# categorical exposure, binary outcome, and stratified analysis (with note)
get_assoc(y="chd", x="smoking_status", z="+age", d=ukb |> filter(sex==1), logistic=TRUE, af=TRUE, note="Males only")

# multiple exposures on single outcome, then combine output
x_vars = c("bmi","ldl","sbp_0_avg")
res = do.call(rbind, lapply(x_vars, get_assoc, y="chd", z="+age+sex", d=ukb, logistic=TRUE))

# one exposure on multiple outcomes, then combine output
y_vars = c("bmi","ldl","sbp_0_avg")
res = do.call(rbind, lapply(y_vars, function(y) get_assoc(x="smoking_status", y=y, z="+age+sex", d=ukb, af=TRUE)))

}
\author{
Luke Pilling
}
