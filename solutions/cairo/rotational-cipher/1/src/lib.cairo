pub fn rotate(text: ByteArray, shift_key: u8) -> ByteArray {
    let mut result = "";
    let normalized_shift = shift_key % 26;
    
    let mut i = 0;
    while i < text.len() {
        let byte = text.at(i).unwrap();
        let char = byte.into();
        
        if is_lowercase_letter(char) {
            let shifted_char = shift_lowercase_letter(char, normalized_shift);
            result.append_byte(shifted_char);
        } else if is_uppercase_letter(char) {
            let shifted_char = shift_uppercase_letter(char, normalized_shift);
            result.append_byte(shifted_char);
        } else {
            // Keep non-alphabetic characters unchanged (spaces, punctuation, numbers)
            result.append_byte(char);
        }
        
        i += 1;
    };
    
    result
}

fn is_lowercase_letter(char: u8) -> bool {
    char >= 97 && char <= 122 // 'a' to 'z'
}

fn is_uppercase_letter(char: u8) -> bool {
    char >= 65 && char <= 90 // 'A' to 'Z'
}

fn shift_lowercase_letter(char: u8, shift: u8) -> u8 {
    let base = 97; // 'a'
    let offset = char - base;
    let shifted_offset = (offset + shift) % 26;
    base + shifted_offset
}

fn shift_uppercase_letter(char: u8, shift: u8) -> u8 {
    let base = 65; // 'A'
    let offset = char - base;
    let shifted_offset = (offset + shift) % 26;
    base + shifted_offset
}