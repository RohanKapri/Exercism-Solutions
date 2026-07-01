#pragma once
#include <string>
namespace rail_fence_cipher {
  auto encode(const std::string& plaintext, int rail_count) -> std::string;
  auto decode(const std::string& ciphertext, int rail_count) -> std::string;
}
