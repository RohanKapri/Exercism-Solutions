use core::array::ArrayTrait;
use core::option::OptionTrait;
use core::byte_array::ByteArrayTrait;

#[derive(Drop, Debug, PartialEq, Clone)]
pub enum AminoAcid {
    /// Methionine (Met, M) - Start codon AUG
    Methionine,
    /// Phenylalanine (Phe, F) - Codons UUU, UUC
    Phenylalanine,
    /// Leucine (Leu, L) - Codons UUA, UUG
    Leucine,
    /// Serine (Ser, S) - Codons UCU, UCC, UCA, UCG
    Serine,
    /// Tyrosine (Tyr, Y) - Codons UAU, UAC
    Tyrosine,
    /// Cysteine (Cys, C) - Codons UGU, UGC
    Cysteine,
    /// Tryptophan (Trp, W) - Codon UGG
    Tryptophan,
}

// ASCII byte constants for nucleotides
const A: u8 = 65;  // 'A'
const C: u8 = 67;  // 'C'
const G: u8 = 71;  // 'G'
const U: u8 = 85;  // 'U'

pub fn proteins(strand: ByteArray) -> Array<AminoAcid> {
    let mut out: Array<AminoAcid> = ArrayTrait::new();
    let len: usize = strand.len();
    let mut i: usize = 0;
    let mut stopped: bool = false;

    // Process complete codons only (triplets)
    while i + 3 <= len {
        let b1: u8 = strand.at(i).unwrap();
        let b2: u8 = strand.at(i + 1).unwrap();
        let b3: u8 = strand.at(i + 2).unwrap();

        // Check for STOP codons first: UAA, UAG, UGA
        if is_stop_codon_bytes(b1, b2, b3) {
            stopped = true;
            break;
        }

        // Translate recognized codons using helper function
        match translate_codon_bytes(b1, b2, b3) {
            Option::Some(amino_acid) => {
                out.append(amino_acid);
            },
            Option::None => {
                panic!("Invalid codon");
            }
        }

        i += 3;
    };

    // If we didn't stop on a STOP codon and there are leftover bytes, it's invalid
    if !stopped && i != len {
        panic!("Invalid codon");
    }

    out
}

fn is_stop_codon_bytes(b1: u8, b2: u8, b3: u8) -> bool {
    // STOP codons: UAA, UAG, UGA
    (b1 == U && b2 == A && b3 == A) ||
    (b1 == U && b2 == A && b3 == G) ||
    (b1 == U && b2 == G && b3 == A)
}

fn translate_codon_bytes(b1: u8, b2: u8, b3: u8) -> Option<AminoAcid> {
    // Start codon (also codes for Methionine): AUG
    if b1 == A && b2 == U && b3 == G {
        return Option::Some(AminoAcid::Methionine);
    }
    
    // Phenylalanine: UUU, UUC
    if b1 == U && b2 == U && (b3 == U || b3 == C) {
        return Option::Some(AminoAcid::Phenylalanine);
    }
    
    // Leucine: UUA, UUG
    if b1 == U && b2 == U && (b3 == A || b3 == G) {
        return Option::Some(AminoAcid::Leucine);
    }
    
    // Serine: UCU, UCC, UCA, UCG
    if b1 == U && b2 == C && (b3 == U || b3 == C || b3 == A || b3 == G) {
        return Option::Some(AminoAcid::Serine);
    }
    
    // Tyrosine: UAU, UAC
    if b1 == U && b2 == A && (b3 == U || b3 == C) {
        return Option::Some(AminoAcid::Tyrosine);
    }
    
    // Cysteine: UGU, UGC
    if b1 == U && b2 == G && (b3 == U || b3 == C) {
        return Option::Some(AminoAcid::Cysteine);
    }
    
    // Tryptophan: UGG
    if b1 == U && b2 == G && b3 == G {
        return Option::Some(AminoAcid::Tryptophan);
    }
    
    // Unknown codon
    Option::None
}
      