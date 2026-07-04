enum TranslationError: Error {
    case invalidCodon
}

private let translations = [
    "AUG" : "Methionine",
    "UUU" : "Phenylalanine",
    "UUC" : "Phenylalanine",
    "UUA" : "Leucine",
    "UUG" : "Leucine",
    "UCU" : "Serine",
    "UCC" : "Serine",
    "UCA" : "Serine",
    "UCG" : "Serine",
    "UAU" : "Tyrosine",
    "UAC" : "Tyrosine",
    "UGU" : "Cysteine",
    "UGC" : "Cysteine",
    "UGG" : "Tryptophan",
    "UAA" : "STOP",
    "UAG" : "STOP",
    "UGA" : "STOP"
]

private func parseCodons(_ rna: String) -> [String] {
    var codons: [String] = []
    var index = rna.startIndex
    while index < rna.endIndex {
        let end = rna.index(index, offsetBy: 3, limitedBy: rna.endIndex) ?? rna.endIndex
        codons.append(String(rna[index..<end]))
        index = end
    }
    return codons
}

func translationOfRNA(rna: String) throws -> [String] {
    let codons = parseCodons(rna)
    var proteins = [String]()

    for codon in codons {
        guard let protein = translations[codon] else {
            throw TranslationError.invalidCodon
        }

        if protein == "STOP" {
            break
        }

        proteins.append(protein)
    }

    return proteins
}