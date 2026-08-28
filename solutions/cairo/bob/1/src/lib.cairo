use core::byte_array::ByteArray;
use core::option::OptionTrait;

pub fn response(input: @ByteArray) -> ByteArray {
    // Check if input is silence (empty or only whitespace)
    if is_silence(input) {
        return "Fine. Be that way!";
    }
    
    let is_question = is_question_mark(input);
    let is_yelling = is_yelling(input);
    
    if is_yelling && is_question {
        return "Calm down, I know what I'm doing!";
    } else if is_yelling {
        return "Whoa, chill out!";
    } else if is_question {
        return "Sure.";
    } else {
        return "Whatever.";
    }
}

/// Checks if the input is silence (empty or only whitespace)
fn is_silence(input: @ByteArray) -> bool {
    let len = input.len();
    
    if len == 0 {
        return true;
    }
    
    let mut i = 0;
    loop {
        if i == len {
            break true;
        }
        
        if let Option::Some(c) = input.at(i) {
            // Check for various whitespace characters
            if c != ' '_u8 && c != '\t'_u8 && c != '\n'_u8 && c != '\r'_u8 {
                break false;
            }
        }
        
        i += 1;
    }
}

/// Checks if input ends with a question mark, ignoring trailing whitespace
fn is_question_mark(input: @ByteArray) -> bool {
    let mut i = input.len();
    
    loop {
        if i == 0 {
            break false;
        }
        
        i -= 1;
        
        if let Option::Some(c) = input.at(i) {
            if c == '?'_u8 {
                break true;
            }
            // Skip whitespace characters but break if we find any other character
            if c != ' '_u8 && c != '\t'_u8 && c != '\n'_u8 && c != '\r'_u8 {
                break false;
            }
        }
    }
}

/// Checks if the input is yelling (all uppercase with at least one letter)
fn is_yelling(input: @ByteArray) -> bool {
    let mut has_letters = false;
    let mut all_uppercase = true;
    let mut i = 0;
    
    loop {
        if i == input.len() {
            break;
        }
        
        if let Option::Some(c) = input.at(i) {
            if c >= 'a'_u8 && c <= 'z'_u8 {
                // Found lowercase letter, not yelling
                all_uppercase = false;
                break;
            } else if c >= 'A'_u8 && c <= 'Z'_u8 {
                // Found uppercase letter
                has_letters = true;
            }
        }
        
        i += 1;
    };
    
    // Must have at least one letter and all letters must be uppercase
    has_letters && all_uppercase
}