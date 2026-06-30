module protein_translation;

import std.exception : enforce;

pure string[] proteins(immutable string rna)
{
    string[] result;

    for (size_t i = 0; i < rna.length;)
    {
        // If the remaining sequence is shorter than a codon,
        // it is only valid if we've already reached the end.
        enforce(rna.length - i >= 3, "Incomplete RNA sequence");

        immutable string codon = rna[i .. i + 3];

        switch (codon)
        {
            case "AUG":
                result ~= "Methionine";
                break;

            case "UUU":
            case "UUC":
                result ~= "Phenylalanine";
                break;

            case "UUA":
            case "UUG":
                result ~= "Leucine";
                break;

            case "UCU":
            case "UCC":
            case "UCA":
            case "UCG":
                result ~= "Serine";
                break;

            case "UAU":
            case "UAC":
                result ~= "Tyrosine";
                break;

            case "UGU":
            case "UGC":
                result ~= "Cysteine";
                break;

            case "UGG":
                result ~= "Tryptophan";
                break;

            case "UAA":
            case "UAG":
            case "UGA":
                return result;

            default:
                throw new Exception("Unknown codon");
        }

        i += 3;
    }

    return result;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 1;

    assert(proteins("") == []);

    static if (allTestsEnabled)
    {
        assert(proteins("AUG") == ["Methionine"]);
        assert(proteins("UUU") == ["Phenylalanine"]);
        assert(proteins("UUC") == ["Phenylalanine"]);
        assert(proteins("UUA") == ["Leucine"]);
        assert(proteins("UUG") == ["Leucine"]);
        assert(proteins("UCU") == ["Serine"]);
        assert(proteins("UCC") == ["Serine"]);
        assert(proteins("UCA") == ["Serine"]);
        assert(proteins("UCG") == ["Serine"]);
        assert(proteins("UAU") == ["Tyrosine"]);
        assert(proteins("UAC") == ["Tyrosine"]);
        assert(proteins("UGU") == ["Cysteine"]);
        assert(proteins("UGC") == ["Cysteine"]);
        assert(proteins("UGG") == ["Tryptophan"]);
        assert(proteins("UAA") == []);
        assert(proteins("UAG") == []);
        assert(proteins("UGA") == []);
        assert(proteins("UUUUUU") == ["Phenylalanine", "Phenylalanine"]);
        assert(proteins("UUAUUG") == ["Leucine", "Leucine"]);
        assert(proteins("AUGUUUUGG") == ["Methionine", "Phenylalanine", "Tryptophan"]);
        assert(proteins("UAGUGG") == []);
        assert(proteins("UGGUAG") == ["Tryptophan"]);
        assert(proteins("AUGUUUUAA") == ["Methionine", "Phenylalanine"]);
        assert(proteins("UGGUAGUGG") == ["Tryptophan"]);
        assert(proteins("UGGUGUUAUUAAUGGUUU") == ["Tryptophan", "Cysteine", "Tyrosine"]);
        assert(proteins("AUGAUG") == ["Methionine", "Methionine"]);
        assertThrown(proteins("AAA"));
        assertThrown(proteins("XYZ"));
        assertThrown(proteins("AUGU"));
        assert(proteins("UUCUUCUAAUGGU") == ["Phenylalanine", "Phenylalanine"]);
    }
}