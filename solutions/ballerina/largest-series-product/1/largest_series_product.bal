# Find the largest product of the digits of a substring
#
# + digits - the sequence of digits as a string
# + span - the substring size
# + return - the maximum product, or an error
public function largestProduct(string digits, int span) returns int|error {
    if span < 0 {
        return error("span must not be negative");
    }

    if span > digits.length() {
        return error("span must be smaller than string length");
    }

    if span == 0 {
        return 1;
    }

    int maxProduct = 0;

    foreach int i in 0 ..< digits.length() - span + 1 {
        string subDigits = digits.substring(i, i + span);
        int product = 1;

        foreach int j in 0 ..< subDigits.length() {
            string digitStr = subDigits.substring(j, j + 1);
            var digitValue = int:fromString(digitStr);

            if digitValue is int {
                product *= digitValue;
            } else {
                return error("digits input must only contain digits");
            }
        }

        if product > maxProduct {
            maxProduct = product;
        }
    }
    return maxProduct;
}