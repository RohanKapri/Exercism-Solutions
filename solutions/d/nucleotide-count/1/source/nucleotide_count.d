module nucleotide_count;

class Counter
{
    private immutable string dna;

    this(string strand)
    {
        foreach (c; strand)
        {
            if (c != 'A' && c != 'C' && c != 'G' && c != 'T')
                throw new Exception("Invalid nucleotide");
        }

        dna = strand;
    }

    ulong[char] nucleotideCounts() const
    {
        ulong[char] counts = ['A': 0, 'C': 0, 'G': 0, 'T': 0];

        foreach (c; dna)
            ++counts[c];

        return counts;
    }
}