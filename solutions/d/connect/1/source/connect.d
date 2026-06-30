module connect;

private pure bool connects(
    scope const ubyte[] cells,
    size_t rows,
    size_t cols,
    ubyte player,
    bool vertical,
)
{
    immutable size_t n = rows * cols;
    bool[] seen = new bool[n];
    size_t[] queue = new size_t[n];
    size_t head;
    size_t tail;

    if (vertical)
    {
        foreach (c; 0 .. cols)
        {
            immutable size_t idx = c;
            if (cells[idx] == player)
            {
                seen[idx] = true;
                queue[tail++] = idx;
            }
        }

        while (head < tail)
        {
            immutable size_t idx = queue[head++];
            immutable size_t r = idx / cols;
            immutable size_t c = idx % cols;

            if (r == rows - 1)
                return true;

            if (c > 0)
                enqueueNeighbor(cells, seen, queue, tail, idx - 1, player);
            if (c + 1 < cols)
                enqueueNeighbor(cells, seen, queue, tail, idx + 1, player);
            if (r + 1 < rows)
            {
                enqueueNeighbor(cells, seen, queue, tail, idx + cols, player);
                if (c > 0)
                    enqueueNeighbor(cells, seen, queue, tail, idx + cols - 1, player);
            }
            if (r > 0)
            {
                enqueueNeighbor(cells, seen, queue, tail, idx - cols, player);
                if (c + 1 < cols)
                    enqueueNeighbor(cells, seen, queue, tail, idx - cols + 1, player);
            }
        }
    }
    else
    {
        foreach (r; 0 .. rows)
        {
            immutable size_t idx = r * cols;
            if (cells[idx] == player)
            {
                seen[idx] = true;
                queue[tail++] = idx;
            }
        }

        while (head < tail)
        {
            immutable size_t idx = queue[head++];
            immutable size_t r = idx / cols;
            immutable size_t c = idx % cols;

            if (c == cols - 1)
                return true;

            if (c > 0)
                enqueueNeighbor(cells, seen, queue, tail, idx - 1, player);
            if (c + 1 < cols)
                enqueueNeighbor(cells, seen, queue, tail, idx + 1, player);
            if (r + 1 < rows)
            {
                enqueueNeighbor(cells, seen, queue, tail, idx + cols, player);
                if (c > 0)
                    enqueueNeighbor(cells, seen, queue, tail, idx + cols - 1, player);
            }
            if (r > 0)
            {
                enqueueNeighbor(cells, seen, queue, tail, idx - cols, player);
                if (c + 1 < cols)
                    enqueueNeighbor(cells, seen, queue, tail, idx - cols + 1, player);
            }
        }
    }

    return false;
}

private pure void enqueueNeighbor(
    scope const ubyte[] cells,
    bool[] seen,
    size_t[] queue,
    ref size_t tail,
    size_t neighbor,
    ubyte player,
)
{
    if (!seen[neighbor] && cells[neighbor] == player)
    {
        seen[neighbor] = true;
        queue[tail++] = neighbor;
    }
}

pure string winner(immutable string[] board)
{
    if (board.length == 0)
        return "";

    immutable size_t rows = board.length;
    immutable size_t cols = (board[0].length + 1) / 2;
    immutable size_t n = rows * cols;

    ubyte[] cells = new ubyte[n];
    foreach (r; 0 .. rows)
        foreach (c; 0 .. cols)
            cells[r * cols + c] = cast(ubyte) board[r][r + 2 * c];

    if (connects(cells, rows, cols, 'X', false))
        return "X";
    if (connects(cells, rows, cols, 'O', true))
        return "O";
    return "";
}

unittest
{
    immutable int allTestsEnabled = 0;

    // An empty board has no winner
    {
        immutable string[] board = [
            ". . . . .",
            " . . . . .",
            "  . . . . .",
            "   . . . . .",
            "    . . . . .",
        ];
        assert(winner(board) == "");
    }

    static if (allTestsEnabled)
    {
        // X can win on a 1x1 board
        {
            immutable string[] board = [
                "X",
            ];
            assert(winner(board) == "X");
        }

        // O can win on a 1x1 board
        {
            immutable string[] board = [
                "O",
            ];
            assert(winner(board) == "O");
        }

        // Only edges does not make a winner
        {
            immutable string[] board = [
                "O O O X",
                " X . . X",
                "  X . . X",
                "   X O O O",
            ];
            assert(winner(board) == "");
        }

        // Illegal diagonal does not make a winner
        {
            immutable string[] board = [
                "X O . .",
                " O X X X",
                "  O X O .",
                "   . O X .",
                "    X X O O",
            ];
            assert(winner(board) == "");
        }

        // Nobody wins crossing adjacent angles
        {
            immutable string[] board = [
                "X . . .",
                " . X O .",
                "  O . X O",
                "   . O . X",
                "    . . O .",
            ];
            assert(winner(board) == "");
        }

        // X wins crossing from left to right
        {
            immutable string[] board = [
                ". O . .",
                " O X X X",
                "  O X O .",
                "   X X O X",
                "    . O X .",
            ];
            assert(winner(board) == "X");
        }

        // X wins with left-hand dead end fork
        {
            immutable string[] board = [
                ". . X .",
                " X X . .",
                "  . X X X",
                "   O O O O",
            ];
            assert(winner(board) == "X");
        }

        // X wins with right-hand dead end fork
        {
            immutable string[] board = [
                ". . X X",
                " X X . .",
                "  . X X .",
                "   O O O O",
            ];
            assert(winner(board) == "X");
        }

        // O wins crossing from top to bottom
        {
            immutable string[] board = [
                ". O . .",
                " O X X X",
                "  O O O .",
                "   X X O X",
                "    . O X .",
            ];
            assert(winner(board) == "O");
        }

        // X wins using a convoluted path
        {
            immutable string[] board = [
                ". X X . .",
                " X . X . X",
                "  . X . X .",
                "   . X X . .",
                "    O O O O O",
            ];
            assert(winner(board) == "X");
        }

        // X wins using a spiral path
        {
            immutable string[] board = [
                "O X X X X X X X X",
                " O X O O O O O O O",
                "  O X O X X X X X O",
                "   O X O X O O O X O",
                "    O X O X X X O X O",
                "     O X O O O X O X O",
                "      O X X X X X O X O",
                "       O O O O O O O X O",
                "        X X X X X X X X O",
            ];
            assert(winner(board) == "X");
        }
    }
}