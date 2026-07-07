module series;

int[] digits(string s)
{
    int[] result;

    foreach (c; s)
        result ~= c - '0';

    return result;
}

int[][] slice(string s, int n)
{
    if (s.length == 0 || n <= 0 || n > s.length)
        throw new Exception("invalid slice");

    auto ds = digits(s);
    int[][] result;

    foreach (i; 0 .. ds.length - n + 1)
        result ~= ds[i .. i + n];

    return result;
}