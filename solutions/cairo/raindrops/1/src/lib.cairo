use core::array::ArrayTrait;

pub fn convert(x: u64) -> ByteArray {
    let mut result: ByteArray = "";
    
    // Check divisibility and append corresponding sounds
    if x % 3 == 0 {
        result.append(@"Pling");
    }
    
    if x % 5 == 0 {
        result.append(@"Plang");
    }
    
    if x % 7 == 0 {
        result.append(@"Plong");
    }
    
    // If no sounds were added, return the number as a string
    if result.len() == 0 {
        // Convert u64 to ByteArray (string representation)
        let mut num_str: ByteArray = "";
        let mut number = x;
        
        if number == 0 {
            num_str.append(@"0");
            return num_str;
        }
        
        // Convert number to string by extracting digits
        let mut digits: Array<u8> = ArrayTrait::new();
        while number > 0 {
            let digit = (number % 10).try_into().unwrap();
            digits.append('0' + digit);
            number /= 10;
        };
        
        // Reverse the digits to get correct order
        let mut i = digits.len();
        while i > 0 {
            i -= 1;
            num_str.append_byte(*digits.at(i));
        };
        
        return num_str;
    }
    
    result
}
   