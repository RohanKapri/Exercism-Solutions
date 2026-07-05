public type Item record {
    int weight;
    int value;
};

public function maximumValue(Item[] items, int maximumWeight) returns int {
    int n = items.length();
    int[][] dp = [];
    foreach int i in 0 ... n {
        int[] row = [];
        foreach int j in 0 ... maximumWeight {
            row.push(0);
        }
        dp.push(row);
    }

    foreach int i in 1 ... n {
        foreach int j in 0 ... maximumWeight {
            if items[i - 1].weight > j {
                dp[i][j] = dp[i - 1][j];
            } else {
                dp[i][j] = int:max(dp[i - 1][j], items[i - 1].value + dp[i - 1][j - items[i - 1].weight]);
            }
        }
    }

    return dp[n][maximumWeight];
}