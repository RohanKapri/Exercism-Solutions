type IntFilter function (int num) returns boolean;

type IntMapper function (int num) returns int;

type IntAccumulator function (int acc, int el) returns int;

public function append(int[] list1, int[] list2) returns int[] {
    return [...list1, ...list2];
}

public function concatenate(int[][]|int[][][] lists) returns int[]|int[][] {
    if lists is int[][] {
        int[] result = [];
        lists.forEach(function(int[] list) {
            list.forEach(function(int val) {
                result.push(val);
            });
        });
        return result;
    }
    if lists is int[][][] {
        int[][] result = [];
        lists.forEach(function(int[][] list) {
            list.forEach(function(int[] val) {
                result.push(val);
            });
        });
        return result;
    }
    return <int[]>[];
}

public function filter(int[] list, IntFilter fn) returns int[] {
    int[] result = [];
    list.forEach(function(int val) {
        if (fn(val)) {
            result.push(val);
        }
    });
    return result;
}

public function length(int[] list) returns int {
    return list.length();
}

public function myMap(int[] list, IntMapper fn) returns int[] {
    int[] result = [];
    list.forEach(function(int val) {
        result.push(fn(val));
    });
    return result;
}

public function foldl(int[] list, IntAccumulator fn, int initial) returns int {
    int current = initial;
    int n = list.length();
    int i = 0;
    while (i < n) {
        current = fn(current, list[i]);
        i += 1;
    }
    return current;
}

public function foldr(int[] list, IntAccumulator fn, int initial) returns int {
    int current = initial;
    int n = list.length();
    int i = 1;
    while (i <= n) {
        current = fn(current, list[n - i]);
        i += 1;
    }
    return current;
}

public function reverse(int[]|int[][] list) returns int[]|int[][] {
    if list is int[] {
        int[] result = [];
        int n = list.length();
        int i = 1;
        while (i <= n) {
            result.push(list[n - i]);
            i += 1;
        }
        return result;
    }
    if list is int[][] {
        int[][] result = [];
        int n = list.length();
        int i = 1;
        while (i <= n) {
            result.push(list[n - i]);
            i += 1;
        }
        return result;
    }
    return <int[]>[];
}