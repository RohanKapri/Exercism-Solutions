module nth_prime;

// Function to check if a number is prime
bool isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return false;
    }
    return true;
}

// Function to find the nth prime number
int prime(int n) {
    if (n < 1) throw new Exception("There is no zeroth prime");
    
    int count = 0;
    int num = 1;
    
    while (count < n) {
        num++;
        if (isPrime(num)) {
            count++;
        }
    }
    
    return num;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // First prime
    assert(prime(1) == 2);

    static if (allTestsEnabled)
    {
        // Second prime
        assert(prime(2) == 3);

        // Sixth prime
        assert(prime(6) == 13);

        // Big prime
        assert(prime(10_001) == 10_4743);

        // There is no zeroth prime
        assertThrown(prime(0));
    }

}