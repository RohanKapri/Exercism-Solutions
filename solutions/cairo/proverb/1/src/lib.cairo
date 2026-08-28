pub fn recite(items: @Array<ByteArray>) -> ByteArray {
    let len = items.len();
    
    // Handle empty array
    if len == 0 {
        return "";
    }
    
    // Handle single item
    if len == 1 {
        return format!("And all for the want of a {}.", items.at(0));
    }
    
    let mut result = "";
    
    // Generate the main verses
    let mut i = 0;
    while i < len - 1 {
        let current_item = items.at(i);
        let next_item = items.at(i + 1);
        
        if i > 0 {
            result = format!("{}\n", result);
        }
        
        result = format!("{}For want of a {} the {} was lost.", result, current_item, next_item);
        i += 1;
    };
    
    // Add the final line
    let first_item = items.at(0);
    result = format!("{}\nAnd all for the want of a {}.", result, first_item);
    
    result
}