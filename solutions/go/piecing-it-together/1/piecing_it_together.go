package piecingittogether

import (
	"errors"
	"math"
)

type PuzzleDetails struct {
	Pieces      int
	Border      int
	Inside      int
	Rows        int
	Columns     int
	AspectRatio float64
	Format      string
}

func format(aspectRatio float64) string {
	if aspectRatio > 1 {
		return "landscape"
	} else if aspectRatio < 1 {
		return "portrait"
	}
	return "square"
}

func JigsawData(details PuzzleDetails) (PuzzleDetails, error) {
	floatEq := func(a, b float64) bool {
		return math.Abs(a-b) < 1e-9
	}

	hasAspectConstraint := details.AspectRatio > 0
	requiredAspectRatio := details.AspectRatio
	if !hasAspectConstraint && details.Format == "square" {
		hasAspectConstraint = true
		requiredAspectRatio = 1
	}

	rowMin, rowMax := 0, 0
	if details.Rows > 0 {
		rowMin, rowMax = details.Rows, details.Rows
	} else if details.Pieces > 0 {
		rowMin, rowMax = 1, details.Pieces
	} else if details.Border > 0 {
		rowMin, rowMax = 1, details.Border
	} else if details.Inside > 0 {
		rowMin, rowMax = 1, details.Inside+2
	} else {
		return PuzzleDetails{}, errors.New("Insufficient data")
	}

	solutions := make([]PuzzleDetails, 0)
	seen := make(map[[2]int]struct{})
	derivedAnyColumns := false

	for rows := rowMin; rows <= rowMax; rows++ {
		if rows <= 0 {
			continue
		}

		columns := 0
		hasColumns := false

		switch {
		case details.Columns > 0:
			columns = details.Columns
			hasColumns = true

		case details.Pieces > 0:
			if details.Pieces%rows == 0 {
				columns = details.Pieces / rows
				hasColumns = true
			}

		case details.Border > 0:
			numerator := details.Border - 2*rows + 4
			if numerator > 0 && numerator%2 == 0 {
				columns = numerator / 2
				hasColumns = true
			}

		case details.Inside > 0:
			if rows > 2 {
				numerator := details.Inside
				denominator := rows - 2
				if numerator%denominator == 0 {
					columns = numerator/denominator + 2
					hasColumns = true
				}
			}

		case hasAspectConstraint:
			candidate := float64(rows) * requiredAspectRatio
			if floatEq(candidate, float64(int(candidate))) {
				columns = int(candidate)
				hasColumns = true
			}
		}

		if !hasColumns || columns <= 0 {
			continue
		}
		derivedAnyColumns = true

		pieces := rows * columns
		border := 2*columns + 2*rows - 4
		inside := pieces - border
		aspectRatio := float64(columns) / float64(rows)
		puzzleFormat := format(aspectRatio)

		if details.Pieces > 0 && pieces != details.Pieces {
			continue
		} else if details.Border > 0 && border != details.Border {
			continue
		} else if details.Inside > 0 && inside != details.Inside {
			continue
		} else if details.Rows > 0 && rows != details.Rows {
			continue
		} else if details.Columns > 0 && columns != details.Columns {
			continue
		} else if hasAspectConstraint && !floatEq(requiredAspectRatio, aspectRatio) {
			continue
		} else if details.Format != "" && details.Format != puzzleFormat {
			continue
		}

		key := [2]int{rows, columns}
		if _, ok := seen[key]; ok {
			continue
		}
		seen[key] = struct{}{}

		solutions = append(solutions, PuzzleDetails{
			Pieces:      pieces,
			Border:      border,
			Inside:      inside,
			Rows:        rows,
			Columns:     columns,
			AspectRatio: aspectRatio,
			Format:      puzzleFormat,
		})
	}

	if len(solutions) == 0 {
		if !derivedAnyColumns {
			return PuzzleDetails{}, errors.New("Insufficient data")
		}
		return PuzzleDetails{}, errors.New("Contradictory data")
	}

	if len(solutions) > 1 {
		return PuzzleDetails{}, errors.New("Insufficient data")
	}

	return solutions[0], nil
}