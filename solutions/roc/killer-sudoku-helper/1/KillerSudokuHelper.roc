module [combinations]

Combination : List U8

combinations : { sum : U8, size : U8, exclude ?? List U8 } -> List Combination
combinations = \{ sum, size, exclude ? [] } ->
    generate_combinations(sum, size, 1, exclude)
    |> List.sort_with(compare_combinations)

generate_combinations : U8, U8, U8, List U8 -> List Combination
generate_combinations = \sum, size, start, exclude ->
    if size == 0 && sum == 0 then
        [[]]
    else if size == 0 || sum == 0 || start > 9 then
        []
    else
        # Calculate the maximum digit we need to consider
        max_digit = Num.min(9, sum)
        
        generate_helper(sum, size, start, max_digit, exclude)

generate_helper : U8, U8, U8, U8, List U8 -> List Combination
generate_helper = \sum, size, start, max_digit, exclude ->
    if start > max_digit then
        []
    else if List.contains(exclude, start) then
        # Skip excluded digit and continue with next
        generate_helper(sum, size, start + 1, max_digit, exclude)
    else if start > sum then
        # Skip digits larger than remaining sum
        []
    else
        # Include current digit
        with_current = 
            generate_combinations(sum - start, size - 1, start + 1, exclude)
            |> List.map(\combo -> List.prepend(combo, start))
        
        # Skip current digit
        without_current = generate_helper(sum, size, start + 1, max_digit, exclude)
        
        List.concat(with_current, without_current)

compare_combinations : Combination, Combination -> [LT, EQ, GT]
compare_combinations = \a, b ->
    when (a, b) is
        ([], []) -> EQ
        ([], _) -> LT
        (_, []) -> GT
        ([a_head, .. as a_tail], [b_head, .. as b_tail]) ->
            if a_head < b_head then
                LT
            else if a_head > b_head then
                GT
            else
                compare_combinations(a_tail, b_tail)
     