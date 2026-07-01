module [encode, decode]

encode = \phrase ->
    runWith formatChunks phrase

decode = \phrase ->
    runWith Str.from_utf8 phrase

runWith = \fin, phrase ->
    phrase
    |> Str.to_utf8
    |> List.map toLower
    |> List.keep_if isAlphaNum
    |> List.map atbash
    |> fin

formatChunks = \chars ->
    chars
    |> List.chunks_of 5
    |> List.map_try Str.from_utf8
    |> Result.map_ok \chunks -> Str.join_with chunks " "

isAlphaNum : U8 -> Bool
isAlphaNum = \c ->
    isAlpha c || isDigit c

toLower : U8 -> U8
toLower = \c ->
    if c >= 'A' && c <= 'Z' then
        c + ('a' - 'A')
    else
        c

atbash : U8 -> U8
atbash = \char ->
    if char >= 'a' && char <= 'z' then
        'z' - (char - 'a')
    else
        char

isAlpha : U8 -> Bool
isAlpha = \c ->
    c >= 'a' && c <= 'z'

isDigit : U8 -> Bool
isDigit = \c ->
    c >= '0' && c <= '9'
    