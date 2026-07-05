public function toRna(string dna) returns string {
    map<string> rna = {"C": "G", "G": "C", "T": "A", "A": "U"};
    string result = "";
    int n = dna.length();

    foreach int i in 0 ..< n {
        string nucleotide = dna.substring(i, i + 1);
        string? rnaNucleotide = rna[nucleotide];

        if (rnaNucleotide is string) {
            result += rnaNucleotide;
        } else {
            return "Invalid DNA nucleotide";
        }
    }

    return result;
}