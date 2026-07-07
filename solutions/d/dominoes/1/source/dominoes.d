module dominoes;

struct Stone {
    int left;
    int right;
}

private pure size_t maxPip(immutable Stone[] dominoes)
{
    int maxVal = 0;
    foreach (immutable stone; dominoes)
    {
        if (stone.left > maxVal)
            maxVal = stone.left;
        if (stone.right > maxVal)
            maxVal = stone.right;
    }
    return cast(size_t) maxVal;
}

private pure bool canChainStack(immutable Stone[] dominoes, size_t vertexCount)
{
    int[64] degree;
    foreach (immutable stone; dominoes)
    {
        degree[stone.left]++;
        degree[stone.right]++;
    }

    foreach (size_t vertex; 0 .. vertexCount)
        if (degree[vertex] & 1)
            return false;

    bool[64] visited;
    int[64] stack;
    size_t stackLen = 1;
    stack[0] = dominoes[0].left;
    visited[cast(size_t) dominoes[0].left] = true;

    while (stackLen > 0)
    {
        immutable int vertex = stack[--stackLen];
        foreach (immutable stone; dominoes)
        {
            if (stone.left == vertex)
            {
                if (!visited[cast(size_t) stone.right])
                {
                    visited[cast(size_t) stone.right] = true;
                    stack[stackLen++] = stone.right;
                }
            }
            else if (stone.right == vertex)
            {
                if (!visited[cast(size_t) stone.left])
                {
                    visited[cast(size_t) stone.left] = true;
                    stack[stackLen++] = stone.left;
                }
            }
        }
    }

    foreach (size_t vertex; 0 .. vertexCount)
        if (degree[vertex] > 0 && !visited[vertex])
            return false;

    return true;
}

private pure bool canChainHeap(immutable Stone[] dominoes, size_t vertexCount)
{
    int[] degree = new int[vertexCount];
    foreach (immutable stone; dominoes)
    {
        degree[stone.left]++;
        degree[stone.right]++;
    }

    foreach (immutable count; degree)
        if (count & 1)
            return false;

    bool[] visited = new bool[vertexCount];
    int[] stack = new int[vertexCount];
    size_t stackLen = 1;
    stack[0] = dominoes[0].left;
    visited[cast(size_t) dominoes[0].left] = true;

    while (stackLen > 0)
    {
        immutable int vertex = stack[--stackLen];
        foreach (immutable stone; dominoes)
        {
            if (stone.left == vertex)
            {
                if (!visited[cast(size_t) stone.right])
                {
                    visited[cast(size_t) stone.right] = true;
                    stack[stackLen++] = stone.right;
                }
            }
            else if (stone.right == vertex)
            {
                if (!visited[cast(size_t) stone.left])
                {
                    visited[cast(size_t) stone.left] = true;
                    stack[stackLen++] = stone.left;
                }
            }
        }
    }

    foreach (size_t vertex; 0 .. vertexCount)
        if (degree[vertex] > 0 && !visited[vertex])
            return false;

    return true;
}

/// A closed chain exists iff every pip has even degree and all pips are connected.
pure bool canChain(immutable Stone[] dominoes)
{
    if (dominoes.length == 0)
        return true;
    if (dominoes.length == 1)
        return dominoes[0].left == dominoes[0].right;

    immutable size_t vertexCount = maxPip(dominoes) + 1;

    if (vertexCount > 64)
        return canChainHeap(dominoes, vertexCount);

    return canChainStack(dominoes, vertexCount);
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Empty input = empty output
    {
        immutable Stone[] dominoes;
        assert(canChain(dominoes));
    }

    static if (allTestsEnabled)
    {
        // Singleton input = singleton output
        {
            immutable Stone[] dominoes = [Stone(1, 1)];
            assert(canChain(dominoes));
        }

        // Singleton that can't be chained
        {
            immutable Stone[] dominoes = [Stone(1, 2)];
            assert(!canChain(dominoes));
        }

        // Three elements
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(3, 1), Stone(2, 3)];
            assert(canChain(dominoes));
        }

        // Can reverse dominoes
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(1, 3), Stone(2, 3)];
            assert(canChain(dominoes));
        }

        // Can't be chained
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(4, 1), Stone(2, 3)];
            assert(!canChain(dominoes));
        }

        // Disconnected - simple
        {
            immutable Stone[] dominoes = [Stone(1, 1), Stone(2, 2)];
            assert(!canChain(dominoes));
        }

        // Disconnected - double loop
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(2, 1), Stone(3, 4), Stone(4, 3)];
            assert(!canChain(dominoes));
        }

        // Disconnected - single isolated
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(2, 3), Stone(3, 1), Stone(4, 4)];
            assert(!canChain(dominoes));
        }

        // Need backtrack
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(2, 3), Stone(3, 1), Stone(2, 4), Stone(2, 4)];
            assert(canChain(dominoes));
        }

        // Separate loops
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(2, 3), Stone(3, 1), Stone(1, 1), Stone(2, 2), Stone(3, 3)];
            assert(canChain(dominoes));
        }

        // Nine elements
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(5, 3), Stone(3, 1), Stone(1, 2), Stone(2, 4), Stone(1, 6), Stone(2, 3), Stone(3, 4), Stone(5, 6)];
            assert(canChain(dominoes));
        }

        // Separate three-domino loops
        {
            immutable Stone[] dominoes = [Stone(1, 2), Stone(2, 3), Stone(3, 1), Stone(4, 5), Stone(5, 6), Stone(6, 4)];
            assert(!canChain(dominoes));
        }
    }
}
      