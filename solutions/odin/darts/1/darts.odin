package darts

import "core:math"

score :: proc(x, y: f64) -> int {
	dist := math.sqrt(x*x + y*y)
	if dist <= 1 {
		return 10
	}
	if dist <= 5 {
		return 5
	}
	if dist <= 10 {
		return 1
	}
	return 0
}