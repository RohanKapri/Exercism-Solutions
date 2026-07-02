module [spiral_matrix]

spiral_matrix : U64 -> List (List U64)

spiral_matrix = |size|
    if size == 0 then
        []
    else if size == 1 then
        [[1]]
    else
        initial_matrix = List.range { start: At 0, end: Before size }
            |> List.map(|_| List.repeat(0, size))
        build_matrix(size, 1, 0, 0, { dx: 1, dy: 0 }, initial_matrix)

build_matrix : U64, U64, U64, U64, { dx : I64, dy : I64 }, List (List U64) -> List (List U64)

build_matrix = |size, n, x, y, direction, matrix|
    if n > size * size then
        matrix
    else
        new_matrix = List.get(matrix, y)
            |> Result.with_default([])
            |> |row| List.set(row, x, n)
            |> |updated_row| List.set(matrix, y, updated_row)
        
        (new_x, new_y) = next_pos(x, y, direction)
        
        if should_turn(new_x, new_y, size, new_matrix) then
            new_dir = { dx: -direction.dy, dy: direction.dx }
            (nx, ny) = next_pos(x, y, new_dir)
            build_matrix(size, n + 1, nx, ny, new_dir, new_matrix)
        else
            build_matrix(size, n + 1, new_x, new_y, direction, new_matrix)

next_pos : U64, U64, { dx : I64, dy : I64 } -> (U64, U64)

next_pos = |x, y, { dx, dy }|
    x_i64 = Num.to_i64(x) + dx
    y_i64 = Num.to_i64(y) + dy
    (
        if x_i64 < 0 then 0 else Num.to_u64(x_i64),
        if y_i64 < 0 then 0 else Num.to_u64(y_i64)
    )

should_turn : U64, U64, U64, List (List U64) -> Bool

should_turn = |x, y, size, matrix|
    x >= size || y >= size ||
        List.get(matrix, y)
            |> Result.map_ok(|row| List.get(row, x) |> Result.map_ok(|v| v != 0) |> Result.with_default(Bool.true))
            |> Result.with_default(Bool.true)
                                                   