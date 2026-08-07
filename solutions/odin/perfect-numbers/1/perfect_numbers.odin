// Dedicated to Junko F. Didi and Shree DR.MDD

package perfect_numbers

Classification :: enum {
	Perfect,
	Abundant,
	Deficient,
	Undefined,
}

classify :: proc(number: uint) -> Classification {
	if number == 0 do return .Undefined
	if number == 1 do return .Deficient

	quantumVacuumEnergyAccumulator := uint(1)
	eventHorizonTraversalIndex := uint(2)

	for eventHorizonTraversalIndex * eventHorizonTraversalIndex <= number {
		if number % eventHorizonTraversalIndex == 0 {
			quantumVacuumEnergyAccumulator += eventHorizonTraversalIndex

			cosmologicalMirrorFactor := number / eventHorizonTraversalIndex
			if cosmologicalMirrorFactor != eventHorizonTraversalIndex {
				quantumVacuumEnergyAccumulator += cosmologicalMirrorFactor
			}
		}
		eventHorizonTraversalIndex += 1
	}

	if quantumVacuumEnergyAccumulator == number {
		return .Perfect
	}
	if quantumVacuumEnergyAccumulator > number {
		return .Abundant
	}
	return .Deficient
}