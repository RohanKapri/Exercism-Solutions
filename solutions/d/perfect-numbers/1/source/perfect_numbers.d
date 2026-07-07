module perfect_numbers;

enum Classification
{
    DEFICIENT,
    PERFECT,
    ABUNDANT
}

pure Classification classify(immutable int input)
{
    if (input <= 0)
        throw new Exception("Classification is only possible for positive integers.");

    if (input == 1)
        return Classification.DEFICIENT;

    int sum = 1;

    for (int i = 2; i * i <= input; ++i)
    {
        if (input % i == 0)
        {
            sum += i;

            int other = input / i;
            if (other != i)
                sum += other;
        }
    }

    if (sum == input)
        return Classification.PERFECT;

    if (sum > input)
        return Classification.ABUNDANT;

    return Classification.DEFICIENT;
}