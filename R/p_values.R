#' Get extreme p-value
#'
#' @description Return p-value for any Z as a string
#'
#' @return Returns a string (p-value)
#'
#' @author Internet person
#'
#' @name extreme_p
#'
#' @param z a z or t statistic
#'
#' @examples
#' extreme_p(z)
#'
#' @export
#'

get_extreme_p <- function(z = stop("Provide a z statistic")) {
	if (!is.numeric(z))  stop("z needs to be numeric")
	log.pvalue   = log(2) + pnorm(abs(z), lower.tail = FALSE, log.p = TRUE)
	log10.pvalue = log.pvalue/log(10) ## from natural log to log10
	mantissa     = 10^(log10.pvalue %% 1)
	exponent     = log10.pvalue %/% 1
	## or return(c(mantissa,exponent))
	return(sprintf("p value is %1.2f times 10^(%d)",mantissa,exponent))
}


#' Get -log10 p-value
#'
#' @description Get -log10 p-value from a provided beta, se and n
#'
#' @return Returns a -log 10 p-value
#'
#' @author Internet person
#'
#' @name get_neglog10_p
#'
#' @param beta a beta/coefficient
#' @param se the corresponding standard error to the provided beta
#' @param n the sample size used to estimate the beta and se
#'
#' @examples
#' get_neglog10_p(beta, se, n)
#'
#' @export
#'

get_neglog10_p <- function(beta = stop("Provide a beta"), se = stop("Provide a se"), n = stop("Provide a n")) {
	if (!is.numeric(beta))  stop("beta needs to be numeric")
	if (!is.numeric(se))  stop("se needs to be numeric")
	if (!is.numeric(n))  stop("n needs to be numeric")
	neglog10_p=-1*(pt(abs(beta/se),df=n,lower.tail=F,log.p=T) + log(2))/log(10)
	neglog10_p
}