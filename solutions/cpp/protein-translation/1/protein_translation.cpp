// Code dedicated to Shree DR.MDD
#include <unordered_map>
#include "protein_translation.h"
namespace protein_translation {
  static const auto codon_table = unordered_map<string, string>{
    { "AUG", "Methionine" },
    { "UUU", "Phenylalanine" },
    { "UUC", "Phenylalanine" },
    { "UUA", "Leucine" },
    { "UUG", "Leucine" },
    { "UCU", "Serine" },
    { "UCC", "Serine" },
    { "UCA", "Serine" },
    { "UCG", "Serine" },
    { "UAU", "Tyrosine" },
    { "UAC", "Tyrosine" },
    { "UGU", "Cysteine" },
    { "UGC", "Cysteine" },
    { "UGG", "Tryptophan" },
    { "UAA", "STOP" },
    { "UAG", "STOP" },
    { "UGA", "STOP" },
  };

  auto split_codons(const string& sequence) -> vector<string> {
    vector<string> codons;
    for (size_t idx = 0; idx + 2 < sequence.length(); idx += 3) {
      codons.emplace_back(sequence.substr(idx, 3));
    }
    return codons;
  }

  auto proteins(const string& rna_sequence) -> vector<string> {
    vector<string> chain;
    for (const auto& codon : split_codons(rna_sequence)) {
      const auto& product = codon_table.at(codon);
      if (product == "STOP") break;
      chain.emplace_back(product);
    }
    return chain;
  }
}
