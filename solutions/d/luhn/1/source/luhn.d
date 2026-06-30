module luhn;

import std.ascii : isDigit;

pure bool valid(immutable string input)
{
    char[] digits;

    foreach (c; input)
    {
        if (c == ' ')
            continue;

        if (!isDigit(c))
            return false;

        digits ~= c;
    }

    if (digits.length <= 1)
        return false;

    int sum = 0;
    bool doubleDigit = false;

    for (int i = cast(int)digits.length - 1; i >= 0; --i)
    {
        int digit = digits[i] - '0';

        if (doubleDigit)
        {
            digit *= 2;
            if (digit > 9)
                digit -= 9;
        }

        sum += digit;
        doubleDigit = !doubleDigit;
    }

    return sum % 10 == 0;
}