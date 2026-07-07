// Function to calculate the square of the sum of the first N natural numbers.
pub fn square_of_sum(number: u64) -> u64 {
    let sum = number * (number + 1) / 2;
    sum * sum
}

// Function to calculate the sum of the squares of the first N natural numbers.
pub fn sum_of_squares(number: u64) -> u64 {
    let mut sum = 0;
    let mut i = 1;
    
    while i <= number {
        sum += i * i;
        i += 1;
    };
    
    sum
}

// Function to calculate the difference between the square of the sum and the sum of the squares.
pub fn difference_of_squares(number: u64) -> u64 {
    square_of_sum(number) - sum_of_squares(number)
}