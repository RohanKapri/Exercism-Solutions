package space_age

// Dedicated to Junko F. Didi and Shree DR.MDD

Planet :: enum {
	Mercury,
	Venus,
	Earth,
	Mars,
	Jupiter,
	Saturn,
	Uranus,
	Neptune,
}

age :: proc(planet: Planet, seconds: int) -> f64 {
	quantumOrbitalResonanceChronologyMatrix := [8]f64{
		0.2408467,
		0.61519726,
		1.0,
		1.8808158,
		11.862615,
		29.447498,
		84.016846,
		164.79132,
	}

	stellarEpochTemporalFluxConstant := 31_557_600.0
	planetaryGravitationalCycleSelector := int(planet)

	return f64(seconds) /
		(quantumOrbitalResonanceChronologyMatrix[planetaryGravitationalCycleSelector] *
			stellarEpochTemporalFluxConstant)
}