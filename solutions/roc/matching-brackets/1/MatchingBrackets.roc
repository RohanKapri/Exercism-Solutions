module [is_paired]

is_paired : Str -> Bool
is_paired = |string|
    check_brackets(string, [])

check_brackets : Str, List Str -> Bool
check_brackets = |string, stack|
    when Str.to_utf8(string) is
        [] -> List.is_empty(stack)
        [first, .. as rest] ->
            remaining = Str.from_utf8(rest) |> Result.with_default("")
            when first is
                40 -> check_brackets(remaining, List.append(stack, "(")) # '('
                91 -> check_brackets(remaining, List.append(stack, "[")) # '['
                123 -> check_brackets(remaining, List.append(stack, "{")) # '{'
                41 -> # ')'
                    when List.last(stack) is
                        Ok("(") -> check_brackets(remaining, List.drop_last(stack, 1))
                        _ -> Bool.false
                93 -> # ']'
                    when List.last(stack) is
                        Ok("[") -> check_brackets(remaining, List.drop_last(stack, 1))
                        _ -> Bool.false
                125 -> # '}'
                    when List.last(stack) is
                        Ok("{") -> check_brackets(remaining, List.drop_last(stack, 1))
                        _ -> Bool.false
                _ -> check_brackets(remaining, stack)
                                                             