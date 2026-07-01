#ifndef AFFINE_CIPHER_H
#define AFFINE_CIPHER_H
#include <string>
namespace affine_cipher {
std::string encode(const std::string &str, int a, int b);
std::string decode(const std::string &str, int a, int b);
}  // namespace affine_cipher
#endif  // AFFINE_CIPHER_H