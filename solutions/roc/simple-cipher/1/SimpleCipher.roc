import random.Random

SimpleCipher := { key : Str }.{
	create : { key : Str } -> SimpleCipher
	create = |{ key }| {
		@SimpleCipher({ key })
	}

	create_random : { random_state : Random.State, key_length : U64 } -> { cipher : SimpleCipher, random_state : Random.State }
	create_random = |{ random_state, key_length }| {
		{ key, random_state: next_state } = generate_random_bytes(random_state, key_length, [])
		{
			cipher: @SimpleCipher({ key }),
			random_state: next_state,
		}
	}

	encode : SimpleCipher, Str -> Str
	encode = |@SimpleCipher({ key }), plaintext| {
		shift_text(plaintext, key, Encode)
	}

	decode : SimpleCipher, Str -> Str
	decode = |@SimpleCipher({ key }), ciphertext| {
		shift_text(ciphertext, key, Decode)
	}
}

generate_random_bytes : Random.State, U64, List U8 -> { key : Str, random_state : Random.State }
generate_random_bytes = |state, remaining, acc|
	if remaining == 0 then
		{
			key: Str.from_utf8(acc) |> Result.with_default(""),
			random_state: state,
		}
	else
		# ASCII 'a' (97) to 'z' (122)
		(char_code, next_state) = Random.step(Random.u32(97, 122), state)
		generate_random_bytes(next_state, remaining - 1, List.append(acc, Num.to_u8(char_code)))

shift_text : Str, Str, [Encode, Decode] -> Str
shift_text = |text, key, mode|
	text_bytes = Str.to_utf8(text)
	key_bytes = Str.to_utf8(key)
	key_len = List.len(key_bytes)

	if key_len == 0 then
		text
	else
		List.map_with_index(
			text_bytes,
			|char, index|
				key_char =
					List.get(key_bytes, index % key_len)
					|> Result.with_default('a')

				shift = Num.to_i16(key_char) - 97
				char_offset = Num.to_i16(char) - 97

				new_offset =
					when mode is
						Encode -> (char_offset + shift) % 26
						Decode -> ((char_offset - shift) % 26 + 26) % 26

				Num.to_u8(new_offset + 97),
		)
		|> Str.from_utf8
		|> Result.with_default("")