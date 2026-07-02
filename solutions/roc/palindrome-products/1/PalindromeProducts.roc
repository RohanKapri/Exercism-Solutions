module [smallest, largest]

# Error types
Error : [InvalidRange]

# Result type for palindrome search
PalindromeResult : { value : U64, factors : Set (U64, U64) }

# Comparison strategy for finding extreme values
ComparisonFn : U64, U64 -> Bool

# Core palindrome detection
is_palindrome : U64 -> Bool
is_palindrome = \number ->
    digits = number |> Num.to_str |> Str.to_utf8
    digits == List.reverse digits

# Result construction helpers
empty_result : PalindromeResult
empty_result = { value: 0, factors: Set.empty {} }

add_factor_pair : PalindromeResult, U64, U64 -> PalindromeResult
add_factor_pair = \{ value, factors }, n, m ->
    { value, factors: factors |> Set.insert (n, m) }

create_new_result : U64, U64, U64 -> PalindromeResult
create_new_result = \product, n, m ->
    { value: product, factors: Set.single (n, m) }

# Search state predicates
is_search_complete : U64, U64 -> Bool
is_search_complete = \n, max -> n > max

is_row_complete : U64, U64 -> Bool
is_row_complete = \m, max -> m > max

is_duplicate_product : U64, U64, U64 -> Bool
is_duplicate_product = \current_value, n, m -> current_value == n * m

should_update_result : ComparisonFn, U64, U64, U64 -> Bool
should_update_result = \comp, current_value, n, m ->
    product = n * m
    (current_value == 0 || comp product current_value) && is_palindrome product

# Core search algorithm - tail recursive for efficiency
search_palindromes : ComparisonFn, U64, U64, U64, U64, PalindromeResult -> PalindromeResult
search_palindromes = \comp, min, max, n, m, result ->
    when result is
        _ if is_search_complete n max ->
            result
        
        _ if is_row_complete m max ->
            search_palindromes comp min max (n + 1) (n + 1) result
        
        { value, factors } if is_duplicate_product value n m ->
            updated_result = add_factor_pair { value, factors } n m
            search_palindromes comp min max n (m + 1) updated_result
        
        { value } if should_update_result comp value n m ->
            new_result = create_new_result (n * m) n m
            search_palindromes comp min max n (m + 1) new_result
        
        _ ->
            search_palindromes comp min max n (m + 1) result

# Input validation
validate_input : U64, U64 -> Result {} Error
validate_input = \min, max ->
    if min > max then
        Err InvalidRange
    else
        Ok {}

# Main search orchestration
find_palindrome : ComparisonFn, U64, U64 -> PalindromeResult
find_palindrome = \comp, min, max ->
    search_palindromes comp min max min min empty_result

# Public API with enhanced error handling and documentation
## Find the smallest palindrome that is the product of two factors in the given range
smallest : { min : U64, max : U64 } -> Result PalindromeResult Error
smallest = \{ min, max } ->
    when validate_input min max is
        Ok {} -> find_palindrome Num.is_lt min max |> Ok
        Err error -> Err error

## Find the largest palindrome that is the product of two factors in the given range  
largest : { min : U64, max : U64 } -> Result PalindromeResult Error
largest = \{ min, max } ->
    when validate_input min max is
        Ok {} -> find_palindrome Num.is_gt min max |> Ok
        Err error -> Err error
        