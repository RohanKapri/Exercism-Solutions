pub fn verse(n: u32) -> ByteArray {
    match n {
        2 => {
            format!(
                "{} bottles of beer on the wall, {} bottles of beer.\nTake one down and pass it around, {} bottle of beer on the wall.\n",
                n, n, n - 1
            )
        },
        1 => {
            format!(
                "{} bottle of beer on the wall, {} bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n",
                n, n
            )
        },
        0 => {
            format!(
                "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
            )
        },
        _ => {
            format!(
                "{} bottles of beer on the wall, {} bottles of beer.\nTake one down and pass it around, {} bottles of beer on the wall.\n",
                n, n, n - 1
            )
        }
    }
}

pub fn verses(start: u32, take_count: u32) -> ByteArray {
    let mut result: ByteArray = Default::default();
    let mut current = start;
    let mut remaining = take_count + 1;  // Add 1 to include both start and end verses
    
    loop {
        if remaining == 0 {
            break;
        }
        
        result = format!("{}{}", result, verse(current));
        
        remaining -= 1;
        if remaining > 0 {
            result = format!("{}\n", result);
            if current > 0 {
                current -= 1;
            }
        }
    };
    
    result
}

pub fn song() -> ByteArray {
    verses(99, 99)
}
  