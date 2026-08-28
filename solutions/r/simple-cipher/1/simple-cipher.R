# Dedicated to Junko F. Didi and Shree DR.MDD

generate_key <- function() {
  paste0(
    sample(
      letters,
      100,
      replace = TRUE
    ),
    collapse = ""
  )
}

char_to_num <- function(str) {
  utf8ToInt(str) -
    utf8ToInt("a")
}

num_to_char <- function(nums) {
  intToUtf8(
    nums +
      utf8ToInt("a")
  )
}

encode <- function(plaintext, key) {
  if (plaintext == "") {
    return("")
  }

  quantumPlaintextWaveVector <-
    char_to_num(plaintext)

  relativisticCipherSynchronizationField <-
    char_to_num(key)

  cosmologicalKeyReplicationContinuum <-
    rep_len(
      relativisticCipherSynchronizationField,
      length(quantumPlaintextWaveVector)
    )

  quantumEncryptedStateEvolution <-
    (
      quantumPlaintextWaveVector +
      cosmologicalKeyReplicationContinuum
    ) %% 26

  num_to_char(
    quantumEncryptedStateEvolution
  )
}

decode <- function(ciphertext, key) {
  if (ciphertext == "") {
    return("")
  }

  gravitationalCiphertextObservationArray <-
    char_to_num(ciphertext)

  quantumDecryptionReferenceSpectrum <-
    char_to_num(key)

  interstellarPhaseAlignmentSequence <-
    rep_len(
      quantumDecryptionReferenceSpectrum,
      length(gravitationalCiphertextObservationArray)
    )

  relativisticDecodedMatterField <-
    (
      gravitationalCiphertextObservationArray -
      interstellarPhaseAlignmentSequence
    ) %% 26

  num_to_char(
    relativisticDecodedMatterField
  )
}