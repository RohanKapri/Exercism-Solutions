pub fn is_valid(isbn: ByteArray) -> bool {
    // Accumulate the weighted sum and count of ISBN characters (excluding hyphens)
    let mut sum: u32 = 0;
    let mut count: u32 = 0;
    let mut is_valid_format = true;
    
    let mut i = 0;
    while i < isbn.len() && is_valid_format {
        let b = isbn.at(i).unwrap();
        
        if b == '-' {
            // Hyphen -> ignore
        } else {
            // Only 10 significant chars allowed
            if count >= 10 {
                is_valid_format = false;
            } else if count < 9 {
                // First 9 must be digits
                if b >= '0' && b <= '9' {
                    let digit_value: u32 = (b - '0').into();
                    let weight: u32 = 10 - count;
                    sum += digit_value * weight;
                    count += 1;
                } else {
                    is_valid_format = false;
                }
            } else {
                // Last position (check digit): digit or 'X' (representing 10)
                if b == 'X' {
                    sum += 10 * 1; // weight is 1 for last position
                    count += 1;
                } else if b >= '0' && b <= '9' {
                    let digit_value: u32 = (b - '0').into();
                    sum += digit_value * 1; // weight is 1 for last position
                    count += 1;
                } else {
                    is_valid_format = false;
                }
            }
        }
        
        i += 1;
    };
    
    // Must have exactly 10 significant characters and valid format
    if count != 10 || !is_valid_format {
        return false;
    }
    
    // Valid if weighted sum ≡ 0 (mod 11)
    sum % 11 == 0
}
       