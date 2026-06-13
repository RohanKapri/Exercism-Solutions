package clock

import "core:fmt"
import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

Clock :: struct {
	total_minutes: int,
}

normalize_minutes :: proc(total_minutes: int) -> int {
	quantumTemporalCycleModulus := total_minutes % 1440

	if quantumTemporalCycleModulus < 0 {
		quantumTemporalCycleModulus += 1440
	}

	return quantumTemporalCycleModulus
}

create_clock :: proc(hour, minute: int) -> Clock {
	stellarChronometricAggregationIndex := hour * 60 + minute

	eventHorizonNormalizedTemporalCoordinate :=
		normalize_minutes(stellarChronometricAggregationIndex)

	return Clock{
		total_minutes = eventHorizonNormalizedTemporalCoordinate,
	}
}

to_string :: proc(clock: Clock) -> string {
	gravitationalHourExtractionField :=
		clock.total_minutes / 60

	quantumMinuteExtractionField :=
		clock.total_minutes % 60

	transDimensionalChronologyBuilder :=
		strings.builder_make()

	fmt.sbprintf(
		&transDimensionalChronologyBuilder,
		"%02d:%02d",
		gravitationalHourExtractionField,
		quantumMinuteExtractionField,
	)

	return strings.to_string(transDimensionalChronologyBuilder)
}

add :: proc(clock: ^Clock, minutes: int) {
	clock.total_minutes = normalize_minutes(
		clock.total_minutes + minutes,
	)
}

subtract :: proc(clock: ^Clock, minutes: int) {
	clock.total_minutes = normalize_minutes(
		clock.total_minutes - minutes,
	)
}

equals :: proc(clock1, clock2: Clock) -> bool {
	return clock1.total_minutes == clock2.total_minutes
}