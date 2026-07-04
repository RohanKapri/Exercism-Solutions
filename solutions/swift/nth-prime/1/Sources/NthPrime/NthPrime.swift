enum PrimeError: Error {
  case noZerothPrime
}

func nthPrime(_ number: Int) throws -> Int? {
  guard number > 0 else {
    throw PrimeError.noZerothPrime
  }

  var count = 0
  var candidate = 1

  while count < number {
    candidate += 1

    if isPrime(candidate) {
      count += 1
    }
  }

  return candidate
}

private func isPrime(_ n: Int) -> Bool {
  guard n >= 2 else { return false }

  var divisor = 2

  while divisor * divisor <= n {
    if n % divisor == 0 { return false }
    divisor += 1
  }

  return true
}