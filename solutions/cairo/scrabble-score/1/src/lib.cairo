pub fn score(word: ByteArray) -> u16 {
    let mut total_score: u16 = 0;
    let mut i: usize = 0;
    
    while i < word.len() {
        let byte = word.at(i).unwrap();
        let letter_score = get_letter_score(byte);
        total_score += letter_score;
        i += 1;
    };
    
    total_score
}

fn get_letter_score(byte: u8) -> u16 {
    // Convert to lowercase for easier matching
    let lower_byte = if byte >= 'A' && byte <= 'Z' {
        byte + 32 // Convert uppercase to lowercase
    } else {
        byte
    };
    
    // 1 point letters: A, E, I, O, U, L, N, R, S, T
    if lower_byte == 'a' || lower_byte == 'e' || lower_byte == 'i' || lower_byte == 'o' || 
       lower_byte == 'u' || lower_byte == 'l' || lower_byte == 'n' || lower_byte == 'r' || 
       lower_byte == 's' || lower_byte == 't' {
        return 1;
    }
    
    // 2 point letters: D, G
    if lower_byte == 'd' || lower_byte == 'g' {
        return 2;
    }
    
    // 3 point letters: B, C, M, P
    if lower_byte == 'b' || lower_byte == 'c' || lower_byte == 'm' || lower_byte == 'p' {
        return 3;
    }
    
    // 4 point letters: F, H, V, W, Y
    if lower_byte == 'f' || lower_byte == 'h' || lower_byte == 'v' || lower_byte == 'w' || 
       lower_byte == 'y' {
        return 4;
    }
    
    // 5 point letters: K
    if lower_byte == 'k' {
        return 5;
    }
    
    // 8 point letters: J, X
    if lower_byte == 'j' || lower_byte == 'x' {
        return 8;
    }
    
    // 10 point letters: Q, Z
    if lower_byte == 'q' || lower_byte == 'z' {
        return 10;
    }
    
    // All other characters (numbers, special chars) score 0
    0
}