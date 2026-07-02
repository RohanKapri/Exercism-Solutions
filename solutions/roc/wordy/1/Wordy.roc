module [answer]

State : [
    Start,
    What,
    Is,
    Number I64,
    Add I64,
    Sub I64,
    Mul I64,
    Div I64,
    Multiplied I64,
    Divided I64,
]

answer : Str -> Result I64 Str
answer = |question|
    if !(Str.ends_with question "?") then
        Err "Invalid question format"
    else
        question
        |> Str.drop_suffix "?"
        |> Str.split_on " "
        |> List.walk_try Start process_word
        |> Result.try |state|
            when state is
                Number n -> Ok n
                _ -> Err "Invalid final state"
        |> Result.map_err \_ -> "Invalid question format"

process_word : State, Str -> Result State Str
process_word = |state, word|
    when (state, word) is
        (Start, "What") -> Ok What
        (What, "is") -> Ok Is
        (Is, number) ->
            when Str.to_i64 number is
                Ok n -> Ok (Number n)
                Err _ -> Err "Invalid number"

        (Add left, number) ->
            when Str.to_i64 number is
                Ok right -> Ok (Number (left + right))
                Err _ -> Err "Invalid number"

        (Sub left, number) ->
            when Str.to_i64 number is
                Ok right -> Ok (Number (left - right))
                Err _ -> Err "Invalid number"

        (Mul left, number) ->
            when Str.to_i64 number is
                Ok right -> Ok (Number (left * right))
                Err _ -> Err "Invalid number"

        (Div left, number) ->
            when Str.to_i64 number is
                Ok right -> Ok (Number (left // right))
                Err _ -> Err "Invalid number"

        (Number n, operator) ->
            when operator is
                "plus"       -> Ok (Add n)
                "minus"      -> Ok (Sub n)
                "multiplied" -> Ok (Multiplied n)
                "divided"    -> Ok (Divided n)
                _            -> Err "Invalid operator"

        (Multiplied n, "by") -> Ok (Mul n)
        (Divided n, "by")    -> Ok (Div n)
        _ -> Err "Invalid syntax"
           