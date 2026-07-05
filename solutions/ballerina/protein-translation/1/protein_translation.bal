map<string> translations = {
    "AUG": "Methionine",
    "UUU": "Phenylalanine",
    "UUC": "Phenylalanine",
    "UUA": "Leucine",
    "UUG": "Leucine",
    "UCU": "Serine",
    "UCC": "Serine",
    "UCA": "Serine",
    "UCG": "Serine",
    "UAU": "Tyrosine",
    "UAC": "Tyrosine",
    "UGU": "Cysteine",
    "UGC": "Cysteine",
    "UGG": "Tryptophan",
    "UAA": "STOP",
    "UAG": "STOP",
    "UGA": "STOP"
};

public function proteins(string strand) returns string[]|error {
    if strand.length() == 0 {
        return [];
    }
    
    int strand_len = strand.length();
    
    if strand_len < 3 {
        return error("Invalid codon");
    }
    
    string[] result = [];
    
    foreach int i in int:range(0, strand_len, 3) {
        if strand_len - i < 3 {
            return error("Invalid codon");
        }
        
        string code = strand.substring(i, i + 3);
        string? tra = translations[code];
        
        if tra is string {
            if tra == "STOP" { break; }
            result.push(tra);
        } else {
            return error("Invalid codon");
        }
    }
    return result;
}