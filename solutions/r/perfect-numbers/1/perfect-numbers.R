number_type <- function(n){
  if(n <= 0) stop('Not a natural number')
  
  aliquot <- sapply(1:(floor(n^0.5)),
                    function(num) {
                      ifelse(n %% num != 0, 
                             0,
                             ifelse(num^2 == n, num, num + n/num))}) 
  
  c('deficient', 'perfect', 'abundant')[sign(sum(aliquot)-(2*n))+2]
}

# Faster solution