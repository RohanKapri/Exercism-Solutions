pub fn encode(integers: Array<u32>) -> Array<u32> {
    let mut result: Array<u32> = array![];
    
    for integer in integers {
        let mut value = integer;
        let mut bytes: Array<u32> = array![];
        
        // Extract 7-bit groups from least significant to most significant
        loop {
            let byte = value & 0x7F;  // Get the lower 7 bits
            bytes.append(byte);
            value = value / 128;  // Shift right by 7 bits (128 = 2^7)
            
            if value == 0 {
                break;
            }
        };
        
        // Output bytes in reverse order (most significant first) with continuation bits
        let len = bytes.len();
        let mut i = len;
        loop {
            if i == 0 {
                break;
            }
            i = i - 1;
            
            let mut byte = *bytes.at(i);
            if i != 0 {
                byte = byte | 0x80;  // Set continuation bit (bit #7)
            }
            result.append(byte);
        };
    };
    
    result
}

pub fn decode(integers: Array<u32>) -> Array<u32> {
    let mut result: Array<u32> = array![];
    let mut value: u32 = 0;
    let mut i: usize = 0;
    
    while i < integers.len() {
        let byte = *integers.at(i);
        value = (value * 128) + (byte & 0x7F);  // Shift left by 7 and add new bits
        
        if (byte & 0x80) == 0 {
            // This is the last byte of the current value (no continuation bit)
            result.append(value);
            value = 0;
        } else if i == integers.len() - 1 {
            // Continuation bit is set but no more bytes available
            panic!("incomplete sequence");
        }
        
        i = i + 1;
    };
    
    result
}
   