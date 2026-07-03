enum NucleotideCountErrors: Error {
    case invalidNucleotide
}

struct DNA {
    private let nucleotideCounts: [String: Int]

    init(strand: String) throws {
        guard DNA.isValid(strand: strand) else {
            throw NucleotideCountErrors.invalidNucleotide
        }
        nucleotideCounts = DNA.countNucleotides(in: strand)
    }

    func count(_ nucleotide: String) -> Int? {
        nucleotideCounts[nucleotide]
    }

    func counts() -> [String: Int] {
        nucleotideCounts
    }

    private static func isValid(strand: String) -> Bool {
        strand.allSatisfy { "ACGT".contains($0) }
    }

    private static func countNucleotides(in strand: String) -> [String: Int] {
        strand.reduce(into: ["T": 0, "A": 0, "C": 0, "G": 0]) { counts, nucleotide in
            counts[String(nucleotide)]! += 1
        }
    }
}