package pangram

is_pangram :: proc(str: string) -> bool {
    // Use a bit mask to track which letters have appeared (a-z).
    mask := 0
    n := len(str)
    i := 0
    for i < n {
        c := str[i]
        // Normalize to lowercase ASCII if uppercase
        if c >= 65 && c <= 90 {
            c = c + 32
        }
        if c >= 97 && c <= 122 {
            idx := c - 97
            mask = mask | (1 << idx)
        }
        i += 1
    }
    // All 26 bits set means we saw every letter a-z
    return mask == 67108863
}