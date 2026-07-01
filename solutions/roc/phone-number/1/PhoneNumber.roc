module [clean]

clean : Str -> Result Str Str

clean = \phoneNumber ->
    phoneNumber
        |> Str.to_utf8
        |> List.keep_if isValidDigit
        |> normalizeLength
        |> Result.try validateTenDigits

normalizeLength : List U8 -> Result (List U8) Str
normalizeLength = \digits ->
    len = List.len digits
    if len == 10 then Ok digits
    else if len == 11 then
        when List.get digits 0 is
            Ok '1' -> Ok (List.drop_first digits 1)
            _ -> Err "Invalid: 11 digits not starting with 1"
    else if len == 9 then Err "Invalid: 9 digits"
    else if len > 11 then Err "Invalid: more than 11 digits"
    else Err "Invalid: less than 10 digits"

validateTenDigits : List U8 -> Result Str Str
validateTenDigits = \digits ->
    when (List.get digits 0, List.get digits 3) is
        (Ok area, Ok exchange) ->
            if area >= '2' && area <= '9' && exchange >= '2' && exchange <= '9' then
                digits |> Str.from_utf8 |> Result.map_err \_ -> "Invalid format"
            else
                Err "Invalid: area or exchange code must start with 2-9"
        _ -> Err "Invalid format"

isValidDigit : U8 -> Bool
isValidDigit = \d -> d >= '0' && d <= '9'