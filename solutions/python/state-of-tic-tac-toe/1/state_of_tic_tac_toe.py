"""Determine the state of a tic-tac-toe game."""


def gamestate(board):
    """Return the state of the game or raise ValueError for invalid boards."""
    x_count = sum(row.count("X") for row in board)
    o_count = sum(row.count("O") for row in board)

    if o_count > x_count:
        raise ValueError("Wrong turn order: O started")

    if x_count - o_count > 1:
        raise ValueError("Wrong turn order: X went twice")

    winning_lines = []

    for row_index in range(3):
        winning_lines.append([board[row_index][column_index] for column_index in range(3)])

    for column_index in range(3):
        winning_lines.append([board[row_index][column_index] for row_index in range(3)])

    winning_lines.append([board[index][index] for index in range(3)])
    winning_lines.append([board[index][2 - index] for index in range(3)])

    x_wins = any(line == ["X", "X", "X"] for line in winning_lines)
    o_wins = any(line == ["O", "O", "O"] for line in winning_lines)

    if x_wins and o_wins:
        raise ValueError(
            "Impossible board: game should have ended after the game was won"
        )

    if x_wins and x_count != o_count + 1:
        raise ValueError(
            "Impossible board: game should have ended after the game was won"
        )

    if o_wins and x_count != o_count:
        raise ValueError(
            "Impossible board: game should have ended after the game was won"
        )

    if x_wins or o_wins:
        return "win"

    if x_count + o_count == 9:
        return "draw"

    return "ongoing"