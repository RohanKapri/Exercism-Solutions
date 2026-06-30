#[derive(Drop, Debug)]
pub struct Set {
    pub values: Array<ByteArray>
}

#[generate_trait]
pub impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        Set { values }
    }
}

impl SetPartialEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        if lhs.values.len() != rhs.values.len() {
            false
        } else {
            let mut all_equal = true;
            let mut i = 0;
            while i < lhs.values.len() && all_equal {
                let mut found = false;
                let mut j = 0;
                while j < rhs.values.len() {
                    if lhs.values[i] == rhs.values[j] {
                        found = true;
                        break;
                    }
                    j += 1;
                };
                if !found {
                    all_equal = false;
                }
                i += 1;
            };
            all_equal
        }
    }
}

fn to_lowercase(word: @ByteArray) -> ByteArray {
    let mut result = "";
    let mut i = 0;
    while i < word.len() {
        let c = word.at(i).unwrap();
        let lowercase_c = if c >= 'A' && c <= 'Z' {
            c + 32
        } else {
            c
        };
        result.append_byte(lowercase_c);
        i += 1;
    };
    result
}

fn count_char_occurrences(word: @ByteArray, target_char: u8) -> u32 {
    let mut count = 0;
    let mut i = 0;
    while i < word.len() {
        if word.at(i).unwrap() == target_char {
            count += 1;
        }
        i += 1;
    };
    count
}

fn are_anagrams_impl(word1: @ByteArray, word2: @ByteArray) -> bool {
    let lower1 = to_lowercase(word1);
    let lower2 = to_lowercase(word2);
    
    if lower1.len() != lower2.len() {
        false
    } else {
        let mut is_anagram = true;
        let mut i = 0;
        while i < lower1.len() && is_anagram {
            let c = lower1.at(i).unwrap();
            let count1 = count_char_occurrences(@lower1, c);
            let count2 = count_char_occurrences(@lower2, c);
            if count1 != count2 {
                is_anagram = false;
            }
            i += 1;
        };
        is_anagram
    }
}

fn are_same_words_impl(word1: @ByteArray, word2: @ByteArray) -> bool {
    let lower1 = to_lowercase(word1);
    let lower2 = to_lowercase(word2);
    lower1 == lower2
}

pub fn anagrams_for(word: @ByteArray, candidates: @Set) -> Set {
    let mut result_values: Array<ByteArray> = array![];
    
    let mut i = 0;
    while i < candidates.values.len() {
        let candidate = candidates.values[i].clone();
        
        if !are_same_words_impl(word, @candidate) {
            if are_anagrams_impl(word, @candidate) {
                result_values.append(candidate);
            }
        }
        
        i += 1;
    };
    
    Set { values: result_values }
}
  