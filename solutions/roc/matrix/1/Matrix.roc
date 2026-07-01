module [row, column]

parseMatrix : Str -> Result (List (List I64)) Str
parseMatrix = \matrix_str ->
    matrix_str
    |> Str.split_on "\n"
    |> List.map Str.trim
    |> List.keep_if (\line -> !(Str.is_empty line))
    |> List.map_try \line ->
        line
        |> Str.split_on " "
        |> List.keep_if (\s -> !(Str.is_empty s))
        |> List.map_try Str.to_i64
    |> Result.map_err \_ -> "Invalid matrix"

row : Str, U64 -> Result (List I64) Str
row = \matrix_str, index ->
    parseMatrix matrix_str
    |> Result.try \rows ->
        if index == 0 then
            Err "Invalid row index"
        else
            List.get rows (index - 1)
            |> Result.map_err \_ -> "Invalid row index"

column : Str, U64 -> Result (List I64) Str
column = \matrix_str, index ->
    parseMatrix matrix_str
    |> Result.try \rows ->
        if index == 0 then
            Err "Invalid column index"
        else
            rows
            |> List.map_try \r -> List.get r (index - 1)
            |> Result.map_err \_ -> "Invalid column index"
       