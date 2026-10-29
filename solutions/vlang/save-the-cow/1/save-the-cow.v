module main

// A game of save the cow, in which a word is hidden behind underscores
// and the player has nine failures to spare before losing.
//
// Call `guess` once per guessed letter and read `state`, `remaining` and
// `masked_word()` to find out how the game is going. Guessing after the
// game has been won or lost is an error.
enum State {
	ongoing
	lose
	win
}

struct Game {
	word string
mut:
	// How many wrong guesses are left before the game is lost.
	remaining int

	// Whether the game is still going, won or lost.
	state State

	// bitset indicating letters in word not yet guessed
	outstanding int
}

fn new_game(word string) Game {
	remaining := 9

	mut outstanding := 0
	for ch in word {
		if ch >= `a` && ch <= `z` {
			outstanding |= 1 << (ch - `a`)
		}
	}

	return Game{word, remaining, .ongoing, outstanding}
}

fn (g &Game) masked_word() string {
	mut result := []u8{cap: g.word.len}
	for ch in g.word {
		if ch >= `a` && ch <= `z` && (g.outstanding & (1 << (ch - `a`))) != 0 {
			result << `_`
		} else {
			result << ch
		}
	}
	return result.bytestr()
}

fn (mut g Game) guess(letter u8) !State {
	if g.state == .lose {
		return error('cannot guess after the game is lost')
	}

	if g.state == .win {
		return error('cannot guess after the game is won')
	}

	if letter >= `a` && letter <= `z` && (g.outstanding & (1 << (letter - `a`))) != 0 {
		g.outstanding -= (1 << (letter - `a`))
		if g.outstanding == 0 {
			g.state = .win
		}
	} else {
		if g.remaining == 0 {
			g.state = .lose
		} else {
			g.remaining -= 1
		}
	}

	return g.state
}