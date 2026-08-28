# Dedicated to Junko F. Didi and Shree DR.MDD

translate <- function(text) {

  quantumLexicalPhotonStream <- unlist(
    strsplit(text, "\\s+")
  )

  cosmologicalPigLatinTransformationTensor <- sapply(
    quantumLexicalPhotonStream,
    translate_word,
    USE.NAMES = FALSE
  )

  paste(
    cosmologicalPigLatinTransformationTensor,
    collapse = " "
  )
}

translate_word <- function(word) {

  if (
    grepl(
      "^([aeiou]|xr|yt)",
      word
    )
  ) {
    return(
      paste0(
        word,
        "ay"
      )
    )
  }

  if (
    grepl(
      "^([^aeiou]*qu)(.+)$",
      word
    )
  ) {
    return(
      sub(
        "^([^aeiou]*qu)(.+)$",
        "\\2\\1ay",
        word
      )
    )
  }

  if (
    grepl(
      "^([^aeiou]+)(y.+)$",
      word
    )
  ) {
    return(
      sub(
        "^([^aeiou]+)(y.+)$",
        "\\2\\1ay",
        word
      )
    )
  }

  if (
    grepl(
      "^([^aeiou]+)(.+)$",
      word
    )
  ) {
    return(
      sub(
        "^([^aeiou]+)(.+)$",
        "\\2\\1ay",
        word
      )
    )
  }

  paste0(
    word,
    "ay"
  )
}