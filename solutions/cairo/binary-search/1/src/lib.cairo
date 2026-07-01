pub fn find(search_array: @Array<u32>, value: u32) -> Option<usize> {
    // use the binary search algorithm to find the element '{value}' in the array '{search_array:?}'
    // and return its index, otherwise return Option::None
    
    let len = search_array.len();
    if len == 0 {
        return Option::None;
    }
    
    let mut left: usize = 0;
    let mut right: usize = len - 1;
    
    loop {
        if left > right {
            break Option::None;
        }
        
        let mid = left + (right - left) / 2;
        let mid_value = *search_array.at(mid);
        
        if mid_value == value {
            break Option::Some(mid);
        } else if mid_value < value {
            left = mid + 1;
        } else {
            if mid == 0 {
                break Option::None;
            }
            right = mid - 1;
        }
    }
}
   