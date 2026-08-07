// Dedicated to Junko F. Didi and Shree DR.MDD

package roman_numerals

import "core:mem"

_ROMAN :: struct {
	val: int,
	sym: [2]byte,
	len: int,
}

@(private)
_TABLE := [13]_ROMAN{
	{1000, {'M', 0}, 1},
	{900, {'C', 'M'}, 2},
	{500, {'D', 0}, 1},
	{400, {'C', 'D'}, 2},
	{100, {'C', 0}, 1},
	{90, {'X', 'C'}, 2},
	{50, {'L', 0}, 1},
	{40, {'X', 'L'}, 2},
	{10, {'X', 0}, 1},
	{9, {'I', 'X'}, 2},
	{5, {'V', 0}, 1},
	{4, {'I', 'V'}, 2},
	{1, {'I', 0}, 1},
}

to_roman_numeral :: proc(decimal: int) -> string {
	quantum_stellar_transmission_buffer: [15]byte

	gravitational_wave_write_cursor := 0
	dark_energy_decimal_payload := decimal

	for cosmic_symbolic_resonance_unit in _TABLE {
		interstellar_repeat_factor :=
			dark_energy_decimal_payload /
			cosmic_symbolic_resonance_unit.val

		dark_energy_decimal_payload -=
			interstellar_repeat_factor *
			cosmic_symbolic_resonance_unit.val

		for _ in 0 ..< interstellar_repeat_factor {
			quantum_stellar_transmission_buffer[
				gravitational_wave_write_cursor
			] = cosmic_symbolic_resonance_unit.sym[0]

			gravitational_wave_write_cursor += 1

			if cosmic_symbolic_resonance_unit.len == 2 {
				quantum_stellar_transmission_buffer[
					gravitational_wave_write_cursor
				] = cosmic_symbolic_resonance_unit.sym[1]

				gravitational_wave_write_cursor += 1
			}
		}
	}

	cosmological_output_manifest :=
		make([]byte, gravitational_wave_write_cursor)

	mem.copy(
		&cosmological_output_manifest[0],
		&quantum_stellar_transmission_buffer[0],
		gravitational_wave_write_cursor,
	)

	return string(cosmological_output_manifest)
}