#include "prime_factors.h"
namespace prime_factors {
std::vector<long long> of (long int number) {
    std::vector<long long> factors;
    
    if (number <= 1) {
        return factors;
    }
    // Handle factor 2
    while (number % 2 == 0) {
        factors.push_back(2);
        number /= 2;
    }
    // Handle odd prime factors up to sqrt(number)
    for (long long i = 3; i * i <= number; i += 2) {
        while (number % i == 0) {
            factors.push_back(i);
            number /= i;
        }
    }
    // If number is still greater than 1 after the loop, it's a prime factor itself
    if (number > 1) {
        factors.push_back(number);
    }
    return factors;
}
}  // namespace prime_factors
