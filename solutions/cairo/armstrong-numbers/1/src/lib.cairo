pub fn is_armstrong_number(num: u128) -> bool {
    // Special case for 0
    if num == 0 {
        return true;
    }
    
    // Count the number of digits
    let mut temp = num;
    let mut digit_count = 0;
    while temp > 0 {
        digit_count += 1;
        temp /= 10;
    };
    
    // Calculate the sum of digits raised to the power of digit_count
    let mut sum = 0;
    let mut temp = num;
    while temp > 0 {
        let digit = temp % 10;
        sum += power(digit, digit_count);
        temp /= 10;
    };
    
    sum == num
}

// Helper function to calculate power
fn power(base: u128, exp: u32) -> u128 {
    let mut result = 1;
    let mut i = 0;
    while i < exp {
        result *= base;
        i += 1;
    };
    result
}
  