module [translate]

is_vowel : U8 -> Bool
is_vowel = |c|
    c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'

## Returns how many leading bytes form the consonant cluster to move.
## Uses walk_until so each byte is visited exactly once with no extra get().
find_prefix_len : List U8 -> U64
find_prefix_len = |bytes|
    result = List.walk_until(
        bytes,
        { idx: 0, done: Bool.false },
        |state, c|
            if state.done then
                Break(state)
            else if is_vowel(c) then
                Break({ state & done: Bool.true })
            else if c == 'y' && state.idx > 0 then
                # Rule 4: y after consonants acts as a vowel
                Break({ state & done: Bool.true })
            else if c == 'q' then
                # Rule 3: peek at next byte via the index we track
                next = List.get(bytes, state.idx + 1) |> Result.with_default(0)
                if next == 'u' then
                    Break({ idx: state.idx + 2, done: Bool.true })
                else
                    Continue({ state & idx: state.idx + 1 })
            else
                Continue({ state & idx: state.idx + 1 }),
    )
    result.idx

## Translate a single word given as a UTF-8 byte slice [from, to).
## Writes result bytes into `out` and returns the updated list.
translate_word_bytes : List U8, List U8, U64, U64 -> List U8
translate_word_bytes = |word_bytes, out, _from, _to|
    n = List.len(word_bytes)
    if n == 0 then
        out
    else
        c0 = List.get(word_bytes, 0) |> Result.with_default(0)
        c1 = List.get(word_bytes, 1) |> Result.with_default(0)

        rule1 =
            is_vowel(c0)
            || (c0 == 'x' && c1 == 'r')
            || (c0 == 'y' && c1 == 't')

        if rule1 then
            # Append word + "ay"
            out
            |> List.concat(word_bytes)
            |> List.append('a')
            |> List.append('y')
        else
            prefix_len = find_prefix_len(word_bytes)
            rest   = List.drop_first(word_bytes, prefix_len)
            prefix = List.take_first(word_bytes, prefix_len)
            out
            |> List.concat(rest)
            |> List.concat(prefix)
            |> List.append('a')
            |> List.append('y')

## Split phrase bytes on spaces, translate each word, rejoin – all in bytes.
translate_phrase_bytes : List U8 -> List U8
translate_phrase_bytes = |bytes|
    n = List.len(bytes)
    init = { out: List.with_capacity(n + 10), word_start: 0, idx: 0 }
    final = List.walk(
        bytes,
        init,
        |s, c|
            if c == ' ' then
                wlen = s.idx - s.word_start
                w = List.sublist(bytes, { start: s.word_start, len: wlen })
                new_out = translate_word_bytes(w, s.out, 0, 0)
                { out: List.append(new_out, ' '), word_start: s.idx + 1, idx: s.idx + 1 }
            else
                { s & idx: s.idx + 1 },
    )
    # Handle last word (no trailing space)
    last_word = List.sublist(bytes, { start: final.word_start, len: n - final.word_start })
    translate_word_bytes(last_word, final.out, 0, 0)

translate : Str -> Str
translate = |phrase|
    Str.to_utf8(phrase)
    |> translate_phrase_bytes
    |> Str.from_utf8_lossy
        