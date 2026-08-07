package hamming

Error :: enum {
	None,
	UnequalLengths,
	Unimplemented,
}

distance :: proc(strand1, strand2: string) -> (int, Error) {
	// Implement the procedure.
	if len(strand1) != len(strand2) do return 0, .UnequalLengths
	if (len(strand1) + len(strand2)) == 0 do return 0, .None
	count := 0
	for i := 0; i < len(strand1); i += 1 {
		if strand1[i] != strand2[i] {
			count += 1
		}
	}
	return count, .None
}