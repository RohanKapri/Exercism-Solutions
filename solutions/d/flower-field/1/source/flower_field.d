module flower_field;

pure string[] annotate(immutable string[] garden)
{
    const rows = garden.length;
    if (rows == 0) return [];

    string[] result;
    result.length = rows;

    foreach (r; 0 .. rows)
    {
        const cols = garden[r].length;
        char[] rowChars = new char[cols];  

        foreach (c; 0 .. cols)
        {
            if (garden[r][c] == '*') {
                rowChars[c] = '*';  
                continue;
            }

            int count = 0;
            // Check all 8 neighbors
            foreach (dr; [-1, 0, 1])
            foreach (dc; [-1, 0, 1])
            {
                if (dr == 0 && dc == 0) continue;

                const rr = cast(int) r + dr;
                const cc = cast(int) c + dc;

                if (0 <= rr && rr < cast(int) rows)
                {
                    const ncols = garden[rr].length; // be robust if rows differ in length
                    if (0 <= cc && cc < cast(int) ncols && garden[rr][cc] == '*')
                        ++count;
                }
            }

            rowChars[c] = (count == 0) ? ' ' : cast(char)('0' + count);  
        }

        result[r] = rowChars.idup;  
    }

    return result;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // No rows
    {
        immutable string[] garden = [
        ];
        string[] expected = [
        ];
        assert(annotate(garden) == expected);
    }

    static if (allTestsEnabled)
    {
        // No columns
        {
            immutable string[] garden = [
                "",
            ];
            string[] expected = [
                "",
            ];
            assert(annotate(garden) == expected);
        }

        // No flowers
        {
            immutable string[] garden = [
                "   ",
                "   ",
                "   ",
            ];
            string[] expected = [
                "   ",
                "   ",
                "   ",
            ];
            assert(annotate(garden) == expected);
        }

        // garden with only flowers
        {
            immutable string[] garden = [
                "***",
                "***",
                "***",
            ];
            string[] expected = [
                "***",
                "***",
                "***",
            ];
            assert(annotate(garden) == expected);
        }

        // Flower surrounded by spaces
        {
            immutable string[] garden = [
                "   ",
                " * ",
                "   ",
            ];
            string[] expected = [
                "111",
                "1*1",
                "111",
            ];
            assert(annotate(garden) == expected);
        }

        // Space surrounded by flowers
        {
            immutable string[] garden = [
                "***",
                "* *",
                "***",
            ];
            string[] expected = [
                "***",
                "*8*",
                "***",
            ];
            assert(annotate(garden) == expected);
        }

        // Horizontal line
        {
            immutable string[] garden = [
                " * * ",
            ];
            string[] expected = [
                "1*2*1",
            ];
            assert(annotate(garden) == expected);
        }

        // Horizontal line, flowers at edges
        {
            immutable string[] garden = [
                "*   *",
            ];
            string[] expected = [
                "*1 1*",
            ];
            assert(annotate(garden) == expected);
        }

        // Vertical line
        {
            immutable string[] garden = [
                " ",
                "*",
                " ",
                "*",
                " ",
            ];
            string[] expected = [
                "1",
                "*",
                "2",
                "*",
                "1",
            ];
            assert(annotate(garden) == expected);
        }

        // Vertical line, flowers at edges
        {
            immutable string[] garden = [
                "*",
                " ",
                " ",
                " ",
                "*",
            ];
            string[] expected = [
                "*",
                "1",
                " ",
                "1",
                "*",
            ];
            assert(annotate(garden) == expected);
        }

        // Cross
        {
            immutable string[] garden = [
                "  *  ",
                "  *  ",
                "*****",
                "  *  ",
                "  *  ",
            ];
            string[] expected = [
                " 2*2 ",
                "25*52",
                "*****",
                "25*52",
                " 2*2 ",
            ];
            assert(annotate(garden) == expected);
        }

        // Large garden
        {
            immutable string[] garden = [
                " *  * ",
                "  *   ",
                "    * ",
                "   * *",
                " *  * ",
                "      ",
            ];
            string[] expected = [
                "1*22*1",
                "12*322",
                " 123*2",
                "112*4*",
                "1*22*2",
                "111111",
            ];
            assert(annotate(garden) == expected);
        }
    }
}
      