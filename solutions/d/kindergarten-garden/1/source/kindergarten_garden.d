module kindergarten_garden;

import std.array : split;

pure string[4] plants(immutable string diagram, immutable string student)
{
    immutable string[] students =
    [
        "Alice", "Bob", "Charlie", "David",
        "Eve", "Fred", "Ginny", "Harriet",
        "Ileana", "Joseph", "Kincaid", "Larry"
    ];

    size_t index = 0;
    foreach (i, name; students)
    {
        if (name == student)
        {
            index = i;
            break;
        }
    }

    auto rows = split(diagram, "\n");
    size_t pos = index * 2;

    string[4] result;

    result[0] = decode(rows[0][pos]);
    result[1] = decode(rows[0][pos + 1]);
    result[2] = decode(rows[1][pos]);
    result[3] = decode(rows[1][pos + 1]);

    return result;
}

pure string decode(char c)
{
    switch (c)
    {
        case 'G': return "grass";
        case 'C': return "clover";
        case 'R': return "radishes";
        case 'V': return "violets";
        default: return "";
    }
}