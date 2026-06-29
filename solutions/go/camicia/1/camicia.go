package camicia

import "strings"

type Outcome struct {
	finishes bool
	cards    int
	tricks   int
}

func paymentFor(card string) int {
	switch card {
	case "J":
		return 1
	case "Q":
		return 2
	case "K":
		return 3
	case "A":
		return 4
	default:
		return 0
	}
}

func normalizeCard(card string) string {
	if paymentFor(card) > 0 {
		return card
	}
	return "N"
}

func encodeState(playerA, playerB []string, paymentDue int) string {
	var b strings.Builder

	b.Grow((len(playerA)+len(playerB))*2 + 16)
	b.WriteString("A:")
	for _, card := range playerA {
		b.WriteString(normalizeCard(card))
		b.WriteByte(',')
	}
	b.WriteString("|B:")
	for _, card := range playerB {
		b.WriteString(normalizeCard(card))
		b.WriteByte(',')
	}
	b.WriteString("|P:")
	b.WriteByte(byte('0' + paymentDue))

	return b.String()
}

func SimulateGame(playerA, playerB []string) Outcome {
	decks := [2][]string{append([]string(nil), playerA...), append([]string(nil), playerB...)}
	pile := make([]string, 0)
	states := make(map[string]struct{})

	tricks := 0
	cards := 0
	paymentDue := 0
	current := 0

	for {
		opponent := 1 - current
		playerDeck := decks[current]

		if len(playerDeck) == 0 {
			if len(pile) > 0 {
				decks[opponent] = append(decks[opponent], pile...)
				pile = pile[:0]
				tricks++
			}
			return Outcome{finishes: true, cards: cards, tricks: tricks}
		}

		if len(pile) == 0 {
			state := encodeState(decks[0], decks[1], paymentDue)
			if _, seen := states[state]; seen {
				return Outcome{finishes: false, cards: cards, tricks: tricks}
			}
			states[state] = struct{}{}
		}

		played := playerDeck[0]
		decks[current] = playerDeck[1:]
		pile = append(pile, played)
		cards++

		if due := paymentFor(played); due > 0 {
			paymentDue = due
			current = opponent
			continue
		}

		if paymentDue > 0 {
			paymentDue--
			if paymentDue == 0 {
				decks[opponent] = append(decks[opponent], pile...)
				pile = pile[:0]
				tricks++
				current = opponent
				if len(decks[1-current]) == 0 {
					return Outcome{finishes: true, cards: cards, tricks: tricks}
				}
			}
			continue
		}

		current = opponent
	}
}