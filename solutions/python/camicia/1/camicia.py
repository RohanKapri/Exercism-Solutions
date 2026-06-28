"""Simulation of the card game Camicia."""

from collections import deque


def simulate_game(player_a, player_b):
    """Simulate a game of Camicia."""
    player_a = deque(player_a)
    player_b = deque(player_b)
    pile = []

    cards = 0
    tricks = 0
    seen = set()

    current = 0
    collector = None
    penalty = 0

    def payment(card):
        return {"J": 1, "Q": 2, "K": 3, "A": 4}.get(card, 0)

    def encode(deck):
        return tuple(card if payment(card) else "N" for card in deck)

    while True:
        if penalty == 0:
            state = (encode(player_a), encode(player_b))
            if state in seen:
                return {
                    "status": "loop",
                    "cards": cards,
                    "tricks": tricks,
                }
            seen.add(state)

        deck = player_a if current == 0 else player_b

        if not deck:
            winner = player_b if current == 0 else player_a
            winner.extend(pile)
            pile.clear()
            tricks += 1

            return {
                "status": "finished",
                "cards": cards,
                "tricks": tricks,
            }

        card = deck.popleft()
        pile.append(card)
        cards += 1

        cost = payment(card)

        if cost:
            collector = current
            penalty = cost
            current ^= 1
            continue

        if penalty:
            penalty -= 1

            if penalty == 0:
                winner = player_a if collector == 0 else player_b
                winner.extend(pile)
                pile.clear()
                tricks += 1

                if not player_a or not player_b:
                    return {
                        "status": "finished",
                        "cards": cards,
                        "tricks": tricks,
                    }

                current = collector
                collector = None
        else:
            current ^= 1