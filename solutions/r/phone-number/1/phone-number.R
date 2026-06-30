parse_phone_number <- function(number_string) {
    number = gsub("^1", '', gsub("\\D", '', number_string))
    if (nchar(number) == 10 & grepl('^[2-9].{2}[2-9]', number))
        return (number)
    return (NULL)
}