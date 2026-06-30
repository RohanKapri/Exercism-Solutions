rotate <- function(text, key){
  # assume the text is a string (character vector of length one)
  # assume the key is an integer between 0 and 26 (numeric vector of length one)

  # shortcut if no rotation
  if(key %in% c(0, 26))
    return(text)

  # replace every letter with a rotated letter
  rotated <- c(letters[(1:26 + (key-1)) %% 26 + 1])
  chartr(paste0(letters, LETTERS, collapse=''),
         paste0(rotated, toupper(rotated), collapse=''), 
         text)
}