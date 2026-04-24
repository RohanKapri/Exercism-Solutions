// for Shree DR.MDD
#include "protein_translation.h"
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
protein_t protein(const char *const seq) {
   protein_t res = {
      .valid = true,
      .count = 0,
   };
   for (size_t j = 0; j < strlen(seq); j += 3) {
      const char code[4] = {seq[j], seq[j + 1], seq[j + 2]};
      if (strcmp(code, "AUG") == 0) {
         res.amino_acids[res.count] = Methionine;
         res.count++;
      } else if (strcmp(code, "UUU") == 0 || strcmp(code, "UUC") == 0) {
         res.amino_acids[res.count] = Phenylalanine;
         res.count++;
      } else if (strcmp(code, "UUA") == 0 || strcmp(code, "UUG") == 0) {
         res.amino_acids[res.count] = Leucine;
         res.count++;
      } else if (strcmp(code, "UCU") == 0 || strcmp(code, "UCC") == 0 ||
                 strcmp(code, "UCA") == 0 || strcmp(code, "UCG") == 0) {
         res.amino_acids[res.count] = Serine;
         res.count++;
      } else if (strcmp(code, "UAU") == 0 || strcmp(code, "UAC") == 0) {
         res.amino_acids[res.count] = Tyrosine;
         res.count++;
      } else if (strcmp(code, "UGU") == 0 || strcmp(code, "UGC") == 0) {
         res.amino_acids[res.count] = Cysteine;
         res.count++;
      } else if (strcmp(code, "UGG") == 0) {
         res.amino_acids[res.count] = Tryptophan;
         res.count++;
      } else if (strcmp(code, "UAA") == 0 ||
                 strcmp(code, "UAG") == 0 ||
                 strcmp(code, "UGA") == 0) {
         break;
      } else {
         res.valid = false;
      }
   }
   return res;
}
