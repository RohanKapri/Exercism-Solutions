pub fn rows(count: u32) -> Array<Array<u32>> {
    let mut result: Array<Array<u32>> = array![];
    
    if count == 0 {
        return result;
    }
    
    // Generate each row
    let mut row_index = 0;
    while row_index < count {
        let mut current_row: Array<u32> = array![];
        
        // Generate each element in the current row
        let mut col_index = 0;
        while col_index <= row_index {
            if col_index == 0 || col_index == row_index {
                // First and last elements are always 1
                current_row.append(1);
            } else {
                // Middle elements are sum of two elements above from previous row
                let prev_row = result.at(row_index - 1);
                let left_value = *prev_row.at(col_index - 1);
                let right_value = *prev_row.at(col_index);
                current_row.append(left_value + right_value);
            }
            col_index += 1;
        };
        
        result.append(current_row);
        row_index += 1;
    };
    
    result
}
  