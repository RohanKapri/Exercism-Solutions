module [prime]

prime : U64 -> Result U64 _
prime = |number|
    if number == 0 then
        Err {}
    else
        Ok (findNthPrime number 2 0)

# Helper function to find the nth prime
# n: the target prime position
# candidate: current number to check
# count: number of primes found so far
findNthPrime : U64, U64, U64 -> U64
findNthPrime = |n, candidate, count|
    if isPrime candidate then
        if count + 1 == n then
            candidate
        else
            findNthPrime n (candidate + 1) (count + 1)
    else
        findNthPrime n (candidate + 1) count

# Check if a number is prime
isPrime : U64 -> Bool
isPrime = |n|
    if n < 2 then
        Bool.false
    else if n == 2 then
        Bool.true
    else if n % 2 == 0 then
        Bool.false
    else
        isPrimeHelper n 3

# Helper to check if n is prime by testing odd divisors from 3 up to sqrt(n)
isPrimeHelper : U64, U64 -> Bool
isPrimeHelper = |n, divisor|
    # Check if divisor * divisor > n (equivalent to divisor > sqrt(n))
    if divisor * divisor > n then
        Bool.true
    else if n % divisor == 0 then
        Bool.false
    else
        isPrimeHelper n (divisor + 2)
                                           