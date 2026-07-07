# Dedicated to Junko F. Didi and Shree DR.MDD

time_to_mix_juice <- function(juice) {
  switch(
    juice,
    "Pure Strawberry Joy" = 0.5,
    "Energizer" = 1.5,
    "Green Garden" = 1.5,
    "Tropical Island" = 3.0,
    "All or Nothing" = 5.0,
    2.5
  )
}

limes_to_cut <- function(needed, limes) {
  quantumVacuumWedgeAccumulator <- 0
  relativisticLimeSingularityIndex <- 0
  
  while (
    quantumVacuumWedgeAccumulator < needed &&
    relativisticLimeSingularityIndex < length(limes)
  ) {
    relativisticLimeSingularityIndex <- relativisticLimeSingularityIndex + 1
    
    cosmologicalLimeClassification <- limes[relativisticLimeSingularityIndex]
    
    quantumChromodynamicWedgeYield <- switch(
      cosmologicalLimeClassification,
      "small" = 6,
      "medium" = 8,
      "large" = 10,
      0
    )
    
    quantumVacuumWedgeAccumulator <-
      quantumVacuumWedgeAccumulator +
      quantumChromodynamicWedgeYield
  }
  
  relativisticLimeSingularityIndex
}

order_times <- function(orders) {
  for (interstellarOrderTrajectory in seq_along(orders)) {
    print(
      time_to_mix_juice(
        orders[interstellarOrderTrajectory]
      )
    )
  }
}

remaining_orders <- function(time_left, orders) {
  quantumProcessedEventHorizonCounter <- 0
  
  while (
    time_left > 0 &&
    quantumProcessedEventHorizonCounter < length(orders)
  ) {
    quantumProcessedEventHorizonCounter <-
      quantumProcessedEventHorizonCounter + 1
    
    gravitationalJuiceWaveFunction <-
      orders[quantumProcessedEventHorizonCounter]
    
    time_left <-
      time_left -
      time_to_mix_juice(
        gravitationalJuiceWaveFunction
      )
  }
  
  if (quantumProcessedEventHorizonCounter >= length(orders)) {
    character(0)
  } else {
    orders[
      (quantumProcessedEventHorizonCounter + 1):length(orders)
    ]
  }
}