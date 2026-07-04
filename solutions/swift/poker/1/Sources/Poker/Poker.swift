enum ScoreType: Int, Comparable {
    case highCard = 0
    case pair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush

    static func < (lhs: ScoreType, rhs: ScoreType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

typealias HandScore = (type: ScoreType, first: Int, second: Int, third: Int, fourth: Int, fifth: Int)

struct Poker {
    let pokerHands: [PokerHand]
    
    init(_ hands: [String]) {
        pokerHands = hands.compactMap(PokerHand.init)
    }
    
    func bestHands() -> String {
        pokerHands.max(by: { $0.score < $1.score })?.hand ?? ""
    }
}

struct PokerHand {
    let hand: String
    let ranks: [Int]
    let suits: [String]
    
    private let validHandPattern = /^(([2-9]|10|[JQKA])[SCDH]\s){4}(([2-9]|10|[JQKA])[SCDH])$/
    
    init?(_ hand: String) {
        guard hand.firstMatch(of: validHandPattern) != nil else {
            return nil
        }
        
        self.hand = hand
        
        let cards = hand.split(separator: " ").map(String.init)
        
        suits = Self.suits(of: cards)
        ranks = Self.ranks(of: cards)
    }

    var score: HandScore {
        let handRanks = ranksForScoring()
        let counts = counts(of: handRanks)
        let (handType, ranksSortedByHandType) = scoreComponents(from: counts)
        
        switch handType {
        case [4, 1]: return handScore(for: .fourOfAKind, with: ranksSortedByHandType)
        case [3, 2]: return handScore(for: .fullHouse, with: ranksSortedByHandType)
        case [3, 1, 1]: return handScore(for: .threeOfAKind, with: ranksSortedByHandType)
        case [2, 2, 1]: return handScore(for: .twoPair, with: ranksSortedByHandType)
        case [2, 1, 1, 1]: return handScore(for: .pair, with: ranksSortedByHandType)
        default:
            if isStraight(ranks: handRanks) && isFlush() {
                return handScore(for: .straightFlush, with: ranksSortedByHandType)
            }
            
            if isFlush() {
                return handScore(for: .flush, with: ranksSortedByHandType)
            }
            
            if isStraight(ranks: handRanks) {
                return handScore(for: .straight, with: ranksSortedByHandType)
            }
            
            return HandScore(handScore(for: .highCard, with: ranksSortedByHandType))
        }
    }
    
    private func ranksForScoring() -> [Int] {
        isFiveHighStraight() ? [5, 4, 3, 2, 1] : ranks
    }
    
    private func counts(of ranks: [Int]) -> [(count: Int, rank: Int)] {
        let counts = ranks.reduce(into: [:]) { counts, rank in
            counts[rank, default: 0] += 1
        }

        return Array(counts).map { (count: $0.1, rank: $0.0) }
    }

    private func scoreComponents(from counts: [(count: Int, rank: Int)]) -> ([Int], [Int]) {
        let countsSortedByHandType = counts.sorted(by: >)
        let handType = countsSortedByHandType.map { $0.count }

        let ranks = countsSortedByHandType.enumerated().reduce(into: [0, 0, 0, 0, 0]) { result, current in
            result[current.offset] = current.element.rank
        }

        return (handType: handType, ranks: ranks)
    }
    
    private func isFiveHighStraight() -> Bool {
        ranks.sorted(by: >) == [14, 5, 4, 3, 2]
    }
    
    private func isStraight(ranks: [Int]) -> Bool {
        let sorted = ranks.sorted(by: >)

        return sorted.count == 5 && sorted[0] - sorted[4] == 4
    }
    
    private func isFlush() -> Bool {
        Set(suits).count == 1
    }
    
    private func handScore(for score: ScoreType, with ranks: [Int]) -> HandScore {
        HandScore(score, ranks[0], ranks[1], ranks[2], ranks[3], ranks[4])
    }

    private static let cardRanks = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    private static func ranks(of cards: [String]) -> [Int] {
        cards.compactMap { String($0.dropLast()) }.compactMap { cardRanks.firstIndex(of: $0) }
    }

    private static func suits(of cards: [String]) -> [String] {
        cards.map { String($0.suffix(1)) }
    }
}