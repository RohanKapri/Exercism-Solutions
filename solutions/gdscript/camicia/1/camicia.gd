const PENALTY = {"A": 4, "K": 3, "Q": 2, "J": 1}


class Game:

	var hands = []
	var middle = []
	var seen = {}
	var cur_player = 0
	var cards = 0
	var tricks = 0
	var loop = false

	func _init(cards):
		for hand in cards:
			var c = []
			for card in hand:
				if card not in PENALTY:
					card = "-"
				c.append(card)
			self.hands.append(c)

	func game_over() -> bool:
		"""Return if the game should stop.

		The game stops if one player has all the cards of if we are in a loop.
		"""
		if (not self.hands[0] or not self.hands[1]) and not self.middle:
			return true

		# Check for a loop.
		var state = "".join(hands[0]) + "|" + "".join(hands[1])
		self.loop = state in self.seen
		self.seen[state] = true
		return self.loop

	func end_turn():
		"""End the player's turn."""
		self.cur_player = 1 - self.cur_player

	func collect_middle():
		"""Add the middle pile to the player's hand."""
		for card in self.middle:
			self.hands[self.cur_player].append(card)
		self.tricks += 1
		self.middle.clear()

	func play_one_card():
		"""Move one card from the current player's hand to the middle."""
		var card = self.hands[self.cur_player].pop_front()
		self.middle.append(card)
		self.cards += 1
		return card

	func resolve_penalty(penalty: int):
		"""Play out a penalty."""
		while penalty and self.hands[self.cur_player]:
			var card = self.play_one_card()
			penalty -= 1
			if card != "-":
				self.end_turn()
				penalty = PENALTY[card]

		# Collect the pile.
		self.end_turn()
		self.collect_middle()

	func play():
		"""Return the outcome of the game."""
		while not self.game_over():
			if not self.hands[self.cur_player]:
				self.end_turn()
				self.collect_middle()
				break

			var card = self.play_one_card()
			self.end_turn()
			if card != "-":
				self.resolve_penalty(PENALTY[card])

		return {
			"status": "loop" if self.loop else "finished",
			"cards": self.cards,
			"tricks": self.tricks,
		}


func simulate_game(player_a: Array, player_b: Array) -> Dictionary:
	return Game.new([player_a, player_b]).play()