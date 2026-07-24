type Card = {
  value: number;
  suit: string;
};

const CARD_VALUES: Record<string, number> = {
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
  '10': 10,
  J: 11,
  Q: 12,
  K: 13,
  A: 14,
};

enum HandCategory {
  StraightFlush = 8,
  FourOfAKind = 7,
  FullHouse = 6,
  Flush = 5,
  Straight = 4,
  ThreeOfAKind = 3,
  TwoPair = 2,
  OnePair = 1,
  HighCard = 0,
}

// Parses string like "10S" or "AH" into a Card object
function parseCard(cardStr: string): Card {
  const valueStr = cardStr.slice(0, -1);
  const suit = cardStr.slice(-1);
  return {
    value: CARD_VALUES[valueStr],
    suit,
  };
}

// Evaluates a hand string and produces a score array [Category, TieBreaker1, TieBreaker2, ...]
function evaluateHand(handStr: string): number[] {
  const cards = handStr.split(' ').map(parseCard);

  // Group counts by card value
  const valueCounts = new Map<number, number>();
  for (const card of cards) {
    valueCounts.set(card.value, (valueCounts.get(card.value) || 0) + 1);
  }

  // Sort groups by count descending, then by card value descending
  const sortedGroups = Array.from(valueCounts.entries()).sort(
    (a, b) => b[1] - a[1] || b[0] - a[0]
  );

  const isFlush = cards.every((c) => c.suit === cards[0].suit);

  // Check for Straights
  const sortedValues = cards.map((c) => c.value).sort((a, b) => b - a);
  let isStraight = false;
  let straightHighCard = sortedValues[0];

  // Standard straight check
  if (
    sortedValues[0] - sortedValues[4] === 4 &&
    new Set(sortedValues).size === 5
  ) {
    isStraight = true;
  }
  // Ace-low straight check (A 5 4 3 2)
  else if (
    sortedValues[0] === 14 &&
    sortedValues[1] === 5 &&
    sortedValues[2] === 4 &&
    sortedValues[3] === 3 &&
    sortedValues[4] === 2
  ) {
    isStraight = true;
    straightHighCard = 5; // 5 is the top card for Ace-low straight
  }

  // 1. Straight Flush
  if (isFlush && isStraight) {
    return [HandCategory.StraightFlush, straightHighCard];
  }

  // 2. Four of a Kind
  if (sortedGroups[0][1] === 4) {
    return [
      HandCategory.FourOfAKind,
      sortedGroups[0][0], // Quad rank
      sortedGroups[1][0], // Kicker
    ];
  }

  // 3. Full House
  if (sortedGroups[0][1] === 3 && sortedGroups[1][1] === 2) {
    return [
      HandCategory.FullHouse,
      sortedGroups[0][0], // Trio rank
      sortedGroups[1][0], // Pair rank
    ];
  }

  // 4. Flush
  if (isFlush) {
    return [HandCategory.Flush, ...sortedValues];
  }

  // 5. Straight
  if (isStraight) {
    return [HandCategory.Straight, straightHighCard];
  }

  // 6. Three of a Kind
  if (sortedGroups[0][1] === 3) {
    return [
      HandCategory.ThreeOfAKind,
      sortedGroups[0][0], // Trio rank
      sortedGroups[1][0], // Kicker 1
      sortedGroups[2][0], // Kicker 2
    ];
  }

  // 7. Two Pair
  if (sortedGroups[0][1] === 2 && sortedGroups[1][1] === 2) {
    return [
      HandCategory.TwoPair,
      sortedGroups[0][0], // High pair
      sortedGroups[1][0], // Low pair
      sortedGroups[2][0], // Kicker
    ];
  }

  // 8. One Pair
  if (sortedGroups[0][1] === 2) {
    return [
      HandCategory.OnePair,
      sortedGroups[0][0], // Pair rank
      sortedGroups[1][0], // Kicker 1
      sortedGroups[2][0], // Kicker 2
      sortedGroups[3][0], // Kicker 3
    ];
  }

  // 9. High Card
  return [HandCategory.HighCard, ...sortedValues];
}

// Compare two score arrays lexicographically
function compareScores(scoreA: number[], scoreB: number[]): number {
  for (let i = 0; i < Math.max(scoreA.length, scoreB.length); i++) {
    const valA = scoreA[i] ?? 0;
    const valB = scoreB[i] ?? 0;
    if (valA !== valB) {
      return valA - valB;
    }
  }
  return 0;
}

export function bestHands(hands: string[]): string[] {
  const evaluatedHands = hands.map((hand) => ({
    hand,
    score: evaluateHand(hand),
  }));

  // Find maximum score across all hands
  let bestScore = evaluatedHands[0].score;
  for (let i = 1; i < evaluatedHands.length; i++) {
    if (compareScores(evaluatedHands[i].score, bestScore) > 0) {
      bestScore = evaluatedHands[i].score;
    }
  }

  // Return all winning hands (including ties)
  return evaluatedHands
    .filter((item) => compareScores(item.score, bestScore) === 0)
    .map((item) => item.hand);
}