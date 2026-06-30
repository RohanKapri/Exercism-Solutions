module game_of_life;

pure int[][] tick(immutable int[][] matrix)
{
    if (matrix.length == 0)
        return [];

    const rows = matrix.length;
    const cols = matrix[0].length;

    int[][] result;
    result.length = rows;
    foreach (ref row; result)
        row.length = cols;

    foreach (r; 0 .. rows)
    {
        foreach (c; 0 .. cols)
        {
            int neighbors = 0;

            foreach (dr; -1 .. 2)
            {
                foreach (dc; -1 .. 2)
                {
                    if (dr == 0 && dc == 0)
                        continue;

                    int nr = cast(int)r + dr;
                    int nc = cast(int)c + dc;

                    if (0 <= nr && nr < rows &&
                        0 <= nc && nc < cols)
                    {
                        neighbors += matrix[nr][nc];
                    }
                }
            }

            if (matrix[r][c] == 1)
            {
                result[r][c] = (neighbors == 2 || neighbors == 3) ? 1 : 0;
            }
            else
            {
                result[r][c] = (neighbors == 3) ? 1 : 0;
            }
        }
    }

    return result;
}