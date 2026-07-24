export const findFewestCoins = (coins: unknown, target: unknown): unknown => {
  if (!Array.isArray(coins) || !coins.every((c) => typeof c === 'number')) {
    throw new Error('Coins must be an array of numbers');
  }

  if (typeof target !== 'number' || target < 0) {
    throw new Error("target can't be negative");
  }

  if (target === 0) {
    return [];
  }

  const coinList = coins as number[];

  // dp[i] holds the optimal array of coins that sum up to amount i
  const dp: (number[] | null)[] = new Array(target + 1).fill(null);
  dp[0] = [];

  for (let i = 1; i <= target; i++) {
    for (const coin of coinList) {
      if (coin <= 0) continue;

      const prevAmount = i - coin;
      if (prevAmount >= 0 && dp[prevAmount] !== null) {
        const candidate = [...dp[prevAmount]!, coin];

        if (dp[i] === null || candidate.length < dp[i]!.length) {
          dp[i] = candidate;
        }
      }
    }
  }

  if (dp[target] === null) {
    throw new Error("can't make target with given coins");
  }

  return dp[target]!.sort((a, b) => a - b);
}