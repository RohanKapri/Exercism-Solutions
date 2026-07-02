module [square_root]

square_root : U64 -> U64
square_root = |radicand|
    # Newton's method (Heron's method) for integer square root
    # Converges quadratically - much faster than binary search
    when radicand is
        0 -> 0
        1 -> 1
        _ ->
            # Start with a good initial guess: radicand // 2
            # For small numbers, use radicand itself as initial guess
            initialGuess = if radicand < 4 then radicand else radicand // 2
            newtonMethod(radicand, initialGuess)

# Newton's method: x_next = (x + n/x) / 2
# Iterates until convergence (when guess doesn't change)
newtonMethod : U64, U64 -> U64
newtonMethod = |n, guess|
    nextGuess = (guess + n // guess) // 2
    
    when Num.compare(nextGuess, guess) is
        EQ -> guess  # Converged
        LT -> 
            # Still improving, continue iteration
            newtonMethod(n, nextGuess)
        GT -> 
            # Guess increased (oscillating), previous was better
            # This can happen due to integer division - return the smaller value
            guess