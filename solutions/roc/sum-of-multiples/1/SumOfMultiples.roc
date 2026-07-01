module [sum_of_multiples]

sum_of_multiples : List U64, U64 -> U64
sum_of_multiples = \factors, limit ->
    valid_factors = List.keep_if factors \factor ->
        factor != 0
    
    if List.is_empty valid_factors then
        0
    else
        List.range { start: At 1, end: Before limit }
            |> List.keep_if \n -> List.any valid_factors \factor ->
                n % factor == 0
            |> List.sum