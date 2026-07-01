module [triplets_with_sum]

Triplet : (U64, U64, U64)

triplets_with_sum : U64 -> Set Triplet
triplets_with_sum = \sum ->
    # My approach: For each a, directly calculate b using the constraints
    # Given: a + b + c = sum and a² + b² = c²
    # Solving: a² + b² = (sum - a - b)²
    # This simplifies to: b = (sum² - 2*sum*a) / (2*(sum - a))
    
    max_a = if sum < 3 then 0 else (sum - 1) // 3
    
    List.range { start: At 1, end: Before (max_a + 1) }
    |> List.join_map \a ->
        # Calculate b directly from the formula
        denominator = 2 * (sum - a)
        if denominator == 0 then
            []
        else
            numerator = sum * sum - 2 * sum * a
            # Check if b is an integer (numerator is divisible by denominator)
            if numerator % denominator != 0 then
                []
            else
                b = numerator // denominator
                c = sum - a - b
                # Verify the triplet is valid: a < b < c and Pythagorean theorem
                if a < b && b < c && (a * a) + (b * b) == (c * c) then
                    [(a, b, c)]
                else
                    []
    |> Set.from_list
                  