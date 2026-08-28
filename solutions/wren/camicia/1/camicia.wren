class Camicia {
  static simulateGame(playerA, playerB) {
    // Copy the initial decks to avoid modifying the arguments
    var deckA = []
    for (card in playerA) deckA.add(card)
    var deckB = []
    for (card in playerB) deckB.add(card)

    var pile = []
    var cardsPlayed = 0
    var tricks = 0
    
    var history = {}
    var currentPlayer = "A" // Tracks whose turn it is to play
    
    var penaltyCardValues = { "J": 1, "Q": 2, "K": 3, "A": 4 }

    while (true) {
      // Check for a loop state at the start of a new round (when the pile is empty)
      if (pile.isEmpty) {
        var normA = deckA.map { |c| penaltyCardValues.containsKey(c) ? c : "N" }.join(",")
        var normB = deckB.map { |c| penaltyCardValues.containsKey(c) ? c : "N" }.join(",")
        var stateKey = "%(normA)|%(normB)|%(currentPlayer)"
        
        if (history.containsKey(stateKey)) {
          return { "status": "loop", "cards": cardsPlayed, "tricks": tricks }
        }
        history[stateKey] = true
      }

      // If a player runs out of cards and cannot start their turn, the other collects the pile
      if (currentPlayer == "A" && deckA.isEmpty) {
        deckB.addAll(pile)
        tricks = tricks + 1
        return { "status": "finished", "cards": cardsPlayed, "tricks": tricks }
      }
      if (currentPlayer == "B" && deckB.isEmpty) {
        deckA.addAll(pile)
        tricks = tricks + 1
        return { "status": "finished", "cards": cardsPlayed, "tricks": tricks }
      }

      // Draw and play the top card
      var activeDeck = (currentPlayer == "A") ? deckA : deckB
      var card = activeDeck.removeAt(0)
      pile.add(card)
      cardsPlayed = cardsPlayed + 1

      if (penaltyCardValues.containsKey(card)) {
        // A penalty card was placed, triggering the penalty phase
        var penaltyVal = penaltyCardValues[card]
        var penaltyWinner = currentPlayer
        currentPlayer = (currentPlayer == "A") ? "B" : "A"
        
        while (penaltyVal > 0) {
          var targetDeck = (currentPlayer == "A") ? deckA : deckB
          
          // Target player runs out of cards while paying -> penalty winner takes the pile
          if (targetDeck.isEmpty) {
            var winnerDeck = (penaltyWinner == "A") ? deckA : deckB
            winnerDeck.addAll(pile)
            pile.clear()
            tricks = tricks + 1
            currentPlayer = penaltyWinner
            break
          }

          var pCard = targetDeck.removeAt(0)
          pile.add(pCard)
          cardsPlayed = cardsPlayed + 1

          if (penaltyCardValues.containsKey(pCard)) {
            // New penalty card counters the previous one!
            penaltyVal = penaltyCardValues[pCard]
            penaltyWinner = currentPlayer
            currentPlayer = (currentPlayer == "A") ? "B" : "A"
          } else {
            // Number card reduces the penalty count
            penaltyVal = penaltyVal - 1
            if (penaltyVal == 0) {
              // Penalty fully paid without counter -> winner takes the pile
              var winnerDeck = (penaltyWinner == "A") ? deckA : deckB
              winnerDeck.addAll(pile)
              pile.clear()
              tricks = tricks + 1
              currentPlayer = penaltyWinner
            }
          }
        }

        // Check victory conditions after the central pile is collected
        if (deckA.isEmpty || deckB.isEmpty) {
          return { "status": "finished", "cards": cardsPlayed, "tricks": tricks }
        }
      } else {
        // Normal number card (2-10) simply switches play to the opponent
        currentPlayer = (currentPlayer == "A") ? "B" : "A"
      }
    }
  }
}