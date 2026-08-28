package flowerfield

import "fmt"

var directions = [][2]int{
	{0, 1},
	{1, 0},
	{0, -1},
	{-1, 0},
	{1, 1},
	{1, -1},
	{-1, 1},
	{-1, -1},
}

func Annotate(board []string) []string {
	annotated := make([]string, len(board))
	copy(annotated, board)

	for y, row := range board {
		for x, cell := range row {
			if cell == ' ' {
				count := 0
				for direction := range directions {
					dx, dy := directions[direction][0], directions[direction][1]
					xx, yy := x+dx, y+dy
					if xx >= 0 && xx < len(row) && yy >= 0 && yy < len(board) && board[yy][xx] == '*' {
						count++
					}
				}

				if count > 0 {
					annotated[y] = annotated[y][:x] + fmt.Sprint(count) + annotated[y][x+1:]
				}
			}
		}
	}

	return annotated
}