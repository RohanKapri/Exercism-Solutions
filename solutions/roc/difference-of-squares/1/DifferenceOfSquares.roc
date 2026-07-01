module [square_of_sum, sum_of_squares, difference_of_squares]

square_of_sum : U64 -> U64
square_of_sum = |number|
    sum = List.range { start: At 1, end: At number }
        |> List.sum
    sum * sum

sum_of_squares : U64 -> U64
sum_of_squares = |number|
    List.range { start: At 1, end: At number }
        |> List.map(|n| n * n)
        |> List.sum

difference_of_squares : U64 -> U64
difference_of_squares = |number|
    square_of_sum(number) - sum_of_squares(number)
    