typealias Domino = (left: Int, right: Int)

struct Dominoes {
    let dominoes: [Domino]
    
    init(_ dominoes: [Domino]) {
        self.dominoes = dominoes
    }
    
    var chained: Bool {
        guard !dominoes.isEmpty else {
            return true
        }

        var chain: Set<Int> = [0]

        let startValue = dominoes[0].left

        return canChain(next: dominoes[0], closingWith: startValue, to: &chain)
    }

    private func canChain(next domino: Domino, closingWith startValue: Int, to chain: inout Set<Int>) -> Bool {
        if isComplete(chain: chain, endValue: domino.right, startValue: startValue) {
            return true
        }
        
        for (index, nextDomino) in dominoes.enumerated() {
            if chain.contains(index) {
                continue
            }

            for candidate in [nextDomino, flip(domino: nextDomino)] where candidate.left == domino.right {
                chain.insert(index)

                if canChain(next: candidate, closingWith: startValue, to: &chain) {
                    return true
                }

                chain.remove(index)
            }
        }
        
        return false
    }
    
    private func isComplete(chain: Set<Int>, endValue: Int, startValue: Int) -> Bool {
        dominoes.count == chain.count && endValue == startValue
    }
    
    private func flip(domino: Domino) -> Domino {
        (domino.right, domino.left)
    }
}