module [is_isogram]

is_isogram : Str -> Bool
is_isogram = |phrase|
    chars = phrase
        |> Str.to_utf8
        |> List.walk [] processChar
    unique_chars = Set.from_list chars
    List.len(chars) == Set.len(unique_chars)

# Helper function to process each character: convert to lowercase if alphabetic, ignore otherwise
processChar : List U8, U8 -> List U8
processChar = |acc, c|
    if (c >= 'A' && c <= 'Z') then
        List.append acc (c + 32)  # Convert uppercase to lowercase
    else if (c >= 'a' && c <= 'z') then
        List.append acc c  # Already lowercase
    else
        acc  # Ignore non-alphabetic characters
              