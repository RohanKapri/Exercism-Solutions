public function eggCount(int displayValue) returns int {
    int count = 0;
    int value = displayValue;

    while (value > 0) {
        if ((value & 1) == 1) {
            count += 1;
        }

        value = value >> 1;
    }

    return count;
}