use core::array::ArrayTrait;
use core::byte_array::ByteArrayTrait;
use core::option::OptionTrait;

#[derive(Debug, PartialEq, Clone, Drop)]
pub struct WordResult {
    pub word: ByteArray,
    pub count: u64,
}

/// Helpers: ASCII classification and lowercasing.
fn is_ascii_letter(b: u8) -> bool {
    (b >= 65 && b <= 90) || (b >= 97 && b <= 122) // A-Z or a-z
}

fn is_ascii_digit(b: u8) -> bool {
    b >= 48 && b <= 57 // 0-9
}

fn to_lower(b: u8) -> u8 {
    if b >= 65 && b <= 90 { 
        b + 32 
    } else { 
        b 
    }       // 'A'..'Z' -> 'a'..'z'
}

/// Insert `key` into `results` or increment its count if already present.
fn add_or_increment(ref results: Array<WordResult>, key: @ByteArray) {
    let mut tmp: Array<WordResult> = ArrayTrait::new();
    let mut found = false;

    loop {
        match results.pop_front() {
            Option::Some(item) => {
                let mut v = item;
                if byte_arrays_equal(@v.word, key) {
                    v.count = v.count + 1;
                    found = true;
                }
                tmp.append(v);
            },
            Option::None => { break; }
        }
    };

    if !found {
        tmp.append(WordResult { word: key.clone(), count: 1 });
    }

    // Move back into `results`.
    loop {
        match tmp.pop_front() {
            Option::Some(item) => results.append(item),
            Option::None => { break; }
        }
    }
}

fn byte_arrays_equal(a: @ByteArray, b: @ByteArray) -> bool {
    if a.len() != b.len() {
        false
    } else {
        let mut i = 0;
        let mut equal = true;
        while i < a.len() && equal {
            if a.at(i).unwrap() != b.at(i).unwrap() {
                equal = false;
            }
            i += 1;
        };
        equal
    }
}

pub fn count_words(phrase: ByteArray) -> Span<WordResult> {
    let mut results: Array<WordResult> = ArrayTrait::new();
    let mut token: ByteArray = "";
    let apostrophe = 39; // '\''
    let mut i: usize = 0;
    let n = phrase.len();

    loop {
        if i >= n { break; }

        // Get the byte at position i
        let b = phrase.at(i).unwrap(); // Safe since i < n

        if is_ascii_letter(b) {
            token.append_byte(to_lower(b));
        } else if is_ascii_digit(b) {
            token.append_byte(b);
        } else if b == apostrophe {
            // Keep apostrophe only for *internal* contractions
            let mut keep = false;
            if token.len() > 0 {
                match phrase.at(i + 1) {
                    Option::Some(next_b) => {
                        if is_ascii_letter(next_b) {
                            keep = true;
                        }
                    },
                    Option::None => {}
                }
            }
            if keep {
                token.append_byte(apostrophe);
            } else {
                if token.len() > 0 {
                    add_or_increment(ref results, @token);
                    token = "";
                }
            }
        } else {
            // Any other punctuation/whitespace ends a word.
            if token.len() > 0 {
                add_or_increment(ref results, @token);
                token = "";
            }
        }

        i = i + 1;
    };

    // Flush last token if any.
    if token.len() > 0 {
        add_or_increment(ref results, @token);
    }

    results.span()
}
      