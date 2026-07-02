module [rebase]

rebase : { input_base : U64, output_base : U64, digits : List U64 } -> Result (List U64) Str
rebase = \{ input_base, output_base, digits } ->
    if input_base < 2 then
        Err "input base must be >= 2"
    else if output_base < 2 then
        Err "output base must be >= 2"
    else if List.is_empty digits then
        Ok [0]
    else if List.any digits (\d -> d >= input_base) then
        Err "all digits must satisfy 0 <= d < input base"
    else
        decimal = to_decimal input_base digits
        from_decimal output_base decimal

to_decimal : U64, List U64 -> U64
to_decimal = \base, digits ->
    List.walk digits 0 \acc, digit ->
        acc * base + digit

from_decimal : U64, U64 -> Result (List U64) Str
from_decimal = \base, number ->
    if number == 0 then
        Ok [0]
    else
        go = \n, acc ->
            if n == 0 then
                acc
            else
                go (n // base) (List.prepend acc (n % base))
        
        Ok (go number [])
         