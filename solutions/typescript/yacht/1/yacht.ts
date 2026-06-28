export const enum Category {
  ONES,
  TWOS,
  THREES,
  FOURS,
  FIVES,
  SIXES,
  FULL_HOUSE,
  FOUR_OF_A_KIND,
  LITTLE_STRAIGHT,
  BIG_STRAIGHT,
  CHOICE,
  YACHT,
}

export const score = (dice: number[], category: Category): number => {
  // Helper: Sum of all dice
  const sum = () => dice.reduce((acc, curr) => acc + curr, 0);

  // Helper: Count occurrences of a specific number
  const countOf = (num: number) => dice.filter(d => d === num).length;

  // Helper: Generate frequencies of each unique dice face
  const counts = () => {
    const countsMap: { [key: number]: number } = {};
    for (const d of dice) {
      countsMap[d] = (countsMap[d] || 0) + 1;
    }
    return Object.values(countsMap).sort((a, b) => b - a);
  };

  // Sort helper for checking straights easily
  const sortedDice = [...dice].sort((a, b) => a - b);

  switch (category) {
    case Category.ONES:
      return countOf(1) * 1;
    case Category.TWOS:
      return countOf(2) * 2;
    case Category.THREES:
      return countOf(3) * 3;
    case Category.FOURS:
      return countOf(4) * 4;
    case Category.FIVES:
      return countOf(5) * 5;
    case Category.SIXES:
      return countOf(6) * 6;

    case Category.FULL_HOUSE: {
      const freq = counts();
      // Valid Full House must have exactly 3 of one value and 2 of another
      return freq.length === 2 && freq[0] === 3 && freq[1] === 2 ? sum() : 0;
    }

    case Category.FOUR_OF_A_KIND: {
      // Find which number appears 4 or more times
      for (const d of dice) {
        if (countOf(d) >= 4) {
          return d * 4;
        }
      }
      return 0;
    }

    case Category.LITTLE_STRAIGHT:
      return sortedDice.join(',') === '1,2,3,4,5' ? 30 : 0;

    case Category.BIG_STRAIGHT:
      return sortedDice.join(',') === '2,3,4,5,6' ? 30 : 0;

    case Category.CHOICE:
      return sum();

    case Category.YACHT:
      // Valid Yacht requires all 5 elements to be identical
      return new Set(dice).size === 1 ? 50 : 0;

    default:
      return 0;
  }
};