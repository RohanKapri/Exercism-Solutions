module [roman]

roman : U64 -> Result Str _
roman = |number|
    if number == 0 || number > 3999 then
        Err "number must be in 1..3999"
    else
        Ok (toRoman number)

toRoman : U64 -> Str
toRoman = |n|
    when n is
        0 -> ""
        _ ->
            when List.find_first romanNumerals (\(value, _) -> n >= value) is
                Ok (value, numeral) ->
                    Str.concat numeral (toRoman (n - value))
                _ -> ""

romanNumerals : List (U64, Str)
romanNumerals = [
    (1000, "M"),
    (900, "CM"),
    (500, "D"),
    (400, "CD"),
    (100, "C"),
    (90, "XC"),
    (50, "L"),
    (40, "XL"),
    (10, "X"),
    (9, "IX"),
    (5, "V"),
    (4, "IV"),
    (1, "I")
]