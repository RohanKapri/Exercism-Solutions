# Returns the prime numbers less than or equal to the given limit.
#
# + 'limit - as an int
# + return - prime numbers as an array of int
public function primes(int 'limit) returns int[] {
    boolean[] sieve = [];
    int[] primes = [];

    foreach int i in 2 ... 'limit {
        sieve[i] = true;
    }

    foreach int i in 2 ... 'limit {
        if sieve[i] {
            primes.push(i);
            int multiple = i * 2;
            while multiple <= 'limit {
                sieve[multiple] = false;
                multiple += i;
            }
        }
    }

    return primes;
}