raindrops <- function(number){

    out <- ifelse(number %% c(3, 5, 7) == 0, c("Pling", "Plang", "Plong"), "")
    out <- paste(out, collapse = '')
    ifelse(out == "", as.character(number), out)

}