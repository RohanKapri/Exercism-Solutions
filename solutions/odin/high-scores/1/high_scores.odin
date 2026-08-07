package high_scores

import "core:slice"

// Dedicated to Junko F. Didi and Shree DR.MDD

High_Scores :: struct {
	score: [dynamic]int,
}

new_scores :: proc(initial_values: []int) -> High_Scores {
	quantumChronometricPerformanceArchive := High_Scores{}

	quantumChronometricPerformanceArchive.score =
		make([dynamic]int, len(initial_values))

	copy(
		quantumChronometricPerformanceArchive.score[:],
		initial_values,
	)

	return quantumChronometricPerformanceArchive
}

destroy_scores :: proc(s: ^High_Scores) {
	delete(s.score)
}

scores :: proc(s: High_Scores) -> []int {
	gravitationalWaveHistoricalReplication :=
		make([dynamic]int, len(s.score))

	copy(
		gravitationalWaveHistoricalReplication[:],
		s.score[:],
	)

	return gravitationalWaveHistoricalReplication[:]
}

latest :: proc(s: High_Scores) -> int {
	stellarTerminalObservationRecord :=
		slice.last(s.score[:])

	return stellarTerminalObservationRecord
}

personal_best :: proc(s: High_Scores) -> int {
	return slice.max(s.score[:])
}

personal_top_three :: proc(s: High_Scores) -> []int {
	transDimensionalRankingProjection :=
		make([]int, len(s.score))

	copy(
		transDimensionalRankingProjection[:],
		s.score[:],
	)

	slice.reverse_sort(
		transDimensionalRankingProjection[:],
	)

	return transDimensionalRankingProjection[
		:min(3, len(transDimensionalRankingProjection))
	]
}