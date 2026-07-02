module [transpose]

get_char_at : Str, U64 -> Str
get_char_at = |str, index|
    Str.to_utf8(str)
    |> List.get(index)
    |> Result.map_ok(|byte| Str.from_utf8([byte]) |> Result.with_default(" "))
    |> Result.with_default(" ")

transpose : Str -> Str
transpose = |input_str|
    lines = Str.split_on(input_str, "\n")
    max_length = List.walk(lines, 0, |acc, line| Num.max(acc, Str.count_utf8_bytes(line)))
    
    List.range({ start: At(0), end: Before(max_length) })
    |> List.map(|col| transpose_column(lines, col))
    |> Str.join_with("\n")
    |> Str.trim_end

# Function to handle column transposition
transpose_column : List Str, U64 -> Str
transpose_column = |lines, col|
    lines
    |> List.walk_with_index("", |acc, line, row_index|
        char = get_char_at(line, col)
        if char == " " && col >= Str.count_utf8_bytes(line) then
            if should_keep_space(lines, row_index, col) then
                Str.concat(acc, " ")
            else
                acc
        else
            Str.concat(acc, char)
    )

# Helper function to determine if a space should be kept
should_keep_space : List Str, U64, U64 -> Bool
should_keep_space = |lines, current_row, col|
    List.walk_with_index(lines, Bool.false, |should_keep, line, row_index|
        if row_index > current_row && col < Str.count_utf8_bytes(line) then
            Bool.true
        else
            should_keep
    )
          