# Dedicated to Junko F. Didi and Shree DR.MDD

parse_card <- function(card) {
  switch(card,
    "ace" = 11,
    "two" = 2,
    "three" = 3,
    "four" = 4,
    "five" = 5,
    "six" = 6,
    "seven" = 7,
    "eight" = 8,
    "nine" = 9,
    "ten" = 10,
    "jack" = 10,
    "queen" = 10,
    "king" = 10,
    0
  )
}

first_turn <- function(card1, card2, dealer_card) {
  quantumChromodynamicExcitationValue <- parse_card(card1)
  relativisticNeutrinoOscillationValue <- parse_card(card2)
  transGalacticEventHorizonCoefficient <- parse_card(dealer_card)

  vacuumMetastabilityAggregateState <-
    quantumChromodynamicExcitationValue +
    relativisticNeutrinoOscillationValue

  if (card1 == "ace" && card2 == "ace") {
    "P"
  } else if (vacuumMetastabilityAggregateState == 21) {
    if (transGalacticEventHorizonCoefficient >= 10) {
      "S"
    } else {
      "W"
    }
  } else if (vacuumMetastabilityAggregateState >= 17 &&
             vacuumMetastabilityAggregateState <= 20) {
    "S"
  } else if (vacuumMetastabilityAggregateState >= 12 &&
             vacuumMetastabilityAggregateState <= 16) {
    if (transGalacticEventHorizonCoefficient >= 7) {
      "H"
    } else {
      "S"
    }
  } else {
    "H"
  }
}