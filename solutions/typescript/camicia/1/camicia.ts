type GameResult = {
  status: 'finished' | 'loop'
  cards: number
  tricks: number
}

export const simulateGame = (
  playerA: unknown,
  playerB: unknown,
): unknown => {
  const deckA = [...(playerA as string[])]
  const deckB = [...(playerB as string[])]

  const pile: string[] = []

  let cards = 0
  let tricks = 0
  let current = 0
  let collector: number | null = null
  let penalty = 0

  const seen = new Set<string>()

  const payment = (card: string): number =>
    ({ J: 1, Q: 2, K: 3, A: 4 }[card] ?? 0)

  const encode = (deck: string[]): string =>
    deck
      .map((card) => (payment(card) > 0 ? card : 'N'))
      .join(',')

  while (true) {
    if (penalty === 0) {
      const state = `${encode(deckA)}|${encode(deckB)}`

      if (seen.has(state)) {
        return {
          status: 'loop',
          cards,
          tricks,
        } satisfies GameResult
      }

      seen.add(state)
    }

    const deck = current === 0 ? deckA : deckB

    if (deck.length === 0) {
      const winner = current === 0 ? deckB : deckA
      winner.push(...pile)
      pile.length = 0
      tricks++

      return {
        status: 'finished',
        cards,
        tricks,
      } satisfies GameResult
    }

    const card = deck.shift()!
    pile.push(card)
    cards++

    const cost = payment(card)

    if (cost > 0) {
      collector = current
      penalty = cost
      current ^= 1
      continue
    }

    if (penalty > 0) {
      penalty--

      if (penalty === 0) {
        const winner = collector === 0 ? deckA : deckB
        winner.push(...pile)
        pile.length = 0
        tricks++

        if (deckA.length === 0 || deckB.length === 0) {
          return {
            status: 'finished',
            cards,
            tricks,
          } satisfies GameResult
        }

        current = collector!
        collector = null
      }
    } else {
      current ^= 1
    }
  }
}