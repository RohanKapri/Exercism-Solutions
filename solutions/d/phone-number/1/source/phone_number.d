module phone_number;

pure string clean(immutable string phrase)
{
    string digits;

    foreach (c; phrase)
    {
        if (c >= '0' && c <= '9')
        {
            digits ~= c;
        }
        else if (c == ' ' || c == '-' || c == '.' ||
                 c == '(' || c == ')' || c == '+')
        {
            // ignore allowed punctuation
        }
        else
        {
            throw new Exception("Invalid character");
        }
    }

    if (digits.length == 11)
    {
        if (digits[0] != '1')
            throw new Exception("Invalid country code");

        digits = digits[1 .. $];
    }
    else if (digits.length != 10)
    {
        throw new Exception("Invalid number of digits");
    }

    if (digits[0] < '2' || digits[0] > '9')
        throw new Exception("Invalid area code");

    if (digits[3] < '2' || digits[3] > '9')
        throw new Exception("Invalid exchange code");

    return digits;
}