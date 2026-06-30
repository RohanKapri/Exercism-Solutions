pub fn is_paired(value: ByteArray) -> bool {
    let mut stack: Array<u8> = array![];
    let mut i = 0;
    let mut is_valid = true;
    
    while i < value.len() && is_valid {
        let char = value.at(i).unwrap();
        
        if char == '(' || char == '[' || char == '{' {
            // Opening bracket - push to stack
            stack.append(char);
        } else if char == ')' || char == ']' || char == '}' {
            // Closing bracket - check if it matches the last opening bracket
            if stack.is_empty() {
                is_valid = false; // No matching opening bracket
            } else {
                // Pop from the end of the array (stack behavior - LIFO)
                let stack_len = stack.len();
                let last_opening = *stack[stack_len - 1];
                
                // Remove the last element by creating a new array without it
                let mut new_stack: Array<u8> = array![];
                let mut j = 0;
                while j < stack_len - 1 {
                    new_stack.append(*stack[j]);
                    j += 1;
                };
                stack = new_stack;

                
                // Check if the brackets match
                let is_match = if char == ')' {
                    last_opening == '('
                } else if char == ']' {
                    last_opening == '['
                } else if char == '}' {
                    last_opening == '{'
                } else {
                    false
                };
                
                if !is_match {
                    is_valid = false; // Mismatched brackets
                };
            };
        };
        // Ignore all other characters
        
        i += 1;
    };
    
    // All brackets are paired if stack is empty and no errors occurred
    is_valid && stack.is_empty()
}
   