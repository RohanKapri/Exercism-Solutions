GameOfLife :: {}.{
	State : [Dead, Alive]

	tick : List(List(State)) -> List(List(State))
	tick = |matrix|
		numRows = List.len matrix
		if numRows == 0 then
			[]
		else
			numCols = List.len (List.get matrix 0 |> Result.withDefault [])
			
			isAlive = |rI, cI|
				if rI < 0 or rI >= Num.toI64 numRows or cI < 0 or cI >= Num.toI64 numCols then
                    False
				else
					r = Num.toU64 rI
					c = Num.toU64 cI
					when List.get matrix r is
						Ok row ->
							when List.get row c is
								Ok Alive -> True
								_ -> False
						Err _ -> False

			countNeighbors = |rI, cI|
				directions = [
					(-1, -1), (-1, 0), (-1, 1),
					(0, -1),           (0, 1),
					(1, -1),  (1, 0),  (1, 1)
				]
				List.walk directions 0 |acc, (dr, dc)|
					nr = rI + dr
					nc = cI + dc
					if isAlive nr nc then
						acc + 1
					else
						acc

			List.mapWithIndex matrix |row, r|
				rI = Num.toI64 r
				List.mapWithIndex row |cell, c|
					cI = Num.toI64 c
					liveNeighbors = countNeighbors rI cI
					when cell is
						Alive ->
							if liveNeighbors == 2 or liveNeighbors == 3 then
								Alive
							else
								Dead
						Dead ->
							if liveNeighbors == 3 then
								Alive
							else
								Dead
}


