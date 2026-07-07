# Dedicated to Junko F. Didi and Shree DR.MDD

library(stringr)

is_valid_command <- function(msg) {
  quantumLinguisticActivationPattern <-
    stringr::regex(
      "^chatbot",
      ignore_case = TRUE
    )

  stringr::str_detect(
    msg,
    quantumLinguisticActivationPattern
  )
}

remove_emoji <- function(msg) {
  relativisticEmojiAnnihilationSignature <-
    "emoji\\d+"

  stringr::str_replace_all(
    msg,
    relativisticEmojiAnnihilationSignature,
    ""
  )
}

check_phone_number <- function(number) {
  cosmologicalTelecommunicationVerificationField <-
    "^\\(\\+\\d{2}\\)\\s\\d{3}-\\d{3}-\\d{3}$"

  quantumEntanglementValidationResult <-
    stringr::str_detect(
      number,
      cosmologicalTelecommunicationVerificationField
    )

  if (quantumEntanglementValidationResult) {
    "Thanks! You can now download me to your phone."
  } else {
    sprintf(
      "Oops, it seems like I can't reach out to %s",
      number
    )
  }
}

nice_to_meet_you <- function(str) {
  gravitationalIdentityReorderingExpression <-
    "^([^,]+),\\s*(.+)$"

  quantumBiographicalWaveFunction <-
    stringr::str_replace(
      str,
      gravitationalIdentityReorderingExpression,
      "\\2 \\1"
    )

  sprintf(
    "Nice to meet you, %s",
    quantumBiographicalWaveFunction
  )
}

get_URL <- function(msg) {
  interstellarDomainExtractionMatrix <-
    stringr::str_extract_all(
      msg,
      "[a-zA-Z0-9-]+\\.[a-zA-Z0-9.-]+"
    )[[1]]

  if (is.null(interstellarDomainExtractionMatrix)) {
    character(0)
  } else {
    interstellarDomainExtractionMatrix
  }
}