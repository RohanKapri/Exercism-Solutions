module [is_pangram]

is_pangram : Str -> Bool
is_pangram = |sentence|
    sentence
        |> Str.to_utf8
        |> List.walk (Set.empty {}) |acc, char|
            when char is
                c if c >= 'a' && c <= 'z' -> Set.insert acc c
                c if c >= 'A' && c <= 'Z' -> Set.insert acc (c + 32)
                _ -> acc
        |> Set.len
        |> |uniqueLetters| uniqueLetters == 26
                                                  