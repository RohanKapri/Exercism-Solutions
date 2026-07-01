use core::byte_array::ByteArray;

// ASCII values
const ASCII_LOWERCASE_A: u8 = 97; // 'a'
const ASCII_LOWERCASE_Z: u8 = 122; // 'z'
const ASCII_UPPERCASE_A: u8 = 65; // 'A'
const ASCII_UPPERCASE_Z: u8 = 90; // 'Z'
const ASCII_DIGIT_0: u8 = 48; // '0'
const ASCII_DIGIT_9: u8 = 57; // '9'
const ASCII_SPACE: u8 = 32; // ' '

/// Checks if a byte is a lowercase letter
fn is_lowercase(c: u8) -> bool {
    c >= ASCII_LOWERCASE_A && c <= ASCII_LOWERCASE_Z
}

/// Checks if a byte is an uppercase letter
fn is_uppercase(c: u8) -> bool {
    c >= ASCII_UPPERCASE_A && c <= ASCII_UPPERCASE_Z
}

/// Checks if a byte is a digit
fn is_digit(c: u8) -> bool {
    c >= ASCII_DIGIT_0 && c <= ASCII_DIGIT_9
}

/// Converts an uppercase letter to lowercase
fn to_lowercase(c: u8) -> u8 {
    if is_uppercase(c) {
        return c + 32;
    }
    c
}

/// Applies the Atbash substitution to a letter
fn atbash_substitute(c: u8) -> u8 {
    if is_lowercase(c) {
        // The formula: (ASCII_LOWERCASE_Z - (c - ASCII_LOWERCASE_A))
        // Simplified to: (ASCII_LOWERCASE_Z + ASCII_LOWERCASE_A - c)
        return ASCII_LOWERCASE_Z + ASCII_LOWERCASE_A - c;
    } else if is_uppercase(c) {
        // Convert to lowercase first, then apply substitution
        let lowercase = to_lowercase(c);
        return ASCII_LOWERCASE_Z + ASCII_LOWERCASE_A - lowercase;
    }
    c
}

/// Encodes a phrase using the Atbash cipher
/// 
/// The encoding process:
/// 1. Convert to lowercase
/// 2. Replace each letter with its Atbash substitution
/// 3. Keep numbers unchanged, remove all other characters
/// 4. Format result in groups of 5 characters
pub fn encode(phrase: ByteArray) -> ByteArray {
    let mut result: ByteArray = Default::default();
    let mut char_count: u32 = 0;
    
    // Process each character in the input phrase
    let mut i: u32 = 0;
    while i < phrase.len() {
        let c = phrase.at(i).unwrap();
        
        if is_lowercase(c) || is_uppercase(c) {
            // Apply Atbash substitution to letters
            let substituted = atbash_substitute(c);
            
            // Add a space after every 5 characters (except at the beginning)
            if char_count != 0 && char_count % 5 == 0 {
                result.append_byte(ASCII_SPACE);
            }
            
            result.append_byte(substituted);
            char_count += 1;
        } else if is_digit(c) {
            // Include digits unchanged
            
            // Add a space after every 5 characters (except at the beginning)
            if char_count != 0 && char_count % 5 == 0 {
                result.append_byte(ASCII_SPACE);
            }
            
            result.append_byte(c);
            char_count += 1;
        }
        
        i += 1;
    };
    
    result
}

/// Decodes a phrase that was encoded with the Atbash cipher
/// 
/// The decoding process:
/// 1. Apply the Atbash substitution to each letter
/// 2. Keep numbers unchanged
/// 3. Ignore spaces
pub fn decode(phrase: ByteArray) -> ByteArray {
    let mut result: ByteArray = Default::default();
    
    // Process each character in the input phrase
    let mut i: u32 = 0;
    while i < phrase.len() {
        let c = phrase.at(i).unwrap();
        
        if c == ASCII_SPACE {
            // Skip spaces
        } else if is_lowercase(c) {
            // Apply Atbash substitution to lowercase letters
            let substituted = atbash_substitute(c);
            result.append_byte(substituted);
        } else if is_digit(c) {
            // Include digits unchanged
            result.append_byte(c);
        }
        
        i += 1;
    };
    
    result
}