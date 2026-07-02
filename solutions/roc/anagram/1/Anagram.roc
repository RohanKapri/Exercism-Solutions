module [find_anagrams]

import unicode.Grapheme

find_anagrams : Str, List Str -> List Str
find_anagrams = \subject, candidates ->
    normalized_subject = normalize_and_sort(subject)
    candidates
    |> List.keep_if(\candidate ->
        normalized_candidate = normalize_and_sort(candidate)
        normalized_candidate.lower != normalized_subject.lower &&
        normalized_candidate.sorted == normalized_subject.sorted
    )

normalize_and_sort : Str -> { lower : List Str, sorted : List Str }
normalize_and_sort = \str ->
    lowered = Grapheme.split(str) |> Result.map_ok(\graphemes -> List.map(graphemes, ascii_to_lower)) |> Result.with_default([])
    {
        lower: lowered,
        sorted: List.sort_with(lowered, compare_utf8),
    }

compare_utf8 : Str, Str -> [LT, GT, EQ]
compare_utf8 = \s1, s2 -> compare_bytes(Str.to_utf8(s1), Str.to_utf8(s2))

compare_bytes : List U8, List U8 -> [LT, GT, EQ]
compare_bytes = \l1, l2 ->
    when (l1, l2) is
        ([], []) -> EQ
        ([], _) -> LT
        (_, []) -> GT
        ([b1, .. as rest1], [b2, .. as rest2]) ->
            if b1 < b2 then
                LT
            else if b1 > b2 then
                GT
            else
                compare_bytes(rest1, rest2)

ascii_to_lower : Str -> Str
ascii_to_lower = \grapheme ->
    code = Str.to_utf8(grapheme) |> List.first |> Result.with_default(0)
    if code >= 65 && code <= 90 then
        Str.from_utf8([code + 32]) |> Result.with_default(grapheme)
    else
        grapheme