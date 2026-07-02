module [classify]

classify : U64 -> Result [Abundant, Deficient, Perfect] [InvalidInput]
classify = |number|
    if number == 0 then
        Err(InvalidInput)
    else
        aliquot_sum = calculate_aliquot_sum(number)
        if aliquot_sum == number then
            Ok(Perfect)
        else if aliquot_sum > number then
            Ok(Abundant)
        else
            Ok(Deficient)

calculate_aliquot_sum : U64 -> U64
calculate_aliquot_sum = |number|
    if number <= 1 then
        0
    else
        # Use integer square root to avoid floating-point overhead
        max_divisor = isqrt(number)
        # Recursive helper to accumulate sum, starting with 1 (always a factor)
        sum_divisors(number, 2, max_divisor, 1)

# Integer square root using bit-by-bit algorithm
isqrt : U64 -> U64
isqrt = |n|
    if n < 2 then
        n
    else
        # Find highest bit position (log2)
        shift = find_start_shift(n, 62)
        isqrt_bits(n, 0, shift)

# Find starting shift (highest even bit position <= log2(n))
find_start_shift : U64, U8 -> U8
find_start_shift = |n, shift|
    if shift == 0 then
        0
    else if Num.shift_left_by(1u64, shift) <= n then
        shift
    else
        find_start_shift(n, shift - 2)

# Build result bit by bit from most significant to least
isqrt_bits : U64, U64, U8 -> U64
isqrt_bits = |n, result, shift|
    if shift == 0 then
        # Final iteration for shift = 0
        candidate = result + 1
        if candidate * candidate <= n then
            candidate
        else
            result
    else
        candidate = result + Num.shift_left_by(1u64, shift // 2)
        square = candidate * candidate
        new_result =
            if square <= n then
                candidate
            else
                result
        isqrt_bits(n, new_result, shift - 2)

# Tail-recursive sum of divisors
sum_divisors : U64, U64, U64, U64 -> U64
sum_divisors = |number, divisor, max_divisor, sum|
    if divisor > max_divisor then
        sum
    else if number % divisor == 0 then
        other_divisor = number // divisor
        new_sum =
            if divisor == other_divisor then
                sum + divisor
            else if other_divisor == number then
                sum + divisor
            else
                sum + divisor + other_divisor
        sum_divisors(number, divisor + 1, max_divisor, new_sum)
    else
        sum_divisors(number, divisor + 1, max_divisor, sum)