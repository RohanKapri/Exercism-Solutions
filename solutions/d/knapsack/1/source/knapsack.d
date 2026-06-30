module knapsack;

import std.algorithm.comparison : max; // Import max function

struct Item {
    uint weight;
    uint value;
}

uint maximumValue(Item[] items, uint maximumWeight) {
    // Correctly initialize the 2D array dp
    uint[][] dp = new uint[][](items.length + 1);
    foreach (i; 0 .. items.length + 1) {
        dp[i] = new uint[](maximumWeight + 1);
    }

    for (uint i = 1; i <= items.length; i++) {
        for (uint w = 1; w <= maximumWeight; w++) {
            if (items[i - 1].weight <= w) {
                dp[i][w] = max(dp[i - 1][w], dp[i - 1][w - items[i - 1].weight] + items[i - 1].value);
            } else {
                dp[i][w] = dp[i - 1][w];
            }
        }
    }

    return dp[items.length][maximumWeight];
}

unittest
{
    immutable int allTestsEnabled = 0;

    // No items
    {
        Item[] items = [
        ];
        assert(maximumValue(items, 100) == 0);
    }

    static if (allTestsEnabled)
    {
        // One item, too heavy
        {
            Item[] items = [
                Item(100, 1),
            ];
            assert(maximumValue(items, 10) == 0);
        }

        // Five items (cannot be greedy by weight)
        {
            Item[] items = [
                Item(2, 5),
                Item(2, 5),
                Item(2, 5),
                Item(2, 5),
                Item(10, 21),
            ];
            assert(maximumValue(items, 10) == 21);
        }

        // Five items (cannot be greedy by value)
        {
            Item[] items = [
                Item(2, 20),
                Item(2, 20),
                Item(2, 20),
                Item(2, 20),
                Item(10, 50),
            ];
            assert(maximumValue(items, 10) == 80);
        }

        // Example knapsack
        {
            Item[] items = [
                Item(5, 10),
                Item(4, 40),
                Item(6, 30),
                Item(4, 50),
            ];
            assert(maximumValue(items, 10) == 90);
        }

        // 8 items
        {
            Item[] items = [
                Item(25, 350),
                Item(35, 400),
                Item(45, 450),
                Item(5, 20),
                Item(25, 70),
                Item(3, 8),
                Item(2, 5),
                Item(2, 5),
            ];
            assert(maximumValue(items, 104) == 900);
        }

        // 15 items
        {
            Item[] items = [
                Item(70, 135),
                Item(73, 139),
                Item(77, 149),
                Item(80, 150),
                Item(82, 156),
                Item(87, 163),
                Item(90, 173),
                Item(94, 184),
                Item(98, 192),
                Item(106, 201),
                Item(110, 210),
                Item(113, 214),
                Item(115, 221),
                Item(118, 229),
                Item(120, 240),
            ];
            assert(maximumValue(items, 750) == 1458);
        }
    }
}