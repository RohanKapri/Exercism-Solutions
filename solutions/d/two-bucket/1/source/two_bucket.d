module two_bucket;

import std.typecons;
import std.algorithm : min;
import std.exception : enforce;

alias TwoBucketInput = Tuple!(
    int, "size1",
    int, "size2",
    int, "goal",
    string, "startBucket"
);

alias TwoBucketResult = Tuple!(
    int, "moves",
    string, "goalBucket",
    int, "otherAmount"
);

pure TwoBucketResult measure(TwoBucketInput input)
{
    int[] buckets = [0, 0];
    int[] caps = [input.size1, input.size2];
    int id = input.startBucket == "one" ? 0 : 1;
    int other = id == 0 ? 1 : 0;
    int moves = 0;

    // fill start
    buckets[id] = caps[id];
    moves++;

    // edge case, secondary is the same as target, fill second and end
    if (caps[other] == input.goal)
    {
        buckets[other] = input.goal;
        moves++;
    }
    else
    {
        while (buckets[0] != input.goal && buckets[1] != input.goal)
        {
            // if secondary is full, empty it
            if (buckets[other] == caps[other])
            {
                buckets[other] = 0;
                moves++;
            }
            
            // if primary bucket is empty, refill
            if (buckets[id] == 0)
            {
                buckets[id] = caps[id];
                moves++;
            }
            
            int transfer = min(caps[other] - buckets[other], buckets[id]);
            buckets[id] -= transfer;
            buckets[other] += transfer;
            moves++;

            // Check if it's impossible to reach the goal
            enforce(moves <= 1000, "It's impossible to reach the goal");
        }
    }

    string goalBucket = buckets[0] == input.goal ? "one" : "two";
    int otherAmount = buckets[goalBucket == "one" ? 1 : 0];

    return TwoBucketResult(moves, goalBucket, otherAmount);
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one
    {
        auto result = measure(TwoBucketInput(3, 5, 1, "one"));
        assert(result == TwoBucketResult(4, "one", 5));
    }

    static if (allTestsEnabled)
    {
        // Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two
        {
            auto result = measure(TwoBucketInput(3, 5, 1, "two"));
            assert(result == TwoBucketResult(8, "two", 3));
        }

        // Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one
        {
            auto result = measure(TwoBucketInput(7, 11, 2, "one"));
            assert(result == TwoBucketResult(14, "one", 11));
        }

        // Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two
        {
            auto result = measure(TwoBucketInput(7, 11, 2, "two"));
            assert(result == TwoBucketResult(18, "two", 7));
        }

        // Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two
        {
            auto result = measure(TwoBucketInput(1, 3, 3, "two"));
            assert(result == TwoBucketResult(1, "two", 0));
        }

        // Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two
        {
            auto result = measure(TwoBucketInput(2, 3, 3, "one"));
            assert(result == TwoBucketResult(2, "two", 2));
        }

        // Not possible to reach the goal
        {
            assertThrown(measure(TwoBucketInput(6, 15, 5, "one")));
        }

        // With the same buckets but a different goal, then it is possible
        {
            auto result = measure(TwoBucketInput(6, 15, 9, "one"));
            assert(result == TwoBucketResult(10, "two", 0));
        }

        // Goal larger than both buckets is impossible
        {
            assertThrown(measure(TwoBucketInput(5, 7, 8, "one")));
        }
    }
}