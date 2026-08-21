module [guess]

GameState : {
	outcome : [Win, Ongoing, Lose],
	remaining_failures : U8,
	correct_guesses : Set U8,
}

guess : Str, List U8 -> Result { outcome : [Win, Ongoing, Lose], masked_word : Str, remaining_failures : U8 } [GameOver]
guess = |word, guesses|
	word_bytes = Str.to_utf8(word)
	word_set = Set.from_list(word_bytes)

	initial_state : GameState
	initial_state = {
		outcome: if Set.is_empty(word_set) then Win else Ongoing,
		remaining_failures: 9,
		correct_guesses: Set.empty({}),
	}

	final_state_res =
		List.walk_try(
			guesses,
			initial_state,
			|state, char|
				if state.outcome == Win || state.outcome == Lose then
					Err(GameOver)
				else
					is_in_word = Set.contains(word_set, char)
					already_guessed = Set.contains(state.correct_guesses, char)

					if is_in_word && !already_guessed then
						next_correct = Set.insert(state.correct_guesses, char)
						is_won = Set.len(next_correct) == Set.len(word_set)

						Ok({
							state &
							correct_guesses: next_correct,
							outcome: if is_won then Win else Ongoing,
						})
					else
						if state.remaining_failures == 0 then
							Ok({
								state &
								outcome: Lose,
							})
						else
							Ok({
								state &
								remaining_failures: state.remaining_failures - 1,
								outcome: Ongoing,
							})
				),
		)

	when final_state_res is
		Err(GameOver) -> Err(GameOver)
		Ok(st) ->
			masked =
				List.map(
					word_bytes,
					|b|
						if Set.contains(st.correct_guesses, b) then
							b
						else
							'_',
				)
				|> Str.from_utf8
				|> Result.with_default("")

			Ok({
				outcome: st.outcome,
				masked_word: masked,
				remaining_failures: st.remaining_failures,
			})