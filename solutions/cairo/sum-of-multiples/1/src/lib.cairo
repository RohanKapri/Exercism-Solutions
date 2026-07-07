use core::dict::Felt252Dict;

pub fn sum(limit: u32, factors: Array<u32>) -> u32 {
    // Early return for edge cases
    if limit <= 1 {
        return 0;
    }
    
    let mut total: u32 = 0;
    let mut seen: Felt252Dict<bool> = Default::default();
    
    let mut factors_span = factors.span();
    
    loop {
        match factors_span.pop_front() {
            Option::Some(factor) => {
                let factor_val = *factor;
                
                // Skip if factor is 0 or >= limit (no valid multiples)
                if factor_val == 0 || factor_val >= limit {
                    continue;
                }
                
                // Generate multiples efficiently
                let mut multiple = factor_val;
                while multiple < limit {
                    let multiple_felt: felt252 = multiple.into();
                    if !seen.get(multiple_felt) {
                        total += multiple;
                        seen.insert(multiple_felt, true);
                    }
                    
                    // Check for overflow before addition
                    if multiple > limit - factor_val {
                        break;
                    }
                    multiple += factor_val;
                }
            },
            Option::None => {
                break;
            }
        }
    };
    
    total
}
      