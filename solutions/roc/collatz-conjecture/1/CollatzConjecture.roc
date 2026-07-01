module [steps]

steps : U64 -> Result U64 Str
steps = |number|
    if number < 1 then
        Err("Only positive integers are allowed")
    else
        Ok(countSteps(number, 0))

countSteps : U64, U64 -> U64
countSteps = \n, count ->
    if n == 1 then
        count
    else if n % 2 == 0 then
        countSteps(n // 2, count + 1)
    else
        countSteps(3 * n + 1, count + 1)
    