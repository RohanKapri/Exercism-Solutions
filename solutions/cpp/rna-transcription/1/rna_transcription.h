#ifndef RNA_TRANSCRIPTION_H
#define RNA_TRANSCRIPTION_H
#include <string>
namespace rna_transcription {
  using namespace std;
  auto to_rna(char base) -> char;
  auto to_rna(const string &dna) -> string;
}
#endif
