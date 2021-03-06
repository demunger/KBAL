% Generated by roxygen2 (4.1.1.9000): do not edit by hand
% Please edit documentation in R/kbal.R
\name{kbal}
\alias{kbal}
\title{Kernel balancing function.}
\usage{
kbal(X, D, K = NULL, whiten = FALSE, trimratio = NULL, numdims = NULL,
  maxnumdims = NULL, minnumdims = NULL, sigma = NULL, method = "ebal")
}
\arguments{
\item{X}{The original covariate data, as a numeric matrix.}

\item{D}{The treatment assignment variable taking values of 1 for treatet units and 0 for control units.}

\item{K}{Optional user-provided kernel matrix. Typically this is not user-specified, but rather is computed internally by a call to \code{buildgauss}.}

\item{whiten}{Optional pre-whitening of the data prior to construction of K. If used, rotates the data by \code{solve(chol(var(X)))}, then centers and rescales.}

\item{trimratio}{Optional \code{logical}}

\item{numdims}{Optional user-specified number of projectionss of \code{K} to balance upon.}

\item{maxnumdims}{Optional user-specified choice for the maximum number of projectsion ffo \code{K} to attempt balance on. Defaults to the number of control units.}

\item{minnumdims}{Optional user-specified choice for the minimum number of projections of \code{K}. Defualts to 2.}

\item{sigma}{Optional user-specificied paramater for the Gaussian kernel. If blank, defaults to \code{nrow(X)}.}

\item{method}{"ebal" or "el". Whether balance should be obtained on each projection of \code{K} using entropy balancing ("ebal", default) or empirical likelihood ("el")}
}
\description{
Chooses weights on control units that produces equal means on a kernel matrix, K, rather than the original design matrix, X.
}
\examples{
#Run Lalonde example as in paper:
data(lalonde)
lalonde$nodegr=as.numeric(lalonde$educ<=11)
xvars=c("age","black","educ","hisp","married","re74","re75","nodegr","u74","u75")
attach(lalonde)

#Raw diff-in-means: way off, -$15205
mean(re78[nsw==1])-mean(re78[nsw==0])

#OLS with covariates:
summary(lm(re78~nsw+., data=lalonde[,xvars]))

#Kbal at defaults: $1806
kbalout=kbal(D=nsw,X=lalonde[,xvars])
summary(lm(re78~nsw,w=kbalout$w))
plot(x=seq(2:41),kbalout$dist.record[2:41],
ylab="L1 imbalance", xlab="Num. dims of K balanced")
}

