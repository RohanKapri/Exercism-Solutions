module [ciphertext]

ciphertext : Str -> Result Str _
ciphertext = |text|
    chars =
        text
        |> Str.to_utf8
        |> List.map(toLower)
        |> List.keep_if(isAlphaNum)

    len = List.len(chars)

    when len is
        0 ->
            Ok("")

        _ ->
            (rows, cols) = rectangle(len)

            chars
            |> pad(rows * cols)
            |> chunkAndTranspose(cols)
            |> List.map_try(Str.from_utf8)
            |> Result.map_ok(|chunks| Str.join_with(chunks, " "))

pad : List U8, U64 -> List U8
pad = |chars, size|
    missing = size - List.len(chars)

    if missing == 0 then
        chars
    else
        List.concat(chars, List.repeat(' ', missing))

rectangle : U64 -> (U64, U64)
rectangle = |len|
    cols =
        len
        |> Num.to_f64
        |> Num.sqrt
        |> Num.ceiling
        |> Num.to_u64

    rows =
        Num.ceiling(Num.to_frac(len) / Num.to_frac(cols))
        |> Num.to_u64

    (rows, cols)

chunkAndTranspose : List U8, U64 -> List (List U8)
chunkAndTranspose = |chars, cols|
    chars
    |> List.chunks_of(cols)
    |> \rows ->
        List.range { start: At 0, end: Before cols }
        |> List.map(|colIdx|
            rows
            |> List.map(|row| List.get(row, colIdx) |> Result.with_default(' '))
        )

isAlphaNum : U8 -> Bool
isAlphaNum = |char|
    (char >= 'a' && char <= 'z')
        || (char >= 'A' && char <= 'Z')
        || (char >= '0' && char <= '9')

toLower : U8 -> U8
toLower = |char|
    if char >= 'A' && char <= 'Z' then
        char + ('a' - 'A')
    else
        char
    