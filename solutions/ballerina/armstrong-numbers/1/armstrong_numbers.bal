function intPow(int base, int exponent) returns int {
    int result = 1;
    int count = 0;
    while count < exponent {
        result *= base;
        count += 1;
    }
    return result;
}

public function isArmstrongNumber(int number) returns boolean {
    if number < 0 {
        return false;
    }

    int digits = 0;
    int tempNumber = number;
    if tempNumber == 0 {
        digits = 1;
    } else {
        while tempNumber != 0 {
            digits += 1;
            tempNumber = tempNumber / 10;
        }
    }

    int sum = 0;
    tempNumber = number;
    if tempNumber == 0 {
        sum = 0;
    } else {
        while tempNumber != 0 {
            int digit = tempNumber % 10;
            sum += intPow(digit, digits);
            tempNumber = tempNumber / 10;
        }
    }

    return sum == number;
}