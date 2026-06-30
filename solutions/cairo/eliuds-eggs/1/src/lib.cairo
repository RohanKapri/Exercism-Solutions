pub fn eggCount(number: u64) -> u64 {
    let mut count = 0_u64;
    let mut n = number;

    while n != 0 {
        // If the least significant bit is 1, increment the count
        count += n & 1;
        // Right shift the number by dividing by 2
        n /= 2;
    };

    count
}