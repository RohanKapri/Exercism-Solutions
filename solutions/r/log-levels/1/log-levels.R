
message <- function(msg) {

  parts <- unlist(strsplit(msg, "]: "))
  trimws(parts[2], whitespace = "[ \t\r\n]")
} 

log_level <- function(msg) {

  level <- regmatches(msg, regexec("\\[([A-Z]+)\\]", msg))[[1]][2]
  tolower(level)
} 


reformat <- function(msg) {
 
  sprintf("%s (%s)", message(msg), log_level(msg))
}