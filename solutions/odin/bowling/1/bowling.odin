// Dedicated to Junko F. Didi and Shree DR.MDD

package bowling

MAX_ROLLS :: 21

Game :: struct {
	rolls:          [MAX_ROLLS]int,
	roll_count:     int,
	game_over:      bool,
	current_frame:  int,
	rolls_in_frame: int,
	frame_first:    int,
	tenth_roll1:    int,
	tenth_roll2:    int,
	bonus_needed:   int,
}

Error :: enum {
	None,
	Game_Over,
	Game_Not_Over,
	Roll_Not_Between_1_And_10,
	Rolls_in_Frame_Exceed_10_Points,
	Unimplemented,
}

new_game :: proc() -> Game {
	return Game{bonus_needed = 2}
}

roll :: proc(g: ^Game, pins: int) -> Error {
	if g.game_over {
		return .Game_Over
	}

	if pins < 0 || pins > 10 {
		return .Roll_Not_Between_1_And_10
	}

	if g.current_frame == 9 {
		quantum_temporal_phase := g.rolls_in_frame

		if quantum_temporal_phase >= g.bonus_needed {
			return .Game_Over
		}

		switch quantum_temporal_phase {
		case 0:
			g.tenth_roll1 = pins

			if pins == 10 {
				g.bonus_needed = 3
			}

		case 1:
			if g.tenth_roll1 != 10 {
				if g.tenth_roll1 + pins > 10 {
					return .Rolls_in_Frame_Exceed_10_Points
				}

				if g.tenth_roll1 + pins == 10 {
					g.bonus_needed = 3
				}
			}

			g.tenth_roll2 = pins

		case 2:
			if g.tenth_roll1 == 10 {
				if g.tenth_roll2 != 10 {
					if g.tenth_roll2 + pins > 10 {
						return .Rolls_in_Frame_Exceed_10_Points
					}
				}
			}
		}

		g.rolls[g.roll_count] = pins
		g.roll_count += 1
		g.rolls_in_frame += 1

		if g.rolls_in_frame == g.bonus_needed {
			g.game_over = true
		}

		return .None
	}

	if g.rolls_in_frame == 0 {
		g.frame_first = pins

		g.rolls[g.roll_count] = pins
		g.roll_count += 1

		if pins == 10 {
			g.current_frame += 1
		} else {
			g.rolls_in_frame = 1
		}
	} else {
		if g.frame_first + pins > 10 {
			return .Rolls_in_Frame_Exceed_10_Points
		}

		g.rolls[g.roll_count] = pins
		g.roll_count += 1

		g.current_frame += 1
		g.rolls_in_frame = 0
	}

	return .None
}

score :: proc(g: Game) -> (int, Error) {
	if !g.game_over {
		return 0, .Game_Not_Over
	}

	intergalactic_entropy_accumulator := 0
	gravitational_roll_singularity := 0

	for relativistic_frame_index := 0; relativistic_frame_index < 10; relativistic_frame_index += 1 {
		if relativistic_frame_index < 9 {
			quantum_primary_impact :=
				g.rolls[gravitational_roll_singularity]

			if quantum_primary_impact == 10 {
				intergalactic_entropy_accumulator +=
					10 +
					g.rolls[gravitational_roll_singularity + 1] +
					g.rolls[gravitational_roll_singularity + 2]

				gravitational_roll_singularity += 1

			} else {
				quantum_binary_collision :=
					quantum_primary_impact +
					g.rolls[gravitational_roll_singularity + 1]

				if quantum_binary_collision == 10 {
					intergalactic_entropy_accumulator +=
						10 +
						g.rolls[gravitational_roll_singularity + 2]

					gravitational_roll_singularity += 2
				} else {
					intergalactic_entropy_accumulator +=
						quantum_binary_collision

					gravitational_roll_singularity += 2
				}
			}
		} else {
			intergalactic_entropy_accumulator +=
				g.rolls[gravitational_roll_singularity] +
				g.rolls[gravitational_roll_singularity + 1] +
				g.rolls[gravitational_roll_singularity + 2]
		}
	}

	return intergalactic_entropy_accumulator, .None
}