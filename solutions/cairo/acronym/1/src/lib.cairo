use core::byte_array::ByteArray;

// Constants for ASCII values
const ASCII_UPPERCASE_A: u8 = 65; // 'A'
const ASCII_UPPERCASE_Z: u8 = 90; // 'Z'
const ASCII_LOWERCASE_A: u8 = 97; // 'a'
const ASCII_LOWERCASE_Z: u8 = 122; // 'z'
const ASCII_APOSTROPHE: u8 = 39; // '''
const UPPERCASE_LOWERCASE_DIFF: u8 = 32;

/// Checks if a character is a letter or apostrophe
fn is_valid_char(char: u8) -> bool {
    // Check if char is apostrophe or letter
    if char == ASCII_APOSTROPHE {
        return true;
    }
    // Check if char is uppercase letter
    if char >= ASCII_UPPERCASE_A && char <= ASCII_UPPERCASE_Z {
        return true;
    }
    // Check if char is lowercase letter
    if char >= ASCII_LOWERCASE_A && char <= ASCII_LOWERCASE_Z {
        return true;
    }
    false
}


/// Converts a character to uppercase if it's lowercase
fn to_uppercase(char: u8) -> u8 {
    if char >= ASCII_LOWERCASE_A && char <= ASCII_LOWERCASE_Z {
        char - UPPERCASE_LOWERCASE_DIFF
    } else {
        char
    }
}

/// Creates an acronym from a phrase
pub fn abbreviate(phrase: ByteArray) -> ByteArray {
    let mut result: ByteArray = Default::default();
    let mut index = 0;
    let phrase_len = phrase.len();
    
    // Handle first character
    if phrase_len > 0 {
        let first_char = phrase.at(0).unwrap();
        result.append_byte(to_uppercase(first_char));
    }
    
    while index < phrase_len - 1 {
        let current_char = phrase.at(index).unwrap();
        let next_char = phrase.at(index + 1).unwrap();
        
        // If current character is not valid (separator) and next is a letter
        if !is_valid_char(current_char) && is_valid_char(next_char) {
            result.append_byte(to_uppercase(next_char));
        }
        
        index += 1;
    };
    
    result
}