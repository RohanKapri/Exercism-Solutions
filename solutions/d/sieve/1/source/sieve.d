module sieve;

pure int[] primes(immutable int limit)
{
    if (limit < 2)
        return [];

    bool[] composite;
    composite.length = limit + 1;

    for (int i = 2; i * i <= limit; ++i)
    {
        if (!composite[i])
        {
            for (int j = i * i; j <= limit; j += i)
                composite[j] = true;
        }
    }

    int[] result;
    for (int i = 2; i <= limit; ++i)
    {
        if (!composite[i])
            result ~= i;
    }

    return result;
}