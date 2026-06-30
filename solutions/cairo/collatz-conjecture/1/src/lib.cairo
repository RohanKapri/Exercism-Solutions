/// Implementation of the Collatz Conjecture
///
/// The Collatz Conjecture states that for any positive integer:
/// 1. If the number is even, divide it by 2
/// 2. If the number is odd, multiply it by 3 and add 1
/// 3. Repeat the process until you reach 1
///
/// This conjecture remains unproven but has been verified for all
/// starting numbers up to 2^68.

/// Returns the number of steps required to reach 1 using the Collatz Conjecture rules.
/// 
/// # Arguments
/// * `number` - A positive integer to apply the Collatz Conjecture to
///
/// # Returns
/// The number of steps it takes to reach 1
///
/// # Panics
/// Panics if `number` is 0 (only positive integers are allowed)
///
/// # Examples
/// ```
/// let steps_for_12 = collatz_conjecture::steps(12);
/// assert_eq!(steps_for_12, 9);
/// ```
pub fn steps(number: usize) -> usize {
    // Input validation - ensure we have a positive number
    if number == 0 {
        panic!("Only positive integers are allowed")
    }
    
    // Base case - if we start with 1, we need 0 steps
    if number == 1 {
        return 0;
    }
    
    // Main Collatz sequence calculation using recursion
    return collatz_sequence(number, 0);
}

/// Helper function that processes the Collatz sequence recursively
/// 
/// # Arguments
/// * `n` - Current number in the sequence
/// * `step_count` - Number of steps taken so far
///
/// # Returns
/// Total number of steps to reach 1
fn collatz_sequence(n: usize, step_count: usize) -> usize {
    // Base case: we've reached 1
    if n == 1 {
        return step_count;
    }
    
    // Check if number is even using modulo
    if n % 2 == 0 {
        // Even case: divide by 2
        collatz_sequence(n / 2, step_count + 1)
    } else {
        // Odd case: 3n + 1
        collatz_sequence(3 * n + 1, step_count + 1)
    }
}

/// Alternative iterative implementation
pub fn steps_iterative(number: usize) -> usize {
    let mut n: usize = number;
    
    if n == 0 {
        panic!("Only positive integers are allowed")
    }
    
    let mut steps = 0;
    
    while n != 1 {
        // Using modulo to check even/odd
        if n % 2 == 0 {
            n = n / 2;  // Divide by 2
        } else {
            n = 3 * n + 1;
        }
        steps += 1;
    };
    
    steps
}