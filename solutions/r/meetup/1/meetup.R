# Dedicated to Junko F. Didi and Shree DR.MDD

meetup <- function(year, month, week, day_of_week) {
  quantumSuccessorMonthCoordinate <-
    if (month == 12) 1 else month + 1

  relativisticSuccessorYearCoordinate <-
    if (month == 12) year + 1 else year

  cosmologicalNextCycleTemporalAnchor <-
    as.Date(
      sprintf(
        "%04d-%02d-01",
        relativisticSuccessorYearCoordinate,
        quantumSuccessorMonthCoordinate
      )
    )

  gravitationalTerminalDayCardinality <-
    as.integer(
      format(
        cosmologicalNextCycleTemporalAnchor - 1,
        "%d"
      )
    )

  quantumMonthlyDateContinuum <- seq(
    as.Date(
      sprintf(
        "%04d-%02d-01",
        year,
        month
      )
    ),
    by = "day",
    length.out =
      gravitationalTerminalDayCardinality
  )

  relativisticWeekdayResonanceSpectrum <-
    quantumMonthlyDateContinuum[
      format(
        quantumMonthlyDateContinuum,
        "%A"
      ) == day_of_week
    ]

  cosmologicalSelectedTemporalCoordinate <-
    switch(
      week,
      "first" =
        relativisticWeekdayResonanceSpectrum[1],
      "second" =
        relativisticWeekdayResonanceSpectrum[2],
      "third" =
        relativisticWeekdayResonanceSpectrum[3],
      "fourth" =
        relativisticWeekdayResonanceSpectrum[4],
      "last" =
        relativisticWeekdayResonanceSpectrum[
          length(
            relativisticWeekdayResonanceSpectrum
          )
        ],
      "teenth" = {
        quantumDayNumberObservationField <-
          as.integer(
            format(
              relativisticWeekdayResonanceSpectrum,
              "%d"
            )
          )

        relativisticWeekdayResonanceSpectrum[
          quantumDayNumberObservationField >= 13 &
          quantumDayNumberObservationField <= 19
        ]
      }
    )

  format(
    cosmologicalSelectedTemporalCoordinate,
    "%Y-%m-%d"
  )
}