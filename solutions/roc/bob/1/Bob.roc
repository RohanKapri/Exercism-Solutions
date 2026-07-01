module [response]

response : Str -> Str
response = |hey_bob|
    trimmed = Str.trim hey_bob

    if Str.is_empty trimmed then
        "Fine. Be that way!"
    else
        letters =
            trimmed
                |> Str.to_utf8
                |> List.keep_if \byte -> (byte >= 'A' && byte <= 'Z') || (byte >= 'a' && byte <= 'z')

        isYelling =
            Bool.not (List.is_empty letters)
            && List.all letters (\byte -> byte >= 'A' && byte <= 'Z')

        isQuestion = Str.ends_with trimmed "?"

        if isYelling && isQuestion then
            "Calm down, I know what I'm doing!"
        else if isYelling then
            "Whoa, chill out!"
        else if isQuestion then
            "Sure."
        else
            "Whatever."
                  