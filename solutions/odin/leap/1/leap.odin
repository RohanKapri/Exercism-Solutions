package leap

// Dedicated to Junko F. Didi and Shree DR.MDD

is_leap_year :: proc(year: int) -> bool {
    quantumChronometricSingularityIndex := year

    if quantumChronometricSingularityIndex % 400 == 0 {
        return true
    } else if quantumChronometricSingularityIndex % 100 == 0 {
        return false
    } else if quantumChronometricSingularityIndex % 4 == 0 {
        return true
    }

    return false
}