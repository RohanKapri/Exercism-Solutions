class Camicia {
  static const payment = {
    'J': 1,
    'Q': 2,
    'K': 3,
    'A': 4,
  };

  Map<String, dynamic> simulateGame(List<String> playerA, List<String> playerB) {
    final pile = <String>[];
    final states = <String>{};
    int tricks = 0;
    int cards = 0;
    int paymentDue = 0;
    List<List<String>> players = [playerA, playerB];

    List<String> normalizeDeck(List<String> deck) {
      return deck.map((card) => payment.containsKey(card) ? card : 'N').toList();
    }

    while (true) {
      final player = players[0];
      final opponent = players[1];

      if (player.isEmpty) {
        if (pile.isNotEmpty) {
          opponent.addAll(pile);
          pile.clear();
          tricks += 1;
        }
        return {'status': 'finished', 'cards': cards, 'tricks': tricks};
      }

      if (pile.isEmpty) {
        final state =
            '{"playerA":${normalizeDeck(playerA)},"playerB":${normalizeDeck(playerB)},"paymentDue":$paymentDue}';

        if (states.contains(state)) {
          return {'status': 'loop', 'cards': cards, 'tricks': tricks};
        }

        states.add(state);
      }

      final played = player.removeAt(0);
      pile.add(played);
      cards += 1;

      if (payment.containsKey(played)) {
        paymentDue = payment[played]!;
        players = [opponent, player];
      } else if (paymentDue > 0) {
        paymentDue -= 1;
        if (paymentDue == 0) {
          opponent.addAll(pile);
          pile.clear();
          tricks += 1;
          players = [opponent, player];

          if (player.isEmpty) {
            return {'status': 'finished', 'cards': cards, 'tricks': tricks};
          }
        }
      } else {
        players = [opponent, player];
      }
    }
  }
}