module [encode, decode]

PrevChar : [NoPrev, Prev U8]

encode : Str -> Result Str _
encode = \string ->
    string
    |> Str.walk_utf8 { run: 1, prev: NoPrev, encoded: [] } encode_step
    |> finalize_encoding
    |> Str.from_utf8

encode_step : { run : U64, prev : PrevChar, encoded : List U8 }, U8 -> { run : U64, prev : PrevChar, encoded : List U8 }
encode_step = \state, c ->
    when state.prev is
        NoPrev ->
            { state & prev: Prev c }

        Prev p if p == c ->
            { state & run: state.run + 1 }

        Prev p ->
            {
                encoded: append_chunk state.encoded state.run p,
                run: 1,
                prev: Prev c,
            }

finalize_encoding : { run : U64, prev : PrevChar, encoded : List U8 } -> List U8
finalize_encoding = \{ encoded, run, prev } ->
    when prev is
        Prev p -> append_chunk encoded run p
        NoPrev -> []

append_chunk : List U8, U64, U8 -> List U8
append_chunk = \encoded, run, prev ->
    if run == 1 then
        List.append encoded prev
    else
        encoded
        |> append_number run
        |> List.append prev

append_number : List U8, U64 -> List U8
append_number = \list, num ->
    if num < 10 then
        List.append list (Num.to_u8 (num + 48))
    else
        digits = build_digits num []
        List.concat list digits

build_digits : U64, List U8 -> List U8
build_digits = \num, acc ->
    if num == 0 then
        acc
    else
        digit = Num.to_u8 (Num.rem num 10 + 48)
        build_digits (Num.div_trunc num 10) (List.prepend acc digit)

decode : Str -> Result Str _
decode = \string ->
    string
    |> Str.walk_utf8 { count: 0, decoded: [] } decode_step
    |> .decoded
    |> Str.from_utf8

decode_step : { count : U64, decoded : List U8 }, U8 -> { count : U64, decoded : List U8 }
decode_step = \state, c ->
    if is_digit c then
        digit = Num.to_u64 (c - '0')
        { state & count: state.count * 10 + digit }
    else
        repetitions = if state.count == 0 then 1 else state.count
        new_decoded = append_repeated state.decoded c repetitions
        { count: 0, decoded: new_decoded }

append_repeated : List U8, U8, U64 -> List U8
append_repeated = \list, char, count ->
    List.reserve list count
    |> append_repeated_helper char count

append_repeated_helper : List U8, U8, U64 -> List U8
append_repeated_helper = \list, char, remaining ->
    if remaining == 0 then
        list
    else
        append_repeated_helper (List.append list char) char (remaining - 1)

is_digit : U8 -> Bool
is_digit = \d -> d >= '0' && d <= '9'
        