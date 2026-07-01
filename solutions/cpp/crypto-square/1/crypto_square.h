#ifndef CRYPTO_SQUARE_H
#define CRYPTO_SQUARE_H
#include <string>
#include <vector>
namespace crypto_square {
  using namespace std;
  class cipher {
   public:
    cipher(string plaintext)
      : _plaintext(plaintext) {
    }
    auto normalize_plain_text() -> string;
    auto plain_text_segments() -> vector<string>;
    auto cipher_text() -> string;
    auto normalized_cipher_text() -> string;
   private:
    string _plaintext;
  };
}
#endif
