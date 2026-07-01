module [pascals_triangle]

pascals_triangle : U64 -> List (List U64)
pascals_triangle = |count|
    if count == 0 then
        []
    else
        build_rows count [1] [[1]]

build_rows : U64, List U64, List (List U64) -> List (List U64)
build_rows = |remaining, previous_row, acc|
    if remaining == 1 then
        List.reverse acc
    else
        next_row = build_next_row previous_row
        build_rows (remaining - 1) next_row (List.prepend acc next_row)

build_next_row : List U64 -> List U64
build_next_row = |previous_row|
    # The next row has one more element than the previous row
    # First element is always 1
    # Middle elements are sum of adjacent elements from previous row
    # Last element is always 1
    when previous_row is
        [] -> [1]
        [_] -> [1, 1]
        [_, ..] ->
            # Build middle elements by summing adjacent pairs
            middle = build_middle previous_row []
            # Prepend 1, append 1
            List.prepend (List.append middle 1) 1

build_middle : List U64, List U64 -> List U64
build_middle = |row, acc|
    when row is
        [] -> acc
        [_] -> acc
        [first, second, .. as rest] ->
            sum = first + second
            build_middle (List.prepend rest second) (List.append acc sum)
        