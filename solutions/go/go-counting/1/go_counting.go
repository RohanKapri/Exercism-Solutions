package gocounting

import (
	"errors"
	"slices"
)

type AllTerritories struct {
	Black [][2]int
	White [][2]int
	None  [][2]int
}

type Game struct {
	board  []string
	width  int
	height int
}

func neighbors(x, y int) [][2]int {
	return [][2]int{
		{x - 1, y},
		{x + 1, y},
		{x, y - 1},
		{x, y + 1},
	}
}

func NewGame(board []string) *Game {
	width := 0
	height := len(board)
	if height > 0 {
		width = len(board[0])
	}

	return &Game{board: board, width: width, height: height}
}

func (g *Game) at(x, y int) (byte, bool) {
	if y < 0 || y >= g.height || x < 0 || x >= g.width {
		return 0, false
	}
	return g.board[y][x], true
}

func (g *Game) Territory(x, y int) (string, [][2]int, error) {
	cell, ok := g.at(x, y)
	if !ok {
		return "", nil, errors.New("invalid coordinate")
	}
	if cell != ' ' {
		return "NONE", [][2]int{}, nil
	}

	owners := map[byte]bool{}
	visited := map[[2]int]bool{}
	territorySet := map[[2]int]bool{{x, y}: true}
	toVisit := [][2]int{{x, y}}

	for len(toVisit) > 0 {
		idx := len(toVisit) - 1
		current := toVisit[idx]
		toVisit = toVisit[:idx]

		if visited[current] {
			continue
		}
		visited[current] = true

		for _, n := range neighbors(current[0], current[1]) {
			if visited[n] {
				continue
			}

			piece, inBounds := g.at(n[0], n[1])
			switch piece {
			case 'B', 'W':
				if inBounds {
					owners[piece] = true
				}
			case ' ':
				if inBounds {
					territorySet[n] = true
					toVisit = append(toVisit, n)
				}
			}
		}
	}

	territory := make([][2]int, 0, len(territorySet))
	for coord := range territorySet {
		territory = append(territory, coord)
	}

	slices.SortFunc(territory, func(a, b [2]int) int {
		if a[0] != b[0] {
			if a[0] < b[0] {
				return -1
			}
			return 1
		}
		if a[1] < b[1] {
			return -1
		}
		if a[1] > b[1] {
			return 1
		}
		return 0
	})

	owner := "NONE"
	if len(owners) == 1 {
		if owners['B'] {
			owner = "BLACK"
		} else {
			owner = "WHITE"
		}
	}

	return owner, territory, nil
}

func (g *Game) Territories() AllTerritories {
	marked := map[[2]int]bool{}
	territories := map[string][][2]int{
		"BLACK": {},
		"WHITE": {},
		"NONE":  {},
	}

	for y := 0; y < g.height; y++ {
		for x := 0; x < g.width; x++ {
			if marked[[2]int{x, y}] {
				continue
			}
			cell, _ := g.at(x, y)
			if cell != ' ' {
				continue
			}

			owner, territory, _ := g.Territory(x, y)
			for _, coord := range territory {
				marked[coord] = true
				territories[owner] = append(territories[owner], coord)
			}
		}
	}

	return AllTerritories{
		Black: territories["BLACK"],
		White: territories["WHITE"],
		None:  territories["NONE"],
	}
}