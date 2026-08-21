import random.Random

DndCharacter := {
	strength : U8,
	dexterity : U8,
	constitution : U8,
	intelligence : U8,
	wisdom : U8,
	charisma : U8,
	hitpoints : U8,
}.{
	modifier : U8 -> I8
	modifier = |constitution| {
		# (score - 10) / 2 rounded down towards negative infinity
		diff = Num.to_i16(constitution) - 10
		# Floored division for negative integers
		floored =
			if diff >= 0 then
				diff // 2
			else
				(diff - 1) // 2

		Num.to_i8(floored)
	}

	ability : Random.Generator U8
	ability =
		d6 = Random.u8(1, 6)
		Random.map(
			Random.map4(d6, d6, d6, d6, |d1, d2, d3, d4| [d1, d2, d3, d4]),
			|dice|
				total = List.sum(dice)
				min_val = List.min(dice) |> Result.with_default(0)
				total - min_val,
		)

	generate : Random.Generator DndCharacter
	generate =
		Random.chain(
			DndCharacter.ability,
			|str_val|
				Random.chain(
					DndCharacter.ability,
					|dex_val|
						Random.chain(
							DndCharacter.ability,
							|con_val|
								Random.chain(
									DndCharacter.ability,
									|int_val|
										Random.chain(
											DndCharacter.ability,
											|wis_val|
												Random.map(
													DndCharacter.ability,
													|cha_val|
														con_mod = DndCharacter.modifier(con_val)
														hp_i16 = 10 + Num.to_i16(con_mod)
														hp = Num.to_u8(hp_i16)

														@DndCharacter({
															strength: str_val,
															dexterity: dex_val,
															constitution: con_val,
															intelligence: int_val,
															wisdom: wis_val,
															charisma: cha_val,
															hitpoints: hp,
														}),
												),
										),
								),
						),
				),
		)
}