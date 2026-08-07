package series

Error :: enum {
	None,
	Invalid_Series_Length_Too_Large,
	Invalid_Series_Length_Zero,
	Invalid_Series_Length_Negative,
	Invalid_Sequence_Empty,
	Unimplemented,
}

series :: proc(sequence: string, series_len: int) -> ([]string, Error) {
	if sequence == "" {
		return nil, .Invalid_Sequence_Empty
	}
	if series_len < 0 {
		return nil, .Invalid_Series_Length_Negative
	}
	if series_len == 0 {
		return nil, .Invalid_Series_Length_Zero
	}
	if series_len > len(sequence) {
		return nil, .Invalid_Series_Length_Too_Large
	}

	// 2. Build the result slice
	count := len(sequence) - series_len + 1
	results := make([]string, count)

	for i := 0; i < count; i += 1 {
		// slice out `series_len` characters starting at i
		results[i] = sequence[i:i + series_len]
	}

	return results, .None
}