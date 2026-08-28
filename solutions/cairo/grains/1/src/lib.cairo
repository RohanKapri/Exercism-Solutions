pub fn square(s: u8) -> u64 {
    // Validate input: square must be between 1 and 64
    if s < 1 || s > 64 {
        panic!("square must be between 1 and 64");
    }
    
    // Calculate 2^(s-1) using iterative multiplication
    // For square n, we have 2^(n-1) grains
    power_of_two(s - 1)
}

pub fn total() -> u64 {
    // Total grains on chessboard is sum of 2^0 + 2^1 + ... + 2^63
    // This equals 2^64 - 1, but since u64 max is 2^64 - 1, we can use that
    // So we use the mathematical fact that sum = 2^64 - 1 = u64::MAX
    18_446_744_073_709_551_615_u64
}

// Helper function to calculate 2^exponent
fn power_of_two(exponent: u8) -> u64 {
    let mut result = 1_u64;
    let mut i = 0_u8;
    while i < exponent {
        result *= 2;
        i += 1;
    };
    result
}
   