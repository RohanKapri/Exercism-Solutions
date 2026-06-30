module state_of_tic_tac_toe;

import std.algorithm : count;
import std.conv : to;
import std.exception : enforce;
import std.typecons : tuple;

enum State {
    win,
    draw,
    ongoing
}

pure State gamestate(const string[] board)
{
    string[] threePositions = searchPositions(board);
    int winners = lookForWinner(threePositions);
    auto invalidResult = isInvalid(threePositions);
    bool invalid = invalidResult[0];
    int empty = invalidResult[1];

    enforce(!invalid && winners <= 1, "Invalid board");

    if (winners == 1)
        return State.win;
    else if (empty == 0)
        return State.draw;
    
    return State.ongoing;
}

pure string[] searchPositions(const string[] board)
{
    return [
        board[0],
        board[1],
        board[2],
        [board[0][0], board[1][0], board[2][0]].to!string,
        [board[0][1], board[1][1], board[2][1]].to!string,
        [board[0][2], board[1][2], board[2][2]].to!string,
        [board[0][0], board[1][1], board[2][2]].to!string,
        [board[0][2], board[1][1], board[2][0]].to!string,
    ];
}

pure auto isInvalid(const string[] threePositions)
{
    int countX = 0;
    int countO = 0;
    int empty = 0;

    foreach (row; threePositions[0..3])
    {
        countX += row.count('X');
        countO += row.count('O');
        empty += row.count(' ');
    }

    bool invalid = countO > countX || countX - countO > 1;
    return tuple(invalid, empty);
}

pure int lookForWinner(const string[] threePositions)
{
    int winX = 0;
    int winO = 0;

    foreach (col; threePositions)
    {
        if (col == "XXX")
            winX = 1;
        else if (col == "OOO")
            winO = 1;
    }

    return winX + winO;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Won games-Finished game where X won via left column victory
    {
        immutable string[] board = [
            "XOO",
            "X  ",
            "X  ",
        ];
        assert(gamestate(board) == State.win);
    }

    static if (allTestsEnabled)
    {
        // Won games-Finished game where X won via middle column victory
        {
            immutable string[] board = [
                "OXO",
                " X ",
                " X ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via right column victory
        {
            immutable string[] board = [
                "OOX",
                "  X",
                "  X",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via left column victory
        {
            immutable string[] board = [
                "OXX",
                "OX ",
                "O  ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via middle column victory
        {
            immutable string[] board = [
                "XOX",
                " OX",
                " O ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via right column victory
        {
            immutable string[] board = [
                "XXO",
                " XO",
                "  O",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via top row victory
        {
            immutable string[] board = [
                "XXX",
                "XOO",
                "O  ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via middle row victory
        {
            immutable string[] board = [
                "O  ",
                "XXX",
                " O ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via bottom row victory
        {
            immutable string[] board = [
                " OO",
                "O X",
                "XXX",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via top row victory
        {
            immutable string[] board = [
                "OOO",
                "XXO",
                "XX ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via middle row victory
        {
            immutable string[] board = [
                "XX ",
                "OOO",
                "X  ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via bottom row victory
        {
            immutable string[] board = [
                "XOX",
                " XX",
                "OOO",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via falling diagonal victory
        {
            immutable string[] board = [
                "XOO",
                " X ",
                "  X",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via rising diagonal victory
        {
            immutable string[] board = [
                "O X",
                "OX ",
                "X  ",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via falling diagonal victory
        {
            immutable string[] board = [
                "OXX",
                "OOX",
                "X O",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where O won via rising diagonal victory
        {
            immutable string[] board = [
                "  O",
                " OX",
                "OXX",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via a row and a column victory
        {
            immutable string[] board = [
                "XXX",
                "XOO",
                "XOO",
            ];
            assert(gamestate(board) == State.win);
        }

        // Won games-Finished game where X won via two diagonal victories
        {
            immutable string[] board = [
                "XOX",
                "OXO",
                "XOX",
            ];
            assert(gamestate(board) == State.win);
        }

        // Drawn games-Draw
        {
            immutable string[] board = [
                "XOX",
                "XXO",
                "OXO",
            ];
            assert(gamestate(board) == State.draw);
        }

        // Drawn games-Another draw
        {
            immutable string[] board = [
                "XXO",
                "OXX",
                "XOO",
            ];
            assert(gamestate(board) == State.draw);
        }

        // Ongoing games-Ongoing game: one move in
        {
            immutable string[] board = [
                "   ",
                "X  ",
                "   ",
            ];
            assert(gamestate(board) == State.ongoing);
        }

        // Ongoing games-Ongoing game: two moves in
        {
            immutable string[] board = [
                "O  ",
                " X ",
                "   ",
            ];
            assert(gamestate(board) == State.ongoing);
        }

        // Ongoing games-Ongoing game: five moves in
        {
            immutable string[] board = [
                "X  ",
                " XO",
                "OX ",
            ];
            assert(gamestate(board) == State.ongoing);
        }

        // Invalid boards-Invalid board: X went twice
        {
            immutable string[] board = [
                "XX ",
                "   ",
                "   ",
            ];
            assertThrown(gamestate(board));
        }

        // Invalid boards-Invalid board: O started
        {
            immutable string[] board = [
                "OOX",
                "   ",
                "   ",
            ];
            assertThrown(gamestate(board));
        }

        // Invalid boards-Invalid board: X won and O kept playing
        {
            immutable string[] board = [
                "XXX",
                "OOO",
                "   ",
            ];
            assertThrown(gamestate(board));
        }

        // Invalid boards-Invalid board: players kept playing after a win
        {
            immutable string[] board = [
                "XXX",
                "OOO",
                "XOX",
            ];
            assertThrown(gamestate(board));
        }
    }
}