pub fn is_pangram(sentence: ByteArray) -> bool {
    // Create a boolean array to track which letters we've seen
    let mut letters_found: Array<bool> = array![];
    let mut i: u32 = 0;
    while i < 26 {
        letters_found.append(false);
        i += 1;
    };
    
    // Iterate through each byte in the sentence
    let mut i: u32 = 0;
    while i < sentence.len() {
        let byte = sentence.at(i).unwrap();
        
        // Determine if this is a letter and its index (0-25)
        let mut letter_index: Option<u8> = Option::None;
        
        if byte >= 'A' && byte <= 'Z' {
            // Uppercase letter - convert to index
            letter_index = Option::Some(byte - 'A');
        } else if byte >= 'a' && byte <= 'z' {
            // Lowercase letter - convert to index  
            letter_index = Option::Some(byte - 'a');
        }
        
        // If we found a letter, mark it as seen
        match letter_index {
            Option::Some(index) => {
                // Update the letters_found array
                let mut new_letters: Array<bool> = array![];
                let mut j: u32 = 0;
                while j < letters_found.len() {
                    if j == index.into() {
                        new_letters.append(true);
                    } else {
                        new_letters.append(*letters_found.at(j));
                    }
                    j += 1;
                };
                letters_found = new_letters;
            },
            Option::None => {}
        }
        
        i += 1;
    };
    
    // Check if all 26 letters have been found
    let mut all_found = true;
    let mut j: u32 = 0;
    while j < 26 {
        if !(*letters_found.at(j)) {
            all_found = false;
            break;
        }
        j += 1;
    };
    
    all_found
}