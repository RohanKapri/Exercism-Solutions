"""Conway's Game of Life."""


def tick(matrix):
    """Return the next generation of the given Game of Life board."""
    row_count = len(matrix)
    column_count = len(matrix[0]) if row_count else 0

    def count_neighbors(row_index, column_index):
        live_neighbors = 0

        for row_offset in (-1, 0, 1):
            for column_offset in (-1, 0, 1):
                if row_offset == 0 and column_offset == 0:
                    continue

                neighbor_row = row_index + row_offset
                neighbor_column = column_index + column_offset

                if (
                    0 <= neighbor_row < row_count
                    and 0 <= neighbor_column < column_count
                ):
                    live_neighbors += matrix[neighbor_row][neighbor_column]

        return live_neighbors

    next_generation = []

    for row_index in range(row_count):
        next_row = []

        for column_index in range(column_count):
            neighbor_count = count_neighbors(row_index, column_index)

            if matrix[row_index][column_index] == 1:
                next_row.append(
                    1 if neighbor_count in (2, 3) else 0
                )
            else:
                next_row.append(
                    1 if neighbor_count == 3 else 0
                )

        next_generation.append(next_row)

    return next_generation