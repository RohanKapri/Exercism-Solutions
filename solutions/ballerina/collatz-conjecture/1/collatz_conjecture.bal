# Returns the number of steps required to reach 1.
#
# + n - number
# + return - number of steps
function collatzSteps(int n) returns int|error {
    if (n <= 0) {
        return error("Only positive integers are allowed");
    }

    int steps = 0;
    int num = n;

    while (num > 1) {
        if (num % 2 == 0) {
            num = num / 2;
        } else {
            num = num * 3 + 1;
        }
        steps += 1;
    }

    return steps;
}