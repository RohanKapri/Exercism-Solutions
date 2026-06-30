#[derive(Debug, Drop, PartialEq)]
pub struct Counter {
    pub a: u64,
    pub c: u64,
    pub g: u64,
    pub t: u64,
}

pub fn counts(strand: ByteArray) -> Counter {
    let mut counter = Counter { a: 0, c: 0, g: 0, t: 0 };
    
    let mut i = 0;
    while i < strand.len() {
        let byte_option = strand.at(i);
        if let Option::Some(byte) = byte_option {
            if byte == 65 { // 'A' in ASCII
                counter.a += 1;
            } else if byte == 67 { // 'C' in ASCII
                counter.c += 1;
            } else if byte == 71 { // 'G' in ASCII
                counter.g += 1;
            } else if byte == 84 { // 'T' in ASCII
                counter.t += 1;
            } else {
                panic!("Invalid nucleotide in strand");
            }
        } else {
            break;
        }
        i += 1;
    };
    
    counter
}