pub fn prime(n: u32) -> u32 {
    if n == 0 {
        panic!("there is no zeroth prime");
    }
    
    // Start with a small array of known primes
    let mut primes: Array<u32> = array![2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    
    // If n is within our initial primes, return directly
    let primes_len: u32 = primes.len().try_into().unwrap();
    if n <= primes_len {
        return *primes.at(n - 1);
    }
    
    let mut candidate = 31_u32; // Start after our last known prime
    
    // Continue finding primes until we have n of them
    loop {
        let current_len: u32 = primes.len().try_into().unwrap();
        if current_len >= n {
            break;
        }
        
        if is_prime_using_known_primes(candidate, @primes) {
            primes.append(candidate);
        }
        candidate += 2; // Skip even numbers
    };
    
    *primes.at(n - 1)
}

fn is_prime_using_known_primes(n: u32, primes: @Array<u32>) -> bool {
    let mut i = 0_u32;
    let primes_len: u32 = primes.len().try_into().unwrap();
    
    loop {
        if i >= primes_len {
            break true;
        }
        
        let prime = *primes.at(i);
        
        // If prime squared is greater than n, n is prime
        if prime * prime > n {
            break true;
        }
        
        // If n is divisible by this prime, it's not prime
        if n % prime == 0 {
            break false;
        }
        
        i += 1;
    }
}
   