pub fn commands(number: u8) -> Array<ByteArray> {
    let mut actions = array![];
    
    // Check each bit and add corresponding actions
    if number & 1 != 0 {
        actions.append("wink");
    }
    if number & 2 != 0 {
        actions.append("double blink");
    }
    if number & 4 != 0 {
        actions.append("close your eyes");
    }
    if number & 8 != 0 {
        actions.append("jump");
    }
    
    // Check if we should reverse (bit 4 is set)
    if number & 16 != 0 {
        let mut reversed = array![];
        let mut i = actions.len();
        while i > 0 {
            i -= 1;
            reversed.append(actions[i].clone());
        };
        reversed
    } else {
        actions
    }
}
   