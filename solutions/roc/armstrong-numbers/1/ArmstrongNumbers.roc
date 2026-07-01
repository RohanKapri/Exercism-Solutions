module [is_armstrong_number]

is_armstrong_number : U64 -> Bool
is_armstrong_number = |number|
    digits =
        number
            |> Num.to_str
            |> Str.to_utf8
            |> List.map(|byte| Num.to_u64(byte) - 48)

    power = List.len(digits)

    digits
        |> List.map(|digit| pow(digit, power))
        |> List.sum
        == number

pow : U64, U64 -> U64
pow = |base, exponent|
    if exponent == 0 then
        1
    else
        base * pow(base, exponent - 1)
             