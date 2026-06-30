pub fn clean(phrase: ByteArray) -> ByteArray {
    let mut cleaned_digits = ArrayTrait::<u8>::new();
    
    // Extract only digits from the input
    let mut i = 0;
    while i < phrase.len() {
        let byte = phrase.at(i).unwrap();
        
        // Check for letters
        if (byte >= 'a' && byte <= 'z') || (byte >= 'A' && byte <= 'Z') {
            panic!("letters not permitted");
        }
        
        // Check for invalid punctuation (excluding allowed ones)
        if byte != ' ' && byte != '(' && byte != ')' && byte != '-' && byte != '.' && byte != '+' && !(byte >= '0' && byte <= '9') {
            panic!("punctuations not permitted");
        }
        
        // Add digits to our array
        if byte >= '0' && byte <= '9' {
            cleaned_digits.append(byte);
        }
        
        i += 1;
    };
    
    let digit_count = cleaned_digits.len();
    
    // Check length constraints
    if digit_count < 10 {
        panic!("must not be fewer than 10 digits");
    }
    
    if digit_count > 11 {
        panic!("must not be greater than 11 digits");
    }
    
    // Handle 11-digit numbers
    let final_digits = if digit_count == 11 {
        let first_digit = *cleaned_digits.at(0);
        if first_digit != '1' {
            panic!("11 digits must start with 1");
        }
        // Remove the country code '1' and use remaining 10 digits
        let mut remaining = ArrayTrait::<u8>::new();
        let mut j = 1;
        while j < cleaned_digits.len() {
            remaining.append(*cleaned_digits.at(j));
            j += 1;
        };
        remaining
    } else {
        cleaned_digits
    };
    
    // Validate area code (first 3 digits)
    let area_code_first = *final_digits.at(0);
    if area_code_first == '0' {
        panic!("area code cannot start with zero");
    }
    if area_code_first == '1' {
        panic!("area code cannot start with one");
    }
    
    // Validate exchange code (digits 4-6, index 3)
    let exchange_code_first = *final_digits.at(3);
    if exchange_code_first == '0' {
        panic!("exchange code cannot start with zero");
    }
    if exchange_code_first == '1' {
        panic!("exchange code cannot start with one");
    }
    
    // Build the result ByteArray
    let mut result = "";
    let mut k = 0;
    while k < final_digits.len() {
        let digit_char = *final_digits.at(k);
        result.append_byte(digit_char);
        k += 1;
    };
    
    result
}