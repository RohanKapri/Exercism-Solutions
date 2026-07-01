module [distance]

LengthMismatch : [LengthMismatch]

distance : Str, Str -> Result U64 [LengthMismatch]
distance = \strand1, strand2 ->
    len1 = Str.count_utf8_bytes strand1
    len2 = Str.count_utf8_bytes strand2
    
    when len1 is
        l1 if l1 != len2 ->
            Err LengthMismatch
        _ ->
            List.map2 (Str.to_utf8 strand1) (Str.to_utf8 strand2) \a, b -> a != b
            |> List.count_if \diff -> diff
            |> Ok
                    