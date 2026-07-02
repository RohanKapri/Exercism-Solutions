module [reverse]

import unicode.Grapheme

reverse : Str -> Str
reverse = |string|
    string
    |> Grapheme.split
    |> Result.with_default []
    |> reverseList
    |> Str.join_with ""

reverseList : List a -> List a
reverseList = \list ->
    reverseHelper list []

reverseHelper : List a, List a -> List a
reverseHelper = \list, acc ->
    when list is
        [] -> acc
        [first, .. as rest] -> reverseHelper rest (List.prepend acc first)