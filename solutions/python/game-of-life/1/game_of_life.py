"""Conway's Game of Life."""


def tick(matrix):
    """Return the next generation of the given Game of Life board."""
    rows = len(matrix)
    cols = len(matrix[0]) if rows else 0

    def neighbors(r, c):
        count = 0
        for dr in (-1, 0, 1):
            for dc in (-1, 0, 1):
                if dr == 0 and dc == 0:
                    continue
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols:
                    count += matrix[nr][nc]
        return count

    return [
        [
            int(
                neighbors(r, c) == 3
                or (matrix[r][c] == 1 and neighbors(r, c) == 2)
            )
            for c in range(cols)
        ]
        for r in range(rows)
    ]