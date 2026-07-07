module isbn_verifier;

import std.ascii : isDigit;

pure bool isValid(immutable string isbn)
{
    char[] s;

    foreach (c; isbn)
    {
        if (c != '-')
            s ~= c;
    }

    if (s.length != 10)
        return false;

    int sum = 0;

    foreach (i; 0 .. 9)
    {
        if (!isDigit(s[i]))
            return false;

        sum += (s[i] - '0') * (10 - cast(int)i);
    }

    if (s[9] == 'X')
    {
        sum += 10;
    }
    else if (isDigit(s[9]))
    {
        sum += s[9] - '0';
    }
    else
    {
        return false;
    }

    return sum % 11 == 0;
}