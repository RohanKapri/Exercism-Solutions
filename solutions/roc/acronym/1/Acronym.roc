module [abbreviate]

abbreviate : Str -> Str
abbreviate = |text|
    text
    |> Str.to_utf8
    |> List.walk({ result: [], prev_is_sep: Bool.true }, |state, byte|
        if byte == ' ' || byte == '-' then
            { state & prev_is_sep: Bool.true }
        else if (byte >= 'A' && byte <= 'Z') || (byte >= 'a' && byte <= 'z') then
            if state.prev_is_sep then
                upper_byte = if byte >= 'a' && byte <= 'z' then byte - 32 else byte
                { result: List.append(state.result, upper_byte), prev_is_sep: Bool.false }
            else
                { state & prev_is_sep: Bool.false }
        else
            state
    )
    |> .result
    |> Str.from_utf8
    |> Result.with_default("")
         