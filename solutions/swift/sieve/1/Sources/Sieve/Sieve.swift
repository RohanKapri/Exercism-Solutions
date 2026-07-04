func sieve(limit: Int) -> [Int] {
    sieve(upTo: limit).primes()
}

private func sieve(upTo limit: Int) -> [Bool] {
    guard limit >= 2 else {
        return []
    }

    var sieve = [Bool](repeating: true, count: limit - 1)

    var candidate = 2
    while candidate * candidate <= limit {
        if sieve[candidate - 2] {
            for multiple in stride(from: candidate * candidate, through: limit, by: candidate) {
                sieve[multiple - 2] = false
            }
        }
        candidate += 1
    }

    return sieve
}

extension Array where Element == Bool {
    func primes() -> [Int] {
        enumerated().filter(\.element).map { $0.offset + 2 }
    }
}