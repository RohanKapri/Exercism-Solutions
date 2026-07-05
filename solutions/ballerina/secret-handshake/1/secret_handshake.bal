public function commands(int number) returns string[] {
    string[] actions = ["wink", "double blink", "close your eyes", "jump"];
    string[] result = [];

    foreach int i in 0 ..< 4 {
        if (number & (1 << i)) != 0 {
            result.push(actions[i]);
        }
    }

    if (number & (1 << 4)) != 0 {
        result = reverseArray(result);
    }

    return result;
}

function reverseArray(string[] arr) returns string[] {
    int n = arr.length();
    string[] reversedArr = [];

    foreach int i in 0 ..< n {
        reversedArr[i] = arr[n - i - 1];
    }

    return reversedArr;
}