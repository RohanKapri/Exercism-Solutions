TicTacToe :: {
	board : Board,
}.{
	Cell : [O, X, Empty]
	Row : (Cell, Cell, Cell)
	Board : (Row, Row, Row)
	State : [Win, Draw, Ongoing]

	create : Board -> Result TicTacToe [InvalidBoard]
	create = |board|
		if isValidBoard board then
			Ok @TicTacToe { board }
		else
			Err InvalidBoard

	state : TicTacToe -> State
	state = |@TicTacToe { board }|
		if hasWon board X or hasWon board O then
			Win
		else if isFull board then
			Draw
		else
			Ongoing

	flattenBoard : Board -> List Cell
	flattenBoard = |((a1, a2, a3), (b1, b2, b3), (c1, c2, c3))|
		[a1, a2, a3, b1, b2, b3, c1, c2, c3]

	countCells : Board -> { x : U64, o : U64 }
	countCells = |board|
		allCells = flattenBoard board
		List.walk allCells { x: 0, o: 0 } |counts, cell|
			when cell is
				X -> { counts & x: counts.x + 1 }
				O -> { counts & o: counts.o + 1 }
				Empty -> counts

	isWinningRow : Row, Cell -> Bool
	isWinningRow = |(c1, c2, c3), player|
		c1 == player and c2 == player and c3 == player

	hasWon : Board, Cell -> Bool
	hasWon = |board, player|
		((a1, a2, a3), (b1, b2, b3), (c1, c2, c3)) = board

		r1 = (a1, a2, a3)
		r2 = (b1, b2, b3)
		r3 = (c1, c2, c3)

		rowWin = isWinningRow r1 player or isWinningRow r2 player or isWinningRow r3 player
		colWin = isWinningRow (a1, b1, c1) player or isWinningRow (a2, b2, c2) player or isWinningRow (a3, b3, c3) player
		diagWin = isWinningRow (a1, b2, c3) player or isWinningRow (a3, b2, c1) player

		rowWin or colWin or diagWin

	isFull : Board -> Bool
	isFull = |board|
		allCells = flattenBoard board
		List.all allCells |cell|
			when cell is
				Empty -> False
				_ -> True

	isValidBoard : Board -> Bool
	isValidBoard = |board|
		counts = countCells board
		xWon = hasWon board X
		oWon = hasWon board O

		validCounts = counts.x == counts.o or counts.x == counts.o + 1

		if not validCounts then
			False
		else if xWon and oWon then
			False
		else if xWon and counts.x != counts.o + 1 then
			False
		else if oWon and counts.x != counts.o then
			False
		else
			True
}