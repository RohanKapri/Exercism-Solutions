module killer_sudoku_helper;

import std.algorithm.sorting : sort;
import std.array : array;

pure ushort[] combinations(int sum, int size, ushort exclude)
{
    ushort[] results;
    
    void findCombinations(int currentSum, int currentSize, ushort currentCombination, int startDigit)
    {
        if (currentSize == size)
        {
            if (currentSum == sum)
            {
                results ~= currentCombination;
            }
            return;
        }
        
        foreach (digit; startDigit .. 10)
        {
            ushort bit = cast(ushort)(1 << (digit - 1)); // bit for digit (1-9)
            // Check if digit is not excluded and not already in combination
            if ((exclude & bit) == 0 && (currentCombination & bit) == 0 && currentSum + digit <= sum)
            {
                findCombinations(currentSum + digit, currentSize + 1, currentCombination | bit, digit + 1);
            }
        }
    }
    
    findCombinations(0, 0, 0, 1);
    return results.sort.array;
}

unittest
{
    import std.algorithm.comparison : equal;

    immutable int allTestsEnabled = 0;

    // Trivial 1-digit cages-1
    {
        ushort[] expected = [1];
        assert(combinations(1, 1, 0) == expected);
    }

    static if (allTestsEnabled)
    {
        // Trivial 1-digit cages-2
        {
            ushort[] expected = [2];
            assert(combinations(2, 1, 0) == expected);
        }

        // Trivial 1-digit cages-3
        {
            ushort[] expected = [4];
            assert(combinations(3, 1, 0) == expected);
        }

        // Trivial 1-digit cages-4
        {
            ushort[] expected = [8];
            assert(combinations(4, 1, 0) == expected);
        }

        // Trivial 1-digit cages-5
        {
            ushort[] expected = [16];
            assert(combinations(5, 1, 0) == expected);
        }

        // Trivial 1-digit cages-6
        {
            ushort[] expected = [32];
            assert(combinations(6, 1, 0) == expected);
        }

        // Trivial 1-digit cages-7
        {
            ushort[] expected = [64];
            assert(combinations(7, 1, 0) == expected);
        }

        // Trivial 1-digit cages-8
        {
            ushort[] expected = [128];
            assert(combinations(8, 1, 0) == expected);
        }

        // Trivial 1-digit cages-9
        {
            ushort[] expected = [256];
            assert(combinations(9, 1, 0) == expected);
        }

        // Cage with sum 45 contains all digits 1:9
        {
            ushort[] expected = [511];
            assert(combinations(45, 9, 0) == expected);
        }

        // Cage with only 1 possible combination
        {
            ushort[] expected = [11];
            assert(combinations(7, 3, 0) == expected);
        }

        // Cage with several combinations
        {
            ushort[] expected = [40, 68, 130, 257];
            assert(combinations(10, 2, 0) == expected);
        }

        // Cage with several combinations that is restricted
        {
            ushort[] expected = [68, 130];
            assert(combinations(10, 2, 9) == expected);
        }
    }
}
            