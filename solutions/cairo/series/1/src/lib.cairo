pub fn slices(series: ByteArray, slice_length: usize) -> Array<ByteArray> {
    // Check for edge cases
    if series.len() == 0 {
        panic!("series cannot be empty");
    }
    
    if slice_length == 0 {
        panic!("slice length cannot be zero");
    }
    
    if slice_length > series.len() {
        panic!("slice length cannot be greater than series length");
    }
    
    let mut result: Array<ByteArray> = array![];
    let mut i: usize = 0;
    
    // Iterate through the string until we can't extract a full slice
    while i + slice_length <= series.len() {
        // Extract substring from position i with length slice_length
        let mut slice = "";
        let mut j: usize = 0;
        
        // Build the substring character by character
        while j < slice_length {
            let char_at_pos = series.at(i + j).unwrap();
            slice.append_byte(char_at_pos);
            j += 1;
        };
        
        result.append(slice);
        i += 1;
    };
    
    result
}
     