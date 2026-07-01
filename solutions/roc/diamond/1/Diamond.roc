module [diamond]

diamond : U8 -> Str
diamond = |letter|
    if letter == 'A' then
        "A"
    else
        letter_pos = Num.to_u64(letter - 'A')
        total_rows = 2 * letter_pos + 1
        rows = List.range { start: At 0, end: Before total_rows }
            |> List.map \row ->
                build_row row letter_pos
        Str.join_with rows "\n"

build_row : U64, U64 -> Str
build_row = |row, max_pos|
    diff = Num.abs (Num.to_i64(row) - Num.to_i64(max_pos))
    current_pos = max_pos - Num.to_u64(diff)
    leading_spaces = max_pos - current_pos
    
    leading = Str.repeat " " leading_spaces
    current_char = 'A' + Num.to_u8(current_pos)
    current_char_str = Str.from_utf8 [current_char] |> Result.with_default ""
    
    if current_pos == 0 then
        Str.concat leading (Str.concat current_char_str leading)
    else
        middle_spaces = 2 * current_pos - 1
        middle = Str.repeat " " middle_spaces
        Str.concat leading (
            Str.concat current_char_str (
                Str.concat middle (
                    Str.concat current_char_str leading
                )
            )
        )
               