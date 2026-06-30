module armstrong_numbers;

pure int power(int base, int exponent)
{
    int product = 1;
    while (exponent != 0)
    {
        if ((exponent & 1) != 0)
        {
            product *= base;
        }

        base *= base;
        exponent >>= 1;
    }

    return product;
}

pure bool isArmstrongNumber(immutable int number)
{
    int count = 0;
    int n = number;
    while (n != 0) {
        ++count;
        n /= 10;
    }

    int total = 0;
    n = number;
    while (n != 0) {
        total += power(n % 10, count);
        n /= 10;
    }

    return total == number;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Zero is an Armstrong number
    assert(isArmstrongNumber(0));

    static if (allTestsEnabled)
    {
        // Single digit numbers are Armstrong numbers
        assert(isArmstrongNumber(5));

        // There are no 2 digit Armstrong numbers
        assert(!isArmstrongNumber(10));

        // Three digit number that is an Armstrong number
        assert(isArmstrongNumber(153));

        // Three digit number that is not an Armstrong number
        assert(!isArmstrongNumber(100));

        // Four digit number that is an Armstrong number
        assert(isArmstrongNumber(9474));

        // Four digit number that is not an Armstrong number
        assert(!isArmstrongNumber(9475));

        // Seven digit number that is an Armstrong number
        assert(isArmstrongNumber(9926315));

        // Seven digit number that is not an Armstrong number
        assert(!isArmstrongNumber(9926314));
    }
}