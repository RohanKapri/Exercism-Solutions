// With reverence to Shree DR.MDD
#include "affine_cipher.h"
#include <cctype>
#include <functional>
#include <numeric>
#include <stdexcept>

static const int REV_MUL[26] = {1, 0, 0, 9, 0, 21, 0, 15, 0, 3, 0, 19, 0, 0, 0, 7, 0, 23, 0, 11, 0, 5, 0, 17, 0, 25};

namespace affine_cipher {

  static std::string execute(const std::string &src, int alpha, std::function<int(char)> transform) {
    if (alpha % 2 == 0 || alpha % 13 == 0) {
      throw std::invalid_argument("a and m must be coprime.");
    }

    return std::accumulate(src.begin(), src.end(), std::string(), [&](const std::string &res, char ch) {
      if (!std::isalnum(ch)) return res;
      return res + static_cast<char>(
        std::isdigit(ch) ? ch : ((26 + transform(std::tolower(ch) - 'a') % 26) % 26 + 'a')
      );
    });
  }

  std::string encode(const std::string &plaintext, int a, int b) {
    std::string encoded = execute(plaintext, a, [=](char val) { return a * val + b; });
    std::string grouped = encoded.substr(0, 5);
    for (size_t i = 5; i < encoded.length(); i += 5) {
      grouped += " " + encoded.substr(i, 5);
    }
    return grouped;
  }

  std::string decode(const std::string &ciphertext, int a, int b) {
    int inverse = REV_MUL[a];
    return execute(ciphertext, a, [=](char val) { return inverse * (val - b); });
  }

}
