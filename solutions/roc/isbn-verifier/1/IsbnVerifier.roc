module [is_valid]

is_valid : Str -> Bool
is_valid = \isbn ->
    cleaned_isbn = Str.replace_each isbn "-" ""
    
    if Str.count_utf8_bytes cleaned_isbn != 10 then
        Bool.false
    else
        chars = Str.to_utf8 cleaned_isbn
        
        # Check that 'X' only appears at the last position (if at all)
        x_only_at_end = List.range { start: At 0, end: Before 9 }
            |> List.all \i ->
                when List.get chars i is
                    Ok c -> c != 'X'
                    Err _ -> Bool.false
        
        if Bool.not x_only_at_end then
            Bool.false
        else
            digits = 
                chars
                |> List.map_with_index \char, index -> 
                    if index == 9 && char == 'X' then
                        10
                    else if char >= '0' && char <= '9' then
                        Num.to_u64(char - '0')
                    else
                        11 # Invalid digit
            
            if List.any digits \d -> d > 10 then
                Bool.false
            else
                sum = 
                    digits
                    |> List.map_with_index \digit, index -> 
                        digit * (10 - index)
                    |> List.sum
                
                sum % 11 == 0
       