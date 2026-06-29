public static class PalindromeProducts
{
    public static (int, IEnumerable<(int,int)>) Largest(int minFactor, int maxFactor)
    {
        if (minFactor > maxFactor)
            throw new ArgumentException("min cannot be greater than max");

        int maxPal = -1;
        var factors = new List<(int ,int)>();

        for (int i = maxFactor; i >= minFactor; i--)
        {
            // largest possible prod for this loop is i * maxFactor
            // if its smaller then are current maxPal stop early
            if (i * maxFactor < maxPal) break;

            for (int j = i; j >= minFactor; j--)
            {
                int prod = i * j;

                // we can throw away prods smaller than the current maxPal
                if (prod < maxPal) break;

                if (IsPalindrome(prod))
                {
                    if (prod > maxPal)
                    {
                        maxPal = prod;
                        factors.Clear();
                    }

                    factors.Add((j,i));// add factors smallest to largest
                }
            }
        }

        if (maxPal == -1)
            throw new ArgumentException("no palindromes exist");

        return (maxPal, factors);
    }

    public static (int, IEnumerable<(int,int)>) Smallest(int minFactor, int maxFactor)
    {
        if (minFactor > maxFactor)
            throw new ArgumentException("min cannot be greater than max");

        int minPal = int.MaxValue;
        var factors = new List<(int, int)>();

        for (int i = minFactor; i <= maxFactor; i++)
        {
            // smallest possible prod for the current loop is i * i
            // if the prod is larger then the current minPal stop early
            if (i * i > minPal) break;

            for (int j = i; j <= maxFactor; j++)
            {
                int prod = i * j;

                // we can thow away any prod larger than the current minPal
                if (prod > minPal) break;

                if (IsPalindrome(prod))
                {
                    if (prod < minPal)
                    {
                        // new min found clear old factors
                        minPal = prod;
                        factors.Clear();
                    }

                    factors.Add((i,j)); // add factors smallest to largest
                }
            }
        }

        if (minPal == int.MaxValue)
            throw new ArgumentException("no palindromes exist");

        return (minPal, factors);
    }

    private static bool IsPalindrome(int num)
    {
        int rev = 0;
        int tmp = num;

        while (tmp > 0)
        {
            rev = (rev * 10) + (tmp % 10);
            tmp /= 10;
        }
        return rev == num;
    }
}