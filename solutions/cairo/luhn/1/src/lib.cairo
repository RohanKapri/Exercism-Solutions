// Function to validate a number using the Luhn algorithm
pub fn valid(candidate: ByteArray) -> bool {
    // Extract only the digits from the input
    let mut digits: Array<u8> = array![];
    let mut i = 0;
    let mut has_invalid_char = false;
    
    // Iterate through the ByteArray and validate characters
    while i < candidate.len() && !has_invalid_char {
        let char = candidate[i];
        
        // Check if it's a digit (ASCII '0' = 48, '9' = 57)
        if char >= 48 && char <= 57 {
            // Convert ASCII to actual digit value
            digits.append(char - 48);
        } else if char == 32 { // ASCII space
            // Spaces are allowed, just skip them
        } else {
            // Any other character makes the input invalid
            has_invalid_char = true;
        }
        i += 1;
    };
    
    // Check for invalid characters or insufficient digits
    if has_invalid_char || digits.len() <= 1 {
        return false;
    }
    
    // Apply the Luhn algorithm
    let mut sum: u32 = 0;
    let mut double_next = false;
    
    // Process digits from right to left
    let mut j = digits.len();
    while j > 0 {
        j -= 1;
        let mut digit_value: u32 = (*digits[j]).into();
        
        if double_next {
            digit_value *= 2;
            if digit_value > 9 {
                digit_value -= 9;
            }
        }
        
        sum += digit_value;
        double_next = !double_next;
    };
    
    // Check if sum is divisible by 10
    sum % 10 == 0
}