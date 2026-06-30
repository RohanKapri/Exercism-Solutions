#[derive(Debug, Drop, PartialEq)]
pub enum Classification {
    Deficient,
    Perfect,
    Abundant,
}

pub fn classify(number: u64) -> Classification {
    if number == 0 {
        panic!("Classification is only possible for positive integers.")
    }
    
    let aliquot_sum = calculate_aliquot_sum(number);
    
    if aliquot_sum == number {
        Classification::Perfect
    } else if aliquot_sum > number {
        Classification::Abundant
    } else {
        Classification::Deficient
    }
}

fn calculate_aliquot_sum(number: u64) -> u64 {
    if number <= 1 {
        return 0;
    }
    
    let mut sum = 1; // 1 is always a proper divisor for numbers > 1
    let mut i = 2;
    
    // Only check up to sqrt(number) for efficiency
    while i * i <= number {
        if number % i == 0 {
            sum += i;
            // Add the corresponding divisor (number / i) if it's different from i
            if i != number / i {
                sum += number / i;
            }
        }
        i += 1;
    };
    
    sum
}
  