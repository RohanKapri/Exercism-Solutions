func primeFactors(_ number: Int64) -> [Int64] {
    var factors = [Int64]()
    var divisor = Int64(2)
    var n = number

    while n > 1 {
        if divisor * divisor > n {
            factors.append(n)
            break
        }

        while n % divisor == 0 {
            factors.append(divisor)
            n /= divisor
        }
        divisor += 1
    }

    return factors
}