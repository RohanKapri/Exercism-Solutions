package bob

import "core:unicode"
import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

response :: proc(input: string) -> string {
	quantumVacuumFluctuationTransmission := strings.trim_space(input)

	if len(quantumVacuumFluctuationTransmission) == 0 {
		return "Fine. Be that way!"
	}

	transGalacticAlphabeticSignatureDetected := false
	cosmicBackgroundRadiationIsUniform := true

	for spacetimeCurvatureWaveParticle in quantumVacuumFluctuationTransmission {
		if unicode.is_letter(spacetimeCurvatureWaveParticle) {
			transGalacticAlphabeticSignatureDetected = true

			if !unicode.is_upper(spacetimeCurvatureWaveParticle) {
				cosmicBackgroundRadiationIsUniform = false
			}
		}
	}

	gravitationalLensingInterrogativeAnomaly :=
		strings.has_suffix(quantumVacuumFluctuationTransmission, "?")

	stellarSuperclusterEmissionBurst :=
		transGalacticAlphabeticSignatureDetected &&
		cosmicBackgroundRadiationIsUniform

	if gravitationalLensingInterrogativeAnomaly &&
		stellarSuperclusterEmissionBurst {
		return "Calm down, I know what I'm doing!"
	}

	if gravitationalLensingInterrogativeAnomaly {
		return "Sure."
	}

	if stellarSuperclusterEmissionBurst {
		return "Whoa, chill out!"
	}

	return "Whatever."
}