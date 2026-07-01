module [largest_product]

largest_product : Str, U64 -> Result U64 _
largest_product = |digits, span|
    if span == 0 then
        Ok(1)
    else if Str.is_empty(digits) then
        Err("span must be zero for empty string")
    else
        bytes = Str.to_utf8(digits)
        len = List.len(bytes)
        
        if span > len then
            Err("span must be smaller than string length")
        else
            bytes
                |> List.walk_try [] \acc, byte ->
                    if byte >= '0' && byte <= '9' then
                        Ok(List.append acc (Num.to_u64(byte - '0')))
                    else
                        Err("Invalid character in digits")
                |> Result.map_ok \nums ->
                    List.range { start: At 0, end: Before (len - span + 1) }
                        |> List.map \i ->
                            nums
                                |> List.drop_first i
                                |> List.take_first span
                                |> List.walk 1 \acc, n -> acc * n
                        |> List.max
                        |> Result.with_default 0
          