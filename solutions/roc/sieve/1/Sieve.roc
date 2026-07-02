module [primes]

primes : U64 -> List U64
primes = |limit|
    if limit < 2 then
        []
    else
        candidates = List.range { start: At 2, end: At limit }
        sieve candidates [] limit

sieve : List U64, List U64, U64 -> List U64
sieve = |candidates, primes_found, limit|
    when candidates is
        [] -> List.reverse primes_found
        [first, .. as rest] ->
            # Early stopping: if prime² > limit, all remaining numbers are prime
            if first * first > limit then
                # Append all remaining candidates as primes (in correct order)
                # First add 'first' to primes_found, then append rest
                all_primes = List.prepend primes_found first
                    |> List.reverse
                # Append each element of rest in order
                List.walk rest all_primes \acc, n ->
                    List.append acc n
            else
                # Filter out multiples of 'first'
                remaining = List.keep_if rest \n ->
                    n % first != 0
                
                sieve remaining (List.prepend primes_found first) limit
    