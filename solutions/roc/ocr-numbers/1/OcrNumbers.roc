module [convert]

Digit : List (List U8)

# Main conversion function
convert : Str -> Result Str [IncorrectlySized Digit]
convert = |input|
    input
    |> split_into_groups
    |> List.map_try(process_group)
    |> Result.map_ok(|results| Str.join_with(results, ","))

# Split input into groups of 4 lines
split_into_groups : Str -> List (List Str)
split_into_groups = |input|
    input
    |> Str.split_on("\n")
    |> List.chunks_of(4)

# Process a single group of 4 lines
process_group : List Str -> Result Str [IncorrectlySized Digit]
process_group = |lines|
    digits =
        lines
        |> convert_to_digit_matrix
        |> extract_digits
        |> List.map_try(read_digit)

    when digits is
        Ok(chars) -> 
            chars
            |> List.map(|c| [c])
            |> List.map(Str.from_utf8)
            |> List.keep_oks(|x| x)
            |> Str.join_with("")
            |> Ok
        Err(err) -> Err(err)

# Convert group of lines into a matrix of UTF8 characters
convert_to_digit_matrix : List Str -> List (List (List U8))
convert_to_digit_matrix = |lines|
    List.map(lines, |line|
        line
        |> Str.to_utf8
        |> List.chunks_of(3)
    )

# Extract individual digits from the matrix
extract_digits : List (List (List U8)) -> List Digit
extract_digits = |matrix|
    when matrix is
        [] -> []
        [first, .. as rest] ->
            List.map_with_index(first, |chunk, idx|
                List.keep_oks(rest, |row| List.get(row, idx))
                |> List.prepend(chunk)
            )

# Read a single digit pattern
read_digit : Digit -> Result U8 [IncorrectlySized Digit]
read_digit = |chunk|
    when chunk is
        [[' ', '_', ' '], ['|', ' ', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> Ok('0')
        [[' ', ' ', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> Ok('1')
        [[' ', '_', ' '], [' ', '_', '|'], ['|', '_', ' '], [' ', ' ', ' ']] -> Ok('2')
        [[' ', '_', ' '], [' ', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> Ok('3')
        [[' ', ' ', ' '], ['|', '_', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> Ok('4')
        [[' ', '_', ' '], ['|', '_', ' '], [' ', '_', '|'], [' ', ' ', ' ']] -> Ok('5')
        [[' ', '_', ' '], ['|', '_', ' '], ['|', '_', '|'], [' ', ' ', ' ']] -> Ok('6')
        [[' ', '_', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] -> Ok('7')
        [[' ', '_', ' '], ['|', '_', '|'], ['|', '_', '|'], [' ', ' ', ' ']] -> Ok('8')
        [[' ', '_', ' '], ['|', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] -> Ok('9')
        [[_, _, _], [_, _, _], [_, _, _], [_, _, _]] -> Ok('?')
        _ -> Err(IncorrectlySized(chunk))
                                              