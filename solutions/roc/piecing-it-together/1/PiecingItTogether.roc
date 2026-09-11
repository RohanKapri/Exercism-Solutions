JigsawPuzzle :: {
	pieces : U64,
	border : U64,
	inside : U64,
	rows : U64,
	columns : U64,
	aspectRatio : F64,
	format : [Portrait, Square, Landscape],
}.{
	PuzzleInput : {
		pieces : Result U64 [Missing],
		border : Result U64 [Missing],
		inside : Result U64 [Missing],
		rows : Result U64 [Missing],
		columns : Result U64 [Missing],
	}

	complete : PuzzleInput -> Result JigsawPuzzle [InsufficientInformation, Contradiction]
	complete = |input|
		# We can iteratively deduce rows and columns from pieces, border, inside, or aspect ratio.
		# For a grid of r rows and c columns:
		# pieces = r * c
		# border = 2 * r + 2 * c - 4 (if r >= 2 and c >= 2)
		# inside = (r - 2) * (c - 2)
		
		resolvedRows = when input.rows is
			Ok r -> Ok r
			Err _ ->
				when input.columns, input.pieces is
					Ok c, Ok p if c > 0 and p % c == 0 -> Ok (p / c)
					_, _ -> Err InsufficientInformation

		# Find columns
		resolvedColumns = when input.columns is
			Ok c -> Ok c
			Err _ ->
				when input.rows, input.pieces is
					Ok r, Ok p if r > 0 and p % r == 0 -> Ok (p / r)
					_, _ -> Err InsufficientInformation

		# If we have rows and columns, validate and compute the rest
		when resolvedRows, resolvedColumns is
			Ok r, Ok c ->
				if r < 2 or c < 2 then
					Err Contradiction
				else
					p = r * c
					b = 2 * r + 2 * c - 4
					i = (r - 2) * (c - 2)
					
					# Validate against provided inputs if any
					validPieces = when input.pieces is
						Ok val -> val == p
						Err _ -> True
					validBorder = when input.border is
						Ok val -> val == b
						Err _ -> True
					validInside = when input.inside is
						Ok val -> val == i
						Err _ -> True

					if not (validPieces and validBorder and validInside) then
						Err Contradiction
					else
						ar = Num.toF64 c / Num.toF64 r
						fmt = if ar < 1.0 then
							Portrait
						else if ar == 1.0 then
							Square
						else
							Landscape

						Ok {
							pieces: p,
							border: b,
							inside: i,
							rows: r,
							columns: c,
							aspectRatio: ar,
							format: fmt,
						}
			Err _, Err _ ->
				# Try alternative deductions using border and inside
				when input.border, input.inside, input.pieces is
					Ok b, Ok i, Ok p ->
						if b + i != p then
							Err Contradiction
						else
							# border = 2r + 2c - 4 => r + c = (b + 4) / 2
							# inside = (r - 2)(c - 2) = rc - 2r - 2c + 4 = p - b - 4 + 4 = p - b
							# Let's solve quadratic or search for r * c == p and 2r + 2c - 4 == b
							searchDimensions p b
					Ok b, Ok i, _ ->
						p = b + i
						searchDimensions p b
					_, _, _ ->
						Err InsufficientInformation

	searchDimensions : U64, U64 -> Result JigsawPuzzle [InsufficientInformation, Contradiction]
	searchDimensions = |p, b|
		# Helper to find rows and columns given total pieces p and border b
		targetSum = (b + 4) / 2
		findPair = |r|
			if r * r > p then
				Err InsufficientInformation
			else if p % r == 0 then
				c = p / r
				if r + c == targetSum then
					Ok (r, c)
				else
					findPair (r + 1)
			else
				findPair (r + 1)

		when findPair 1 is
			Ok (r, c) ->
				i = (r - 2) * (c - 2)
				ar = Num.toF64 c / Num.toF64 r
				fmt = if ar < 1.0 then
					Portrait
				else if ar == 1.0 then
					Square
				else
					Landscape
				Ok {
					pieces: p,
					border: b,
					inside: i,
					rows: r,
					columns: c,
					aspectRatio: ar,
					format: fmt,
				}
			Err _ -> Err Contradiction
}