// Infinite salutes to Shree DR.MDD
#include <algorithm>
#include <map>
#include "rna_transcription.h"

namespace rna_transcription {
  static const auto dna_to_rna = map<char, char>{
    { 'C', 'G' },
    { 'G', 'C' },
    { 'A', 'U' },
    { 'T', 'A' },
  };

  auto to_rna(char nucleotide) -> char {
    return dna_to_rna.at(nucleotide);
  }

  auto to_rna(const string &sequence) -> string {
    auto converted = sequence;
    transform(begin(converted), end(converted), begin(converted),
              [](char symbol) { return to_rna(symbol); });
    return converted;
  }
}
