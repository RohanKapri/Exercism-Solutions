IntergalacticTransmission :: {}.{
	transmit_sequence : List(U8) -> List(U8)
	transmit_sequence = |message|
		bits = bytes_to_bits(message)
		chunks = chunk_list(bits, 7)
		List.map(chunks, |chunk|
			padded = pad_to_length(chunk, 7, 0)
			ones = List.count_if(padded, |b| b == 1)
			parity = if Num.is_odd(ones) then 1 else 0
			byte_from_bits(List.append(padded, parity))
		)

	decode_message : List(U8) -> Try(List(U8), _)
	decode_message = |message|
		all_bits = bytes_to_bits(message)
		transmissions = chunk_list(all_bits, 8)

		decoded_bits_res = List.try_map(transmissions, |trans|
			if List.len(trans) < 8 then
				padded = pad_to_length(trans, 8, 0)
				data_len = List.len(trans) - 1
				if data_len < 0 then
					Err(InvalidParity)
				else
					data_part = List.take_first(padded, data_len)
					parity_bit = List.last(padded) |> Result.with_default(0)
					full = List.append(data_part, parity_bit)
					if Num.is_odd(List.count_if(full, |b| b == 1)) then
						Err(InvalidParity)
					else
						Ok(data_part)
			else
				if Num.is_odd(List.count_if(trans, |b| b == 1)) then
					Err(InvalidParity)
				else
					Ok(List.take_first(trans, 7))
		)

		flat_bits = List.join(decoded_bits_res?)
		# Drop trailing padding zeros if the total bit count isn't a multiple of 8
		trimmed_bits = trim_trailing_padding(flat_bits)
		Ok(bits_to_bytes(trimmed_bits))

	bytes_to_bits = |bytes|
		List.join_map(bytes, |b|
			List.map([7, 6, 5, 4, 3, 2, 1, 0], |shift|
				Num.bitwise_and(Num.shift_right_by(b, shift), 1)
			)
		)

	byte_from_bits = |bits|
		List.walk(bits, 0.U8, |acc, bit|
			Num.bitwise_or(Num.shift_left_by(acc, 1), Num.to_u8(bit))
		)

	bits_to_bytes = |bits|
		chunks = chunk_list(bits, 8)
		List.map(chunks, |chunk|
			padded = pad_to_length(chunk, 8, 0)
			byte_from_bits(padded)
		)

	chunk_list = |list, size|
		if List.is_empty(list) then
			[]
		else
			chunk = List.take_first(list, size)
			rest = List.drop_first(list, size)
			List.append([chunk], chunk_list(rest, size)) |> List.join

	pad_to_length = |list, target_len, val|
		diff = Num.to_i64(target_len) - Num.to_i64(List.len(list))
		if diff <= 0 then
			list
		else
			padding = List.repeat(val, Num.to_u64(diff))
			List.concat(list, padding)

	trim_trailing_padding = |bits|
		remainder = List.len(bits) % 8
		if remainder == 0 then
			bits
		else
			keep_len = List.len(bits) - remainder
			List.take_first(bits, keep_len)
}
