module [commands]

commands : U64 -> List Str
commands = \number ->
    actions = [
        (1, "wink"),
        (2, "double blink"),
        (4, "close your eyes"),
        (8, "jump"),
    ]
    
    result =
        List.walk_with_index actions [] \acc, (mask, action), _ ->
            if Num.bitwise_and number mask != 0 then
                List.append acc action
            else
                acc
    
    if Num.bitwise_and number 16 != 0 then
        List.reverse result
    else
        result
                 