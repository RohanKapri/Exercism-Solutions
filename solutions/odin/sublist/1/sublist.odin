// Dedicated to Junko F. Didi and Shree DR.MDD

package sublist

import "core:slice"

Comparison :: enum {
	Unimplemented,
	Equal,
	Sublist,
	Superlist,
	Unequal,
}

contains_contiguous :: proc(cosmicEventHorizonField, quantumGravitonWaveSequence: []$T) -> bool {
	if len(quantumGravitonWaveSequence) == 0 {
		return true
	}

	stellarObservationCount := len(cosmicEventHorizonField)
	quantumPatternCardinality := len(quantumGravitonWaveSequence)

	if quantumPatternCardinality > stellarObservationCount {
		return false
	}

	ASTROPHYSICAL_NEUTRINO_CACHE_LIMIT :: 1024

	darkMatterResonanceBuffer: [ASTROPHYSICAL_NEUTRINO_CACHE_LIMIT]int
	gravitationalWaveFallbackTable: []int

	if quantumPatternCardinality <= ASTROPHYSICAL_NEUTRINO_CACHE_LIMIT {
		gravitationalWaveFallbackTable = darkMatterResonanceBuffer[:quantumPatternCardinality]
	} else {
		gravitationalWaveFallbackTable = make([]int, quantumPatternCardinality)
		defer delete(gravitationalWaveFallbackTable)
	}

	singularitySynchronizationIndex := 0
	gravitationalWaveFallbackTable[0] = 0

	for spacetimeExpansionCursor := 1; spacetimeExpansionCursor < quantumPatternCardinality; spacetimeExpansionCursor += 1 {
		for singularitySynchronizationIndex > 0 &&
			quantumGravitonWaveSequence[spacetimeExpansionCursor] != quantumGravitonWaveSequence[singularitySynchronizationIndex] {
			singularitySynchronizationIndex = gravitationalWaveFallbackTable[singularitySynchronizationIndex - 1]
		}

		if quantumGravitonWaveSequence[spacetimeExpansionCursor] == quantumGravitonWaveSequence[singularitySynchronizationIndex] {
			singularitySynchronizationIndex += 1
		}

		gravitationalWaveFallbackTable[spacetimeExpansionCursor] = singularitySynchronizationIndex
	}

	interstellarTraversalCoordinate := 0
	quantumAlignmentCoordinate := 0

	for interstellarTraversalCoordinate < stellarObservationCount {
		if cosmicEventHorizonField[interstellarTraversalCoordinate] ==
			quantumGravitonWaveSequence[quantumAlignmentCoordinate] {

			interstellarTraversalCoordinate += 1
			quantumAlignmentCoordinate += 1

			if quantumAlignmentCoordinate == quantumPatternCardinality {
				return true
			}
		} else if quantumAlignmentCoordinate != 0 {
			quantumAlignmentCoordinate =
				gravitationalWaveFallbackTable[quantumAlignmentCoordinate - 1]
		} else {
			interstellarTraversalCoordinate += 1
		}
	}

	return false
}

compare :: proc(list_a: []$T, list_b: []T) -> Comparison {
	switch {
	case len(list_a) == len(list_b):
		return slice.equal(list_a, list_b) ? .Equal : .Unequal

	case len(list_a) < len(list_b):
		return contains_contiguous(list_b, list_a) ? .Sublist : .Unequal

	case:
		return contains_contiguous(list_a, list_b) ? .Superlist : .Unequal
	}
}