pub fn is_isogram(phrase: ByteArray) -> bool {
    let mut seen_chars: Array<u8> = array![];
    let mut i = 0;
    let mut is_duplicate_found = false;
    
    while i < phrase.len() && !is_duplicate_found {
        let byte = phrase[i];
        
        // Skip spaces and hyphens as they are allowed to repeat
        if byte == ' ' || byte == '-' {
            i += 1;
            continue;
        }
        
        // Convert to lowercase for case-insensitive comparison
        let normalized_byte = if byte >= 'A' && byte <= 'Z' {
            byte + ('a' - 'A')
        } else {
            byte
        };
        
        // Check if we've seen this character before
        let mut j = 0;
        let mut found = false;
        while j < seen_chars.len() {
            if *seen_chars[j] == normalized_byte {
                found = true;
                break;
            }
            j += 1;
        };
        
        if found {
            is_duplicate_found = true;
        } else {
            // Add the character to our seen list
            seen_chars.append(normalized_byte);
        }
        
        i += 1;
    };
    
    !is_duplicate_found
}