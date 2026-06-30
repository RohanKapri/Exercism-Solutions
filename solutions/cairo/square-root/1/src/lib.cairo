pub fn sqrt(radicand: u64) -> u64 {
    if radicand < 2 {
        return radicand;
    }

    let mut rad = radicand;
    let mut result = 0_u64;
    let mut bit = 4611686018427387904_u64; // This is 2^62, equivalent to 1_u64 << 62
    
    // Find the highest bit pair by dividing by 4 until bit <= radicand
    loop {
        if bit <= rad {
            break;
        }
        bit = bit / 4;  // Equivalent to bit >>= 2
    };
    
    loop {
        if bit == 0 {
            break;
        }
        
        let temp = result + bit;
        if rad >= temp {
            result = temp + bit;
            rad = rad - temp;
        }
        result = result / 2;  // Equivalent to result >>= 1
        bit = bit / 4;        // Equivalent to bit >>= 2
    };
    
    result
}
   