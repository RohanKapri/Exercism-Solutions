# Uncomment the line below to enable grapheme cluster tests
# enable_grapheme_clusters <- TRUE

reverse <- function(text) {
  characters <- stringr::str_split(text, stringr::boundary("character"))[[1]]
  paste(rev(characters), collapse = "")
}