//
// This is only a SKELETON file for the 'Camicia' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const penalty = {
  J: 1,
  Q: 2,
  K: 3,
  A: 4,
};

const normalize = (deck) =>
  deck.map((c) => (penalty[c] ? c : "#")).join("");

export const simulateGame = (playerA, playerB) => {
  const a = [...playerA];
  const b = [...playerB];
  const pile = [];

  let cards = 0;
  let tricks = 0;
  let current = 0; // 0 = A, 1 = B
  let collector = -1;
  let due = 0;

  const seen = new Set();

  while (true) {
    // Detect loops at the start of each round
    if (due === 0 && pile.length === 0) {
      const state =
        normalize(a) + "|" + normalize(b) + "|" + current;
      if (seen.has(state)) {
        return {
          status: "loop",
          cards,
          tricks,
        };
      }
      seen.add(state);
    }

    const deck = current === 0 ? a : b;

    // Player cannot play
    if (deck.length === 0) {
      if (pile.length) {
        const winner = current ^ 1;
        if (winner === 0) a.push(...pile);
        else b.push(...pile);
        pile.length = 0;
        tricks++;

        if (a.length === 0 || b.length === 0) {
          return {
            status: "finished",
            cards,
            tricks,
          };
        }
      }
      return {
        status: "finished",
        cards,
        tricks,
      };
    }

    const card = deck.shift();
    pile.push(card);
    cards++;

    if (card in penalty) {
      collector = current;
      due = penalty[card];
      current ^= 1;
      continue;
    }

    if (due > 0) {
      due--;

      if (due === 0) {
        if (collector === 0) a.push(...pile);
        else b.push(...pile);

        pile.length = 0;
        tricks++;

        if (a.length === 0 || b.length === 0) {
          return {
            status: "finished",
            cards,
            tricks,
          };
        }

        current = collector;
      }
    } else {
      current ^= 1;
    }
  }
};