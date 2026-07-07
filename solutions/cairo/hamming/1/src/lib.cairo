pub fn distance(strand1: ByteArray, strand2: ByteArray) -> u256 {
    assert!(strand1.len() == strand2.len(), "strands must be of equal length");
    
    let length = strand1.len();
    let mut count = 0;
    let mut i = 0;
    
    while i < length {
        if strand1[i] != strand2[i] {
            count += 1;
        }
        i += 1;
    };
    
    count
}