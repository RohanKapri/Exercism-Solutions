collatz_step_counter <- function(num) {
  csc <- function(n) {
    if (n <= 0) stop("Input must be a positive integer.")
  
    iter <- 0 
    while (n != 1) {
      n <- ifelse(n %% 2 == 0, n / 2, n * 3 + 1)
      iter <- iter + 1
    }
  
    iter
  }
  
  sapply(num, csc)
}