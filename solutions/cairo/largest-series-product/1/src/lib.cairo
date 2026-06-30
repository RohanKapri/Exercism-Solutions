#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
}

pub fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    // Check for negative span
    if span < 0 {
        return Result::Err(Error::NegativeSpan);
    }
    
    let span_u32 = span.try_into().unwrap();
    let input_len = input.len();
    
    // Check if span is longer than input length
    if span_u32 > input_len {
        return Result::Err(Error::SpanTooLong);
    }
    
    // Special case: span of 0 always returns 1
    if span == 0 {
        return Result::Ok(1);
    }
    
    // Convert input to array of digits and validate
    let mut digits: Array<u64> = array![];
    let mut i = 0;
    let mut validation_error: Option<Error> = Option::None;
    
    while i < input_len && validation_error.is_none() {
        let byte = input.at(i).unwrap();
        
        // Check if byte is a valid digit (ASCII '0' to '9')
        if byte < 48 || byte > 57 {
            validation_error = Option::Some(Error::InvalidDigit(byte));
        } else {
            // Convert ASCII digit to number
            let digit = (byte - 48).into();
            digits.append(digit);
        }
        
        i += 1;
    };
    
    // Check if we encountered an error during validation
    match validation_error {
        Option::Some(error) => { return Result::Err(error); },
        Option::None => {}
    }
    
    // Find the largest product
    let mut max_product: u64 = 0;
    let mut i = 0;
    let num_windows = input_len - span_u32 + 1;
    
    while i < num_windows {
        let mut product: u64 = 1;
        let mut j = 0;
        
        // Calculate product for current window
        while j < span_u32 {
            product *= *digits.at(i + j);
            j += 1;
        };
        
        // Update max if this product is larger
        if product > max_product {
            max_product = product;
        }
        
        i += 1;
    };
    
    Result::Ok(max_product)
}
   