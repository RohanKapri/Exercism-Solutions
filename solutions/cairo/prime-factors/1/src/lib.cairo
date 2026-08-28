pub fn factors(n: u64) -> Array<u64> {
    let mut result = ArrayTrait::new();
    
    if n <= 1 {
        return result;
    }
    
    let mut num = n;
    
    // Handle factor 2 separately
    while num % 2 == 0 {
        result.append(2);
        num = num / 2;
    };
    
    // Now check only odd numbers starting from 3
    let mut divisor: u64 = 3;
    
    // Continue while divisor^2 <= num
    while divisor * divisor <= num {
        // Divide out all occurrences of current divisor
        while num % divisor == 0 {
            result.append(divisor);
            num = num / divisor;
        };
        
        // Skip even numbers (increment by 2)
        divisor = divisor + 2;
    };
    
    // If num > 1 at this point, it must be prime
    if num > 1 {
        result.append(num);
    }
    
    result
}