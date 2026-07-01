#ifndef ATBASH_CIPHER_H
#define ATBASH_CIPHER_H
#include <string>
namespace atbash_cipher {
  using namespace std;
  auto encode(string s) -> string;
  auto decode(string s) -> string;
}
#endif
