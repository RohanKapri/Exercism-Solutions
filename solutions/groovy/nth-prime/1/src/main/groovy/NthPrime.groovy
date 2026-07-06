class NthPrime {

    private static boolean isPrime(int n) {
        if (n == 1) return false
        if (n == 2) return true
        !(2..Math.sqrt(n)).any { n % it == 0 }
    }

    static int nth(int n) {
        if (n < 1) throw new ArithmeticException()

        int primes = 0
        int i = 1

        while (primes < n) {
            i++
            if (isPrime(i)) primes++
        }
        i
    }
}