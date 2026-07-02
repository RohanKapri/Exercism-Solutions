module [prime_factors]

prime_factors : U64 -> List U64
prime_factors = |value|
    extract_twos(value, [])

extract_twos : U64, List U64 -> List U64
extract_twos = |n, factors|
    if n % 2 == 0 then
        extract_twos(n // 2, List.append(factors, 2))
    else
        extract_threes(n, factors)

extract_threes : U64, List U64 -> List U64
extract_threes = |n, factors|
    if n % 3 == 0 then
        extract_threes(n // 3, List.append(factors, 3))
    else
        factorize_wheel(n, 5, 2, factors)

factorize_wheel : U64, U64, U64, List U64 -> List U64
factorize_wheel = |n, divisor, gap, factors|
    if n <= 1 then
        factors
    else if divisor * divisor > n then
        List.append(factors, n)
    else if n % divisor == 0 then
        factorize_wheel(n // divisor, divisor, gap, List.append(factors, divisor))
    else
        next_gap = if gap == 2 then 4 else 2
        factorize_wheel(n, divisor + gap, next_gap, factors)
        