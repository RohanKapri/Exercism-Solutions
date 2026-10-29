GameOfLife :: {}.{
	step : List(List(U8)) -> List(List(U8))
	step = |grid|
		rows = List.len(grid)
		if rows == 0 then
			[]
		else
			cols = List.len(List.first(grid) |> Result.with_default([]))
			if cols == 0 then
				grid
			else
				List.map_with_index(grid, |row, r|
					List.map_with_index(row, |cell, c|
						live_neighbors = count_live_neighbors(grid, rows, cols, r, c)
						when cell is
							1 -> if live_neighbors == 2 or live_neighbors == 3 then 1 else 0
							_ -> if live_neighbors == 3 then 1 else 0
					)
				)

	count_live_neighbors = |grid, rows, cols, r, c|
		deltas = [
			(-1, -1), (-1, 0), (-1, 1),
			(0, -1),           (0, 1),
			(1, -1),  (1, 0),  (1, 1)
		]
		List.walk(deltas, 0, |acc, (dr, dc)|
			nr = Num.to_i64(r) + dr
			nc = Num.to_i64(c) + dc
			if nr >= 0 and nr < Num.to_i64(rows) and nc >= 0 and nc < Num.to_i64(cols) then
				row_opt = List.get(grid, Num.to_u64(nr))
				cell_val = match row_opt is
					Ok(row) -> List.get(row, Num.to_u64(nc)) |> Result.with_default(0)
					Err(_) -> 0
				acc + Num.to_u64(cell_val)
			else
				acc
		)
}