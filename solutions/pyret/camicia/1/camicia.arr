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

fun simulate-game(player-a, player-b):
  # Internal recursive loop to track game state
  fun run(deck-a, deck-b, pile, penalty-due, active-player, last-payer, cards-played, tricks-count, history):
    
    # A round starts when there is no active penalty and the pile is empty
    is-round-start = (penalty-due == 0) and (pile.length() == 0)
    
    # Check for loops at the start of a round
    current-history-state = { a: normalize-deck(deck-a), b: normalize-deck(deck-b) }
    if is-round-start and history.member(current-history-state):
      { status: "loop", cards: cards-played, tricks: tricks-count }
    else:
      # Update history if it's the start of a new round
      next-history = if is-round-start: history.add(current-history-state) else: history end
      
      # Determine the current player's deck
      current-deck = if active-player == "A": deck-a else: deck-b end
      opponent-deck = if active-player == "A": deck-b else: deck-a end
      
      if current-deck.length() == 0:
        # Current player cannot play a card; opponent collects the pile
        new-opponent-deck = opponent-deck.append(pile)
        new-tricks = tricks-count + 1
        
        # Determine final status
        if new-opponent-deck.length() == (deck-a.length() + deck-b.length() + pile.length()):
          { status: "finished", cards: cards-played, tricks: new-tricks }
        else:
          # If the game didn't fully end, continue with the opponent starting next round
          if active-player == "A":
            run([list: ], new-opponent-deck, [list: ], 0, "B", "B", cards-played, new-tricks, next-history)
          else:
            run(new-opponent-deck, [list: ], [list: ], 0, "A", "A", cards-played, new-tricks, next-history)
          end
        end
      else:
        # Play the top card
        card = current-deck.first
        rest-deck = current-deck.rest
        new-pile = pile.append([list: card])
        new-cards-played = cards-played + 1
        card-penalty = get-penalty(card)
        
        # Update decks based on who is playing
        next-deck-a = if active-player == "A": rest-deck else: deck-a end
        next-deck-b = if active-player == "B": rest-deck else: deck-b end
        
        if penalty-due > 0:
          # Currently paying a penalty
          if card-penalty > 0:
            # Interrupted by a new payment card!
            # Opponent must now pay, active player becomes the opponent
            next-player = if active-player == "A": "B" else: "A" end
            run(next-deck-a, next-deck-b, new-pile, card-penalty, next-player, active-player, new-cards-played, tricks-count, next-history)
          else:
            # Paid a number card toward the penalty
            next-penalty = penalty-due - 1
            if next-penalty == 0:
              # Penalty fully paid! last-payer collects the pile
              new-tricks = tricks-count + 1
              if last-payer == "A":
                winner-deck = next-deck-a.append(new-pile)
                if winner-deck.length() == (deck-a.length() + deck-b.length()):
                  { status: "finished", cards: new-cards-played, tricks: new-tricks }
                else:
                  run(winner-deck, next-deck-b, [list: ], 0, "A", "A", new-cards-played, new-tricks, next-history)
                end
              else:
                winner-deck = next-deck-b.append(new-pile)
                if winner-deck.length() == (deck-a.length() + deck-b.length()):
                  { status: "finished", cards: new-cards-played, tricks: new-tricks }
                else:
                  run(next-deck-a, winner-deck, [list: ], 0, "B", "B", new-cards-played, new-tricks, next-history)
                end
              end
            else:
              # Penalty still remaining, same player keeps paying
              run(next-deck-a, next-deck-b, new-pile, next-penalty, active-player, last-payer, new-cards-played, tricks-count, next-history)
            end
          end
        else:
          # Normal play (no penalty due)
          if card-penalty > 0:
            # Played a payment card, opponent must now pay
            next-player = if active-player == "A": "B" else: "A" end
            run(next-deck-a, next-deck-b, new-pile, card-penalty, next-player, active-player, new-cards-played, tricks-count, next-history)
          else:
            # Played a number card, turn passes normally
            next-player = if active-player == "A": "B" else: "A" end
            run(next-deck-a, next-deck-b, new-pile, 0, next-player, last-payer, new-cards-played, tricks-count, next-history)
          end
        end
      end
    end
  end

  run(player-a, player-b, [list: ], 0, "A", "A", 0, 0, [set: ])
end

