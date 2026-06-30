module ocr_numbers;

private pure uint trit(char c) @safe
{
    switch (c)
    {
        case ' ': return 0;
        case '|': return 1;
        case '_': return 2;
        default: return 3;
    }
}

private pure uint cellKey(immutable string[] rows, size_t block, size_t col) @safe
{
    uint key = 0;
    foreach (immutable r; 0 .. 3)
    {
        immutable string row = rows[block + r];
        key = ((key * 3 + trit(row[col])) * 3 + trit(row[col + 1])) * 3 + trit(row[col + 2]);
    }
    return key;
}

private pure uint encodeLines(immutable string l0, immutable string l1, immutable string l2) @safe
{
    uint key = 0;
    foreach (immutable line; [l0, l1, l2])
        foreach (immutable char c; line)
            key = key * 3 + trit(c);
    return key;
}

private enum uint KEY_0 = encodeLines(" _ ", "| |", "|_|");
private enum uint KEY_1 = encodeLines("   ", "  |", "  |");
private enum uint KEY_2 = encodeLines(" _ ", " _|", "|_ ");
private enum uint KEY_3 = encodeLines(" _ ", " _|", " _|");
private enum uint KEY_4 = encodeLines("   ", "|_|", "  |");
private enum uint KEY_5 = encodeLines(" _ ", "|_ ", " _|");
private enum uint KEY_6 = encodeLines(" _ ", "|_ ", "|_|");
private enum uint KEY_7 = encodeLines(" _ ", "  |", "  |");
private enum uint KEY_8 = encodeLines(" _ ", "|_|", "|_|");
private enum uint KEY_9 = encodeLines(" _ ", "|_|", " _|");

private pure char digitFromKey(uint key) @safe
{
    switch (key)
    {
        case KEY_0: return '0';
        case KEY_1: return '1';
        case KEY_2: return '2';
        case KEY_3: return '3';
        case KEY_4: return '4';
        case KEY_5: return '5';
        case KEY_6: return '6';
        case KEY_7: return '7';
        case KEY_8: return '8';
        case KEY_9: return '9';
        default: return '?';
    }
}

pure string convert(immutable string[] rows)
{
    if (rows.length % 4 != 0)
        throw new Exception("Invalid input size");

    if (rows.length == 0)
        return "";

    immutable size_t width = rows[0].length;
    if (width % 3 != 0)
        throw new Exception("Invalid input size");

    foreach (row; rows)
    {
        if (row.length != width)
            throw new Exception("Invalid input size");
    }

    immutable size_t blocks = rows.length / 4;
    immutable size_t digitsPerBlock = width / 3;
    immutable size_t commaCount = blocks > 1 ? blocks - 1 : 0;
    char[] result = new char[digitsPerBlock * blocks + commaCount];
    size_t pos = 0;

    for (size_t block = 0; block < rows.length; block += 4)
    {
        if (block > 0)
            result[pos++] = ',';

        for (size_t col = 0; col < width; col += 3)
            result[pos++] = digitFromKey(cellKey(rows, block, col));
    }

    return result.idup;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Recognizes 0
    {
        immutable string[] rows = [
            " _ ",
            "| |",
            "|_|",
            "   ",
        ];
        assert(convert(rows) == "0");
    }

    static if (allTestsEnabled)
    {
        // Recognizes 1
        {
            immutable string[] rows = [
                "   ",
                "  |",
                "  |",
                "   ",
            ];
            assert(convert(rows) == "1");
        }

        // Unreadable but correctly sized inputs return ?
        {
            immutable string[] rows = [
                "   ",
                "  _",
                "  |",
                "   ",
            ];
            assert(convert(rows) == "?");
        }

        // Input with a number of lines that is not a multiple of four raises an error
        {
            immutable string[] rows = [
                " _ ",
                "| |",
                "   ",
            ];
            assertThrown(convert(rows));
        }

        // Input with a number of columns that is not a multiple of three raises an error
        {
            immutable string[] rows = [
                "    ",
                "   |",
                "   |",
                "    ",
            ];
            assertThrown(convert(rows));
        }

        // Recognizes 110101100
        {
            immutable string[] rows = [
                "       _     _        _  _ ",
                "  |  || |  || |  |  || || |",
                "  |  ||_|  ||_|  |  ||_||_|",
                "                           ",
            ];
            assert(convert(rows) == "110101100");
        }

        // Garbled numbers in a string are replaced with ?
        {
            immutable string[] rows = [
                "       _     _           _ ",
                "  |  || |  || |     || || |",
                "  |  | _|  ||_|  |  ||_||_|",
                "                           ",
            ];
            assert(convert(rows) == "11?10?1?0");
        }

        // Recognizes 2
        {
            immutable string[] rows = [
                " _ ",
                " _|",
                "|_ ",
                "   ",
            ];
            assert(convert(rows) == "2");
        }

        // Recognizes 3
        {
            immutable string[] rows = [
                " _ ",
                " _|",
                " _|",
                "   ",
            ];
            assert(convert(rows) == "3");
        }

        // Recognizes 4
        {
            immutable string[] rows = [
                "   ",
                "|_|",
                "  |",
                "   ",
            ];
            assert(convert(rows) == "4");
        }

        // Recognizes 5
        {
            immutable string[] rows = [
                " _ ",
                "|_ ",
                " _|",
                "   ",
            ];
            assert(convert(rows) == "5");
        }

        // Recognizes 6
        {
            immutable string[] rows = [
                " _ ",
                "|_ ",
                "|_|",
                "   ",
            ];
            assert(convert(rows) == "6");
        }

        // Recognizes 7
        {
            immutable string[] rows = [
                " _ ",
                "  |",
                "  |",
                "   ",
            ];
            assert(convert(rows) == "7");
        }

        // Recognizes 8
        {
            immutable string[] rows = [
                " _ ",
                "|_|",
                "|_|",
                "   ",
            ];
            assert(convert(rows) == "8");
        }

        // Recognizes 9
        {
            immutable string[] rows = [
                " _ ",
                "|_|",
                " _|",
                "   ",
            ];
            assert(convert(rows) == "9");
        }

        // Recognizes string of decimal numbers
        {
            immutable string[] rows = [
                "    _  _     _  _  _  _  _  _ ",
                "  | _| _||_||_ |_   ||_||_|| |",
                "  ||_  _|  | _||_|  ||_| _||_|",
                "                              ",
            ];
            assert(convert(rows) == "1234567890");
        }

        // Numbers separated by empty lines are recognized. Lines are joined by commas.
        {
            immutable string[] rows = [
                "    _  _ ",
                "  | _| _|",
                "  ||_  _|",
                "         ",
                "    _  _ ",
                "|_||_ |_ ",
                "  | _||_|",
                "         ",
                " _  _  _ ",
                "  ||_||_|",
                "  ||_| _|",
                "         ",
            ];
            assert(convert(rows) == "123,456,789");
        }
    }
}