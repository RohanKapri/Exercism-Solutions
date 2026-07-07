module palindrome_products;

import std.exception : enforce;

struct Result {
    int value;
    int[2][] factors;
}

pure bool isPalindrome(int n)
{
    if (n < 10)
        return true;
    int divisor = 1;
    while (n / divisor >= 10)
        divisor *= 10;
    while (divisor >= 10)
    {
        if (n / divisor != n % 10)
            return false;
        n = (n % divisor) / 10;
        divisor /= 100;
    }
    return true;
}

pure int digitCount(int n)
{
    int count = 0;
    do
    {
        count++;
        n /= 10;
    }
    while (n > 0);
    return count;
}

pure int pow10(int exp)
{
    int result = 1;
    foreach (_; 0 .. exp)
        result *= 10;
    return result;
}

pure int buildPalindrome(int half, bool oddLength)
{
    int palindrome = half;
    int tail = oddLength ? half / 10 : half;
    while (tail > 0)
    {
        palindrome = palindrome * 10 + tail % 10;
        tail /= 10;
    }
    return palindrome;
}

private pure int[2][] factorsInRange(int product, int min, int max)
{
    int[2][] pairs;
    foreach (a; min .. max + 1)
    {
        if (product % a != 0)
            continue;
        immutable b = product / a;
        if (b < a || b > max)
            continue;
        pairs ~= [[a, b]];
    }
    return pairs;
}

private pure Result findSmallestByPalindrome(int min, int max)
{
    immutable int lo = min * min;
    immutable int hi = max * max;
    immutable int minLen = digitCount(lo);
    immutable int maxLen = digitCount(hi);

    foreach (len; minLen .. maxLen + 1)
    {
        immutable bool oddLength = (len & 1) != 0;
        immutable int halfLen = (len + 1) / 2;
        immutable int halfStart = pow10(halfLen - 1);
        immutable int halfEnd = pow10(halfLen) - 1;

        foreach (half; halfStart .. halfEnd + 1)
        {
            immutable int value = buildPalindrome(half, oddLength);
            if (value < lo)
                continue;
            if (value > hi)
                break;
            auto factors = factorsInRange(value, min, max);
            if (factors.length > 0)
                return Result(value, factors);
        }
    }
    return Result(0, []);
}

private pure Result findLargestByPalindrome(int min, int max)
{
    immutable int lo = min * min;
    immutable int hi = max * max;
    immutable int minLen = digitCount(lo);
    immutable int maxLen = digitCount(hi);

    foreach_reverse (len; minLen .. maxLen + 1)
    {
        immutable bool oddLength = (len & 1) != 0;
        immutable int halfLen = (len + 1) / 2;
        immutable int halfStart = pow10(halfLen - 1);
        immutable int halfEnd = pow10(halfLen) - 1;

        foreach_reverse (half; halfStart .. halfEnd + 1)
        {
            immutable int value = buildPalindrome(half, oddLength);
            if (value > hi)
                continue;
            if (value < lo)
                continue;
            auto factors = factorsInRange(value, min, max);
            if (factors.length > 0)
                return Result(value, factors);
        }
    }
    return Result(0, []);
}

pure Result smallest(int min, int max)
{
    enforce(min <= max);
    return findSmallestByPalindrome(min, max);
}

pure Result largest(int min, int max)
{
    enforce(min <= max);
    return findLargestByPalindrome(min, max);
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Find the smallest palindrome from single digit factors
    {
        auto result = smallest(1, 9);
        assert(result.value == 1);
        assert(result.factors == [[1, 1]]);
    }

    static if (allTestsEnabled)
    {
        // Find the largest palindrome from single digit factors
        {
            auto result = largest(1, 9);
            assert(result.value == 9);
            assert(result.factors == [[1, 9], [3, 3]]);
        }

        // Find the smallest palindrome from double digit factors
        {
            auto result = smallest(10, 99);
            assert(result.value == 121);
            assert(result.factors == [[11, 11]]);
        }

        // Find the largest palindrome from double digit factors
        {
            auto result = largest(10, 99);
            assert(result.value == 9009);
            assert(result.factors == [[91, 99]]);
        }

        // Find the smallest palindrome from triple digit factors
        {
            auto result = smallest(100, 999);
            assert(result.value == 10201);
            assert(result.factors == [[101, 101]]);
        }

        // Find the largest palindrome from triple digit factors
        {
            auto result = largest(100, 999);
            assert(result.value == 906609);
            assert(result.factors == [[913, 993]]);
        }

        // Find the smallest palindrome from four digit factors
        {
            auto result = smallest(1000, 9999);
            assert(result.value == 1002001);
            assert(result.factors == [[1001, 1001]]);
        }

        // Find the largest palindrome from four digit factors
        {
            auto result = largest(1000, 9999);
            assert(result.value == 99000099);
            assert(result.factors == [[9901, 9999]]);
        }

        // Empty result for smallest if no palindrome in the range
        {
            auto result = smallest(1002, 1003);
            assert(result.value == 0);
            assert(result.factors.length == 0);
        }

        // Empty result for largest if no palindrome in the range
        {
            auto result = largest(15, 15);
            assert(result.value == 0);
            assert(result.factors.length == 0);
        }

        // Error result for smallest if min is more than max
        assertThrown(smallest(10000, 1));

        // Error result for largest if min is more than max
        assertThrown(largest(2, 1));

        // Smallest product does not use the smallest factor
        {
            auto result = smallest(3215, 4000);
            assert(result.value == 10988901);
            assert(result.factors == [[3297, 3333]]);
        }
    }
}