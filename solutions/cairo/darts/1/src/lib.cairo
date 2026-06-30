// Function to calculate the score based on the dart's position (x, y)
pub fn score(x: i64, y: i64) -> u8 {
    // Calculate the squared distance from the origin
    let distance_squared = x * x + y * y;

    // Determine the score based on the squared distance
    if distance_squared > 100 {
        return 0;
    } else if distance_squared > 25 {
        return 1;
    } else if distance_squared > 1 {
        return 5;
    } else {
        return 10;
    }
}