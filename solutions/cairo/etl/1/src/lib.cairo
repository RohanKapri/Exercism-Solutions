use core::dict::Felt252Dict;

pub fn transform(legacy: Felt252Dict<Nullable<Span<u8>>>) -> Felt252Dict<u32> {
    let mut result: Felt252Dict<u32> = Default::default();
    let mut legacy = legacy;
    
    // Check all possible score values that exist in the legacy data
    let scores = array![1, 2, 3, 4, 5, 8, 10];
    
    for score in scores {
        let letters_nullable = legacy.get(score.into());
        
        // Check if this score has associated letters
        if !letters_nullable.is_null() {
            let letters = letters_nullable.deref();
            
            // Process each letter for this score
            for letter in letters {
                // Convert uppercase to lowercase by adding 32
                let lowercase_letter = *letter + 32;
                result.insert(lowercase_letter.into(), score);
            }
        }
    };
    
    result
}