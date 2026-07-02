module [count_words]

count_words : Str -> Dict Str U64
count_words = |sentence|
    sentence
    |> Str.to_utf8
    |> List.map(|b| if b >= 'A' && b <= 'Z' then b + 32 else b)
    |> List.walk({ words: Dict.empty({}), cur: [] }, |state, byte|
        if is_word_char(byte) then
            { state & cur: List.append(state.cur, byte) }
        else
            add_word(state)
    )
    |> add_word
    |> .words

add_word = |state|
    word = state.cur |> trim_quotes |> Str.from_utf8 |> Result.with_default("")
    if Str.is_empty(word) then
        { state & cur: [] }
    else
        { words: Dict.update(state.words, word, |c| Ok((Result.with_default(c, 0)) + 1)), cur: [] }

is_word_char = |b| (b >= 'a' && b <= 'z') || (b >= '0' && b <= '9') || b == '\''

trim_quotes = |bytes|
    when bytes is
        ['\''  , .. as mid, '\''] -> trim_quotes(mid)
        ['\'', .. as rest] -> trim_quotes(rest)
        [.. as init, '\''] -> trim_quotes(init)
        _ -> bytes
       