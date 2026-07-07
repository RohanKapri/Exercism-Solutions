module rectangles;

// Returns the number of rectangles in the ASCII diagram `strings`.
pure int rectangles(immutable string[] strings)
{
    if (strings.length == 0) return 0;

    size_t rowCount = strings.length;
    size_t colCount = strings[0].length;
    int rectangleCount = 0;

    // Function to check if a character at (row, col) is a corner '+'
    auto isCorner = (size_t row, size_t col) => strings[row][col] == '+';

    // Function to check if a horizontal line exists between two corners
    auto hasHorizontalLine = (size_t row, size_t colStart, size_t colEnd) {
        foreach (col; colStart + 1 .. colEnd) {
            if (strings[row][col] != '-' && strings[row][col] != '+') {
                return false;
            }
        }
        return true;
    };

    // Function to check if a vertical line exists between two corners
    auto hasVerticalLine = (size_t col, size_t rowStart, size_t rowEnd) {
        foreach (row; rowStart + 1 .. rowEnd) {
            if (strings[row][col] != '|' && strings[row][col] != '+') {
                return false;
            }
        }
        return true;
    };

    // Iterate over all pairs of corners
    foreach (row1; 0 .. rowCount) {
        foreach (col1; 0 .. colCount) {
            if (!isCorner(row1, col1)) continue;

            foreach (row2; row1 + 1 .. rowCount) {
                foreach (col2; col1 + 1 .. colCount) {
                    if (!isCorner(row2, col2)) continue;

                    // Check if the opposite corners are also corners
                    if (isCorner(row1, col2) && isCorner(row2, col1)) {
                        // Check for horizontal and vertical lines
                        if (hasHorizontalLine(row1, col1, col2) &&
                            hasHorizontalLine(row2, col1, col2) &&
                            hasVerticalLine(col1, row1, row2) &&
                            hasVerticalLine(col2, row1, row2)) {
                            rectangleCount++;
                        }
                    }
                }
            }
        }
    }

    return rectangleCount;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // No rows
    {
        immutable string[] strings = [
        ];
        assert(rectangles(strings) == 0);
    }

    static if (allTestsEnabled)
    {
        // No columns
        {
            immutable string[] strings = [
                "",
            ];
            assert(rectangles(strings) == 0);
        }

        // No rectangles
        {
            immutable string[] strings = [
                " ",
            ];
            assert(rectangles(strings) == 0);
        }

        // One rectangle
        {
            immutable string[] strings = [
                "+-+",
                "| |",
                "+-+",
            ];
            assert(rectangles(strings) == 1);
        }

        // Two rectangles without shared parts
        {
            immutable string[] strings = [
                "  +-+",
                "  | |",
                "+-+-+",
                "| |  ",
                "+-+  ",
            ];
            assert(rectangles(strings) == 2);
        }

        // Five rectangles with shared parts
        {
            immutable string[] strings = [
                "  +-+",
                "  | |",
                "+-+-+",
                "| | |",
                "+-+-+",
            ];
            assert(rectangles(strings) == 5);
        }

        // Rectangle of height 1 is counted
        {
            immutable string[] strings = [
                "+--+",
                "+--+",
            ];
            assert(rectangles(strings) == 1);
        }

        // Rectangle of width 1 is counted
        {
            immutable string[] strings = [
                "++",
                "||",
                "++",
            ];
            assert(rectangles(strings) == 1);
        }

        // 1x1 square is counted
        {
            immutable string[] strings = [
                "++",
                "++",
            ];
            assert(rectangles(strings) == 1);
        }

        // Only complete rectangles are counted
        {
            immutable string[] strings = [
                "  +-+",
                "    |",
                "+-+-+",
                "| | -",
                "+-+-+",
            ];
            assert(rectangles(strings) == 1);
        }

        // Rectangles can be of different sizes
        {
            immutable string[] strings = [
                "+------+----+",
                "|      |    |",
                "+---+--+    |",
                "|   |       |",
                "+---+-------+",
            ];
            assert(rectangles(strings) == 3);
        }

        // Corner is required for a rectangle to be complete
        {
            immutable string[] strings = [
                "+------+----+",
                "|      |    |",
                "+------+    |",
                "|   |       |",
                "+---+-------+",
            ];
            assert(rectangles(strings) == 2);
        }

        // Large input with many rectangles
        {
            immutable string[] strings = [
                "+---+--+----+",
                "|   +--+----+",
                "+---+--+    |",
                "|   +--+----+",
                "+---+--+--+-+",
                "+---+--+--+-+",
                "+------+  | |",
                "          +-+",
            ];
            assert(rectangles(strings) == 60);
        }

        // Rectangles must have four sides
        {
            immutable string[] strings = [
                "+-+ +-+",
                "| | | |",
                "+-+-+-+",
                "  | |  ",
                "+-+-+-+",
                "| | | |",
                "+-+ +-+",
            ];
            assert(rectangles(strings) == 5);
        }

        // Very large input
        {
            immutable string[] strings = [
                "      +-----+--------+    +-----+ ",
                "++---++-----+--------+---++-----++",
                "||+--++-----+-+-++   |   ||     ||",
                "|||  ||     +-+-++-+ |   ||     ||",
                "|||  ||     | | || | |   ||     ||",
                "||| +++-----+-+-++-+-+---++-+   ||",
                "||| |||     | | || | |+--++-+-+ ||",
                "||| +++---+-+-+-++-+-++--++-+ | ||",
                "||| |||+--+-+-+-+| | |+--++---+ ||",
                "||| ||||  | | | || | |+-+||     ||",
                "||+-++++--+-+++-++-+-++-+++---++||",
                "||  |+++--+-+++-+--+-+| |||   ||||",
                "+++-+++++---++--+-++-++-+++---+|||",
                " |+-+++++---++--+ || || |||   ||||",
                " |  +++++---++--+-++-++-++++  ||||",
                " |   ||||   |+----++-++-++++--+++|",
                " |   |+++---+|    || || ||    || |",
                "+++  |||+---++----+| || ||    || |",
                "|||  +++----++----++-++-++----++-+",
                "+++---++----++-----+-++-++----++  ",
                "                      +-+         ",
            ];
            assert(rectangles(strings) == 2063);
        }
    }
}
                      