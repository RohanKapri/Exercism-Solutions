use context starter2024

provide: simulate-game end

# Helper to normalize a card: face cards remain the same, number cards become "N"
fun normalize-card(card):
  if (card == "J") or (card == "Q") or (card == "K") or (card == "A"):
    card
  else:
    "N"
  end
end

# Helper to map a list of cards to their normalized forms
fun normalize-deck(deck):
  deck.map(normalize-card)
end

# Helper to get the penalty value for a face card
fun get-penalty(card):
  if card == "J": 1
  else if card == "Q": 2
  else if card == "K": 3
  else if card == "A": 4
  else: 0
  end
end

# Simulates exactly one single card-play micro-step of the game.
fun step-game(state, total-cards):
  if state.status == "finished":
    state
  else:
    deck-a = state.deck-a
    deck-b = state.deck-b
    pile = state.pile
    penalty-due = state.penalty-due
    active-player = state.active-player
    last-payer = state.last-payer
    cards-played = state.cards-played
    tricks-count = state.tricks-count
    
    current-deck = if active-player == "A": deck-a else: deck-b end
    opponent-deck = if active-player == "A": deck-b else: deck-a end
    
    if current-deck.length() == 0:
      # Current player has no cards to play: opponent automatically sweeps the table
      new-tricks = tricks-count + 1
      { status: "finished", cards-played: cards-played, tricks-count: new-tricks, deck-a: deck-a, deck-b: deck-b, pile: pile, penalty-due: penalty-due, active-player: active-player, last-payer: last-payer }
    else:
      card = current-deck.first
      rest-deck = current-deck.rest
      new-pile = pile.append([list: card])
      new-cards-played = cards-played + 1
      card-penalty = get-penalty(card)
      
      next-deck-a = if active-player == "A": rest-deck else: deck-a end
      next-deck-b = if active-player == "B": rest-deck else: deck-b end
      
      if penalty-due > 0:
        if card-penalty > 0:
          # A penalty payment was interrupted by an opponent's face card
          next-player = if active-player == "A": "B" else: "A" end
          { status: "running", cards-played: new-cards-played, tricks-count: tricks-count, deck-a: next-deck-a, deck-b: next-deck-b, pile: new-pile, penalty-due: card-penalty, active-player: next-player, last-payer: active-player }
        else:
          # Active player paid a valid number card toward the penalty due
          next-penalty = penalty-due - 1
          if next-penalty == 0:
            new-tricks = tricks-count + 1
            if last-payer == "A":
              winner-deck = next-deck-a.append(new-pile)
              if winner-deck.length() == total-cards:
                { status: "finished", cards-played: new-cards-played, tricks-count: new-tricks, deck-a: winner-deck, deck-b: next-deck-b, pile: [list: ], penalty-due: 0, active-player: "A", last-payer: "A" }
              else:
                { status: "running", cards-played: new-cards-played, tricks-count: new-tricks, deck-a: winner-deck, deck-b: next-deck-b, pile: [list: ], penalty-due: 0, active-player: "A", last-payer: "A" }
              end
            else:
              winner-deck = next-deck-b.append(new-pile)
              if winner-deck.length() == total-cards:
                { status: "finished", cards-played: new-cards-played, tricks-count: new-tricks, deck-a: next-deck-a, deck-b: winner-deck, pile: [list: ], penalty-due: 0, active-player: "B", last-payer: "B" }
              else:
                { status: "running", cards-played: new-cards-played, tricks-count: new-tricks, deck-a: next-deck-a, deck-b: winner-deck, pile: [list: ], penalty-due: 0, active-player: "B", last-payer: "B" }
              end
            end
          else:
            { status: "running", cards-played: new-cards-played, tricks-count: tricks-count, deck-a: next-deck-a, deck-b: next-deck-b, pile: new-pile, penalty-due: next-penalty, active-player: active-player, last-payer: last-payer }
          end
        end
      else:
        # Standard active turn sequence (no penalty is currently active)
        if card-penalty > 0:
          next-player = if active-player == "A": "B" else: "A" end
          { status: "running", cards-played: new-cards-played, tricks-count: tricks-count, deck-a: next-deck-a, deck-b: next-deck-b, pile: new-pile, penalty-due: card-penalty, active-player: next-player, last-payer: active-player }
        else:
          next-player = if active-player == "A": "B" else: "A" end
          { status: "running", cards-played: new-cards-played, tricks-count: tricks-count, deck-a: next-deck-a, deck-b: next-deck-b, pile: new-pile, penalty-due: 0, active-player: next-player, last-payer: last-payer }
        end
      end
    end
  end
end

fun simulate-game(player-a, player-b):
  total-cards = player-a.length() + player-b.length()

  initial-state = {
    status: "running",
    cards-played: 0,
    tricks-count: 0,
    deck-a: player-a,
    deck-b: player-b,
    pile: [list: ],
    penalty-due: 0,
    active-player: "A",
    last-payer: "A"
  }

  # Deep structural cycle finding using Floyd's algorithm
  fun run(tortoise, hare):
    if hare.status == "finished":
      { status: "finished", cards: hare.cards-played, tricks: hare.tricks-count }
    else:
      next-tortoise = step-game(tortoise, total-cards)
      hare-step1 = step-game(hare, total-cards)
      
      if hare-step1.status == "finished":
        { status: "finished", cards: hare-step1.cards-played, tricks: hare-step1.tricks-count }
      else:
        next-hare = step-game(hare-step1, total-cards)
        
        # We perform loop state evaluations strictly when rounds transition
        is-round-start = (next-tortoise.penalty-due == 0) and (next-tortoise.pile.length() == 0)
        
        if is-round-start and 
           (next-tortoise.active-player == next-hare.active-player) and
           (next-tortoise.penalty-due == next-hare.penalty-due) and
           (next-tortoise.pile.length() == next-hare.pile.length()) and
           (normalize-deck(next-tortoise.deck-a) == normalize-deck(next-hare.deck-a)) and
           (normalize-deck(next-tortoise.deck-b) == normalize-deck(next-hare.deck-b)):
          { status: "loop", cards: next-tortoise.cards-played, tricks: next-tortoise.tricks-count }
        else:
          run(next-tortoise, next-hare)
        end
      end
    end
  end

  run(initial-state, initial-state)
end