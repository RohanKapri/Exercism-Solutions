module [create, rank, file, queen_can_attack]

Square := { row : U8, column : U8 }

rank = |@Square({ row })| row + 1

file = |@Square({ column })| 'A' + column

create = |square_str|
    chars = Str.to_utf8 square_str
    when (List.len(chars), List.get(chars, 0), List.get(chars, 1)) is
        (2, Ok(file_char), Ok(rank_char)) ->
            if (file_char >= 'A' && file_char <= 'H') && (rank_char >= '1' && rank_char <= '8') then
                Ok(@Square { row: rank_char - '1', column: file_char - 'A' })
            else
                Err("Invalid square")
        _ -> Err("Invalid square format")

queen_can_attack = |@Square({ row: row1, column: col1 }), @Square({ row: row2, column: col2 })|
    row1 == row2 || col1 == col2 || 
    (if row1 >= row2 then row1 - row2 else row2 - row1) == (if col1 >= col2 then col1 - col2 else col2 - col1)