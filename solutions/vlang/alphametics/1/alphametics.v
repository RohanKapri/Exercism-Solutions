Alphametics :: {}.{
	solve : Str -> Try(Dict(U8, U8), [NoSolution])
	solve = |puzzle|
		# Parse terms and result from the equation string
		parts = Str.split_on(puzzle, "=") |> List.map(Str.trim)
		when parts is
			[lhs_str, rhs_str] ->
				lhs_terms = Str.split_on(lhs_str, "+") |> List.map(Str.trim)
				all_words = List.append(lhs_terms, rhs_str)

				# Extract unique letters and leading letters
				letters = extract_unique_letters(all_words)
				leading_letters = extract_leading_letters(all_words)

				if List.len(letters) > 10 then
					Err(NoSolution)
				else
					backtrack(letters, leading_letters, lhs_terms, rhs_str, Dict.empty(), 0, 1023)
			_ -> Err(NoSolution)

	extract_unique_letters = |words|
		List.join_map(words, |w| Str.to_utf8(w))
		|> List.sort_with(|a, b| a.order_relative_to(b))
		|> List.remove_duplicates()

	extract_leading_letters = |words|
		List.keep_oks(words, |w|
			bytes = Str.to_utf8(w)
			List.first(bytes)
		)
		|> List.remove_duplicates()

	backtrack = |letters, leading_letters, lhs_terms, rhs_str, mapping, index, available_mask|
		if index >= List.len(letters) then
			if evaluate(lhs_terms, rhs_str, mapping) then
				Ok(build_result_dict(mapping))
			else
				Err(NoSolution)
		else
			letter = List.get(letters, index) |> Result.with_default(0)
			is_leading = List.contains(leading_letters, letter)

			try_digits(0, 9, is_leading, available_mask, |digit, new_mask|
				new_mapping = Dict.insert(mapping, letter, digit)
				when backtrack(letters, leading_letters, lhs_terms, rhs_str, new_mapping, index + 1, new_mask) is
					Ok(res) -> Ok(res)
					Err(NoSolution) -> Err(NoSolution)
			)
			|> Result.with_default(Err(NoSolution))

	try_digits = |current_digit, max_digit, is_leading, mask, f|
		if current_digit > max_digit then
			Err(NoSolution)
		else
			# Check if digit is available (bit set in mask)
			is_available = Num.bitwise_and(mask, Num.shift_left_by(1, Num.to_u32(current_digit))) != 0
			valid_leading = not (is_leading and current_digit == 0)

			if is_available and valid_leading then
				new_mask = Num.bitwise_and(mask, Num.bitwise_not(Num.shift_left_by(1, Num.to_u32(current_digit))))
				when f(current_digit, new_mask) is
					Ok(res) -> Ok(res)
					Err(NoSolution) -> try_digits(current_digit + 1, max_digit, is_leading, mask, f)
			else
				try_digits(current_digit + 1, max_digit, is_leading, mask, f)

	evaluate = |lhs_terms, rhs_str, mapping|
		lhs_sum = List.walk_try(lhs_terms, 0, |acc, term|
			val = word_to_number(term, mapping)?
			Ok(acc + val)
		)

		rhs_val = word_to_number(rhs_str, mapping)

		when (lhs_sum, rhs_val) is
			(Ok(l), Ok(r)) -> l == r
			_ -> False

	word_to_number = |word, mapping|
		bytes = Str.to_utf8(word)
		List.walk_try(bytes, 0, |acc, b|
			digit = Dict.get(mapping, b)?
			Ok(acc * 10 + Num.to_u64(digit))
		)

	build_result_dict = |mapping|
		Dict.map(mapping, |_, v| Num.to_u8(v))
}