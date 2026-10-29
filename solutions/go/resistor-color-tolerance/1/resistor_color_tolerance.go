package resistorcolortolerance

import (
	"fmt"
	"math"
	"strconv"
)

var COLORS = map[string]float64{
	"black":  0,
	"brown":  1,
	"red":    2,
	"orange": 3,
	"yellow": 4,
	"green":  5,
	"blue":   6,
	"violet": 7,
	"grey":   8,
	"white":  9,
}

var TOLERANCE = map[string]string{
	"grey":   " ±0.05%",
	"violet": " ±0.1%",
	"blue":   " ±0.25%",
	"green":  " ±0.5%",
	"brown":  " ±1%",
	"red":    " ±2%",
	"gold":   " ±5%",
	"silver": " ±10%",
}

func Label(colors []string) string {
	var value float64 = 0.0
	var tolerance string = ""

	if len(colors) == 5 {
		value = (COLORS[colors[0]]*100 + COLORS[colors[1]]*10 + COLORS[colors[2]]) * math.Pow10(int(COLORS[colors[3]]))
		tolerance = TOLERANCE[colors[4]]
	} else if len(colors) == 4 {
		value = (COLORS[colors[0]]*10 + COLORS[colors[1]]) * math.Pow10(int(COLORS[colors[2]]))
		tolerance = TOLERANCE[colors[3]]
	} else if len(colors) == 1 {
		value = COLORS[colors[0]]
	}

	var units string
	if value >= 1e6 {
		value /= 1e6
		units = "megaohms"
	} else if value >= 1e3 {
		value /= 1e3
		units = "kiloohms"
	} else {
		units = "ohms"
	}

	return fmt.Sprintf("%s %s%s", strconv.FormatFloat(value, 'f', -1, 64), units, tolerance)
}