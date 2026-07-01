module [grains_on_square, total_grains]

# Custom power function for U64 to avoid overflow
pow2 : U64 -> U64
pow2 = |exponent|
    if exponent == 0 then
        1
    else if exponent == 1 then
        2
    else
        2 * pow2 (exponent - 1)

grains_on_square : U8 -> Result U64 _
grains_on_square = |square|
    if square < 1 || square > 64 then
        Err("Square must be between 1 and 64")
    else
        Ok(pow2 (Num.to_u64 (square - 1)))

total_grains : U64
total_grains =
    List.range { start: At 1, end: At 64 }
    |> List.map(\square -> pow2 (Num.to_u64 (square - 1)))
    |> List.sum
    