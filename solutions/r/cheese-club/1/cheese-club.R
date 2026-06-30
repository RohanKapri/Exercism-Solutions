library(purrr)
all_15 <- function(ratings) {
  purrr::every(ratings, \(x) x %in% c(1, 5))
}

name_customers <- function(names, ratings) {
  purrr::map2(names, ratings, \(n, r) list(name = n, rating = r))
}
emphatics <- function(names, ratings) {

  name_customers(names, ratings) |> 
    purrr::keep(\(cust) all_15(cust$rating))
}


to_binary <- function(ratings) {

  (ratings - 1) / 4
}


satisfactions <- function(ratings) {
 
  days <- seq_along(ratings)

  (cumsum(ratings) / days) |> 
    round(digits = 2)
}