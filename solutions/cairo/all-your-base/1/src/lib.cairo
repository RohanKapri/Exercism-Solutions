#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn rebase(digits: Array<u32>, input_base: u32, output_base: u32) -> Result<Array<u32>, Error> {
    // Validate input and output bases
    if input_base < 2 {
        return Result::Err(Error::InvalidInputBase);
    }
    if output_base < 2 {
        return Result::Err(Error::InvalidOutputBase);
    }
    
    // Handle empty input
    if digits.is_empty() {
        return Result::Ok(array![0]);
    }
    
    // Validate all digits first
    let mut i = 0;
    let mut invalid_digit: Option<u32> = Option::None;
    while i < digits.len() {
        let digit = *digits.at(i);
        if digit >= input_base {
            invalid_digit = Option::Some(digit);
            break;
        }
        i += 1;
    };
    
    // Check if we found an invalid digit
    if let Option::Some(digit) = invalid_digit {
        return Result::Err(Error::InvalidDigit(digit));
    }
    
    // Convert from input base to decimal
    let mut decimal_value: u32 = 0;
    let mut power: u32 = 1;
    let mut i = digits.len();
    
    while i > 0 {
        i -= 1;
        let digit = *digits.at(i);
        decimal_value += digit * power;
        power *= input_base;
    };
    
    // Handle zero case
    if decimal_value == 0 {
        return Result::Ok(array![0]);
    }
    
    // Convert from decimal to output base
    let mut result: Array<u32> = array![];
    let mut value = decimal_value;
    
    while value > 0 {
        let remainder = value % output_base;
        result.append(remainder);
        value /= output_base;
    };
    
    // Reverse the result since we built it backwards
    let mut final_result: Array<u32> = array![];
    let mut j = result.len();
    while j > 0 {
        j -= 1;
        final_result.append(*result.at(j));
    };
    
    Result::Ok(final_result)
}
    