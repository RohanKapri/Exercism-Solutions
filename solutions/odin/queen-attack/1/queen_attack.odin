package queen_attack
import "core:math"
Error :: enum {
	None,
	InvalidPosition,
	SameSquare,
	Unimplemented,
}
Queen :: [2]int
create :: proc(x, y: int) -> (Queen, Error) {
	if x < 0 || x > 7 || y < 0 || y > 7 do return Queen{}, .InvalidPosition
	return Queen{x, y}, .None
}
can_attack :: proc(white, black: Queen) -> (bool, Error) {
	if white == black do return false, .SameSquare
	same_row := white[0] == black[0]
	same_col := white[1] == black[1]
	dx := white[0] - black[0]
	dy := white[1] - black[1]
	same_diag := math.abs(dx) == math.abs(dy)
	return same_row || same_col || same_diag, .None
}