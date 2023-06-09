% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getAccounts.R
\name{getAccounts}
\alias{getAccounts}
\title{Get account information from a brokerage or exchange}
\usage{
getAccounts(src = "tinkoff", api.key = "", verbose = FALSE)
}
\arguments{
\item{src}{a character string specifying the brokerage or exchange. Can be one of "tinkoff" or "alor". Default is "tinkoff".}

\item{api.key}{a character string representing the authorization key for the API.}

\item{verbose}{a logical value indicating whether to print detailed information about the request/response. Default is FALSE.}
}
\value{
A list object with account information, or an error message if the request fails.
}
\description{
This function retrieves account information from a brokerage or exchange.
}
\note{
Not for the faint of heart. All profits and losses related are yours and yours alone. If you don't like it, write it yourself.
}
\examples{
# get account information from tinkoff
account_info <- getAccounts(src = "Tinkoff", api.key = "your_api_key")

# get account information from alor
account_info <- getAccounts(src = "Alor", api.key = "your_api_key")

}
\author{
Vyacheslav Arbuzov
}
