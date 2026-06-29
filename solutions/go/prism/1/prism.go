package prism

import "math"

type Position struct {
	x     float64
	y     float64
	angle float64
}

type Prism struct {
	id    int
	x     float64
	y     float64
	angle float64
}

func normalizeAngle(a float64) float64 {
	a = math.Mod(a, 360)
	if a < 0 {
		a += 360
	}
	return a
}

func angleDifference(a1, a2 float64) float64 {
	diff := math.Abs(a1 - a2)
	if diff > 180 {
		diff = 360 - diff
	}
	return diff
}

func FindSequence(start Position, prisms []Prism) []int {
	sequence := []int{}
	x, y := start.x, start.y
	angle := normalizeAngle(start.angle)

	for {
		minDistance := math.Inf(1)
		var nextID int
		var nextX, nextY, nextAngle float64
		found := false

		for _, prism := range prisms {
			dx := prism.x - x
			dy := prism.y - y

			if dx != 0 || dy != 0 {
				angleToPrism := normalizeAngle(math.Atan2(dy, dx) * 180 / math.Pi)

				if angleDifference(angleToPrism, angle) < 1e-2 {
					distance := math.Sqrt(dx*dx + dy*dy)
					if distance < minDistance {
						minDistance = distance
						nextID = prism.id
						nextX = prism.x
						nextY = prism.y
						nextAngle = normalizeAngle(angle + prism.angle)
						found = true
					}
				}
			}
		}

		if found {
			sequence = append(sequence, nextID)
			x, y, angle = nextX, nextY, nextAngle
		} else {
			return sequence
		}
	}
}