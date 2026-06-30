// Returns a welcome message for the customer.
pub fn welcome_message(customer: felt252) -> ByteArray {
    let mut result: ByteArray = "Welcome to the Tech Palace, ";
    result += to_uppercase(customer.into());
    result
}

// Adds a border to a welcome message.
pub fn add_border(welcome_msg: ByteArray, num_stars_per_line: u32) -> ByteArray {
    let mut stars: ByteArray = "";
    let mut i = 0;

    while i < num_stars_per_line {
        stars.append_byte('*');
        i += 1;
    }

    let mut result = stars.clone();
    result.append_byte('\n');
    result += welcome_msg;
    result.append_byte('\n');
    result += stars;

    result
}

// Cleans up an old marketing message.
pub fn clean_up_message(old_msg: ByteArray) -> ByteArray {
    let mut no_stars: ByteArray = "";

    // Remove all stars.
    let mut i = 0;
    while i < old_msg.len() {
        let c = old_msg[i];
        if c != '*' {
            no_stars.append_byte(c);
        }
        i += 1;
    }

    // Remove leading whitespace.
    let mut start = 0;
    while start < no_stars.len() {
        if !is_whitespace(no_stars[start]) {
            break;
        }
        start += 1;
    }

    // Remove trailing whitespace.
    let mut end = no_stars.len();
    while end > start {
        if !is_whitespace(no_stars[end - 1]) {
            break;
        }
        end -= 1;
    }

    // Build the cleaned string.
    let mut result: ByteArray = "";
    let mut j = start;
    while j < end {
        result.append_byte(no_stars[j]);
        j += 1;
    }

    result
}

///////////////
/// Helpers ///
///////////////

// Distance between a lowercase and uppercase representations
// of the same character in the ASCII table
const ASCII_CASE_OFFSET: u8 = 32;
const BYTE_SIZE: u256 = 256; // 2^8, number of possible values in a byte
const BYTE_MASK: u256 = 0xff; // Mask to extract the last byte (8 bits)

fn to_uppercase(input: u256) -> ByteArray {
    let mut remaining_bytes = input;
    let mut uppercase_chars: ByteArray = "";
    while remaining_bytes != 0 {
        uppercase_chars.append_byte(char_to_uppercase(get_last_byte(remaining_bytes)));
        remaining_bytes = remove_last_byte(remaining_bytes);
    }
    uppercase_chars.rev()
}

fn get_last_byte(chars: u256) -> u8 {
    (chars & BYTE_MASK.into()).try_into().unwrap()
}

fn remove_last_byte(chars: u256) -> u256 {
    chars / BYTE_SIZE.into()
}

fn char_to_uppercase(c: u8) -> u8 {
    if is_lowercase(c) {
        c - ASCII_CASE_OFFSET
    } else {
        c
    }
}

fn is_lowercase(c: u8) -> bool {
    c >= 'a' && c <= 'z'
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
}