module roman_numerals;

string convert(ulong number)
{
    immutable ulong[] values =
    [
        1000, 900, 500, 400,
        100,  90,  50,  40,
        10,    9,   5,   4,
        1
    ];

    immutable string[] numerals =
    [
        "M",  "CM", "D",  "CD",
        "C",  "XC", "L",  "XL",
        "X",  "IX", "V",  "IV",
        "I"
    ];

    string result;

    foreach (i; 0 .. values.length)
    {
        while (number >= values[i])
        {
            result ~= numerals[i];
            number -= values[i];
        }
    }

    return result;
}