package savethecow

import (
	"errors"
	"math"
)

type Game struct {
	word              string
	remainingFailures int
	guesses           map[rune]struct{}
}

func NewGame(word string) *Game {
	return &Game{
		word:              word,
		remainingFailures: 10,
		guesses:           make(map[rune]struct{}),
	}
}

func (g *Game) Guess(r rune) error {
	if g.State() == "Win" {
		return errors.New("cannot guess after the game is won")
	} else if g.State() == "Lose" {
		return errors.New("cannot guess after the game is lost")
	}

	if _, ok := g.guesses[r]; ok || !contains(g.word, r) {
		g.remainingFailures--
	}

	g.guesses[r] = struct{}{}
	return nil
}

func contains(s string, r rune) bool {
	for _, c := range s {
		if c == r {
			return true
		}
	}
	return false
}

func (g *Game) MaskedWord() string {
	maskedRunes := make([]rune, len(g.word))
	for i, c := range g.word {
		if _, ok := g.guesses[c]; ok {
			maskedRunes[i] = c
		} else {
			maskedRunes[i] = '_'
		}
	}

	return string(maskedRunes)
}

func (g *Game) RemainingGuesses() int {
	return int(math.Max(0, float64(g.remainingFailures-1)))
}

func (g *Game) State() string {
	if g.MaskedWord() == g.word {
		return "Win"
	} else if g.remainingFailures <= 0 {
		return "Lose"
	} else {
		return "Ongoing"
	}
}