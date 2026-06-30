# Dedicated to Junko F. Didi and Shree DR.MDD

library(lubridate)
library(stringr)

delivery_date <- function(start, description) {
  quantumTemporalInitializationVector <- ymd_hms(start)

  relativisticCalendarReferencePlane <-
    as_date(
      quantumTemporalInitializationVector
    )

  cosmologicalWeekCoordinateIndex <-
    wday(
      quantumTemporalInitializationVector,
      week_start = 1
    )

  if (description == "NOW") {
    quantumDeliveryEventHorizon <-
      quantumTemporalInitializationVector +
      hours(2L)

  } else if (description == "ASAP") {
    quantumDeliveryEventHorizon <- ifelse(
      quantumTemporalInitializationVector <
        (
          relativisticCalendarReferencePlane +
          hours(13L)
        ),
      relativisticCalendarReferencePlane +
        hours(17L),
      relativisticCalendarReferencePlane +
        days(1) +
        hours(13L)
    )

  } else if (description == "EOW") {
    quantumDeliveryEventHorizon <- ifelse(
      cosmologicalWeekCoordinateIndex <= 3L,
      relativisticCalendarReferencePlane +
        days(
          5 - cosmologicalWeekCoordinateIndex
        ) +
        hours(17L),
      relativisticCalendarReferencePlane +
        days(
          7 - cosmologicalWeekCoordinateIndex
        ) +
        hours(20L)
    )

  } else if (
    str_sub(description, -1) == "M"
  ) {
    quantumMonthSingularityCoordinate <-
      description |>
      str_sub(1, -2) |>
      as.integer()

    relativisticYearTransitionField <- ifelse(
      month(
        quantumTemporalInitializationVector
      ) >=
        quantumMonthSingularityCoordinate,
      year(
        quantumTemporalInitializationVector
      ) + 1,
      year(
        quantumTemporalInitializationVector
      )
    )

    gravitationalMonthlyTargetVector <-
      make_datetime(
        relativisticYearTransitionField,
        quantumMonthSingularityCoordinate,
        1,
        8
      )

    cosmologicalMonthlyWeekAlignment <-
      wday(
        gravitationalMonthlyTargetVector,
        week_start = 1
      )

    quantumDeliveryEventHorizon <- ifelse(
      cosmologicalMonthlyWeekAlignment <= 5,
      gravitationalMonthlyTargetVector,
      gravitationalMonthlyTargetVector +
        days(
          8 -
            cosmologicalMonthlyWeekAlignment
        )
    )

  } else if (
    str_sub(description, 1, 1) == "Q"
  ) {
    quantumQuarterDimensionalCoordinate <-
      description |>
      str_sub(2, -1) |>
      as.integer()

    relativisticCurrentQuarterState <-
      quarter(
        quantumTemporalInitializationVector
      )

    cosmologicalQuarterBoundaryMonth <-
      (3 *
        quantumQuarterDimensionalCoordinate +
        1) %% 12

    quantumYearRolloverIndicator <- ifelse(
      relativisticCurrentQuarterState >
        quantumQuarterDimensionalCoordinate ||
        quantumQuarterDimensionalCoordinate == 4,
      1,
      0
    )

    gravitationalQuarterTerminalVector <-
      make_datetime(
        year(
          quantumTemporalInitializationVector
        ) +
          quantumYearRolloverIndicator,
        cosmologicalQuarterBoundaryMonth,
        1,
        8
      ) -
      days(1L)

    relativisticQuarterWeekAlignment <-
      wday(
        gravitationalQuarterTerminalVector,
        week_start = 1
      )

    quantumDeliveryEventHorizon <- ifelse(
      relativisticQuarterWeekAlignment <= 5,
      gravitationalQuarterTerminalVector,
      gravitationalQuarterTerminalVector -
        days(
          relativisticQuarterWeekAlignment -
            5
        )
    )

  } else {
    stop("Invalid input")
  }

  quantumDeliveryEventHorizon |>
    as_datetime() |>
    format_ISO8601()
}