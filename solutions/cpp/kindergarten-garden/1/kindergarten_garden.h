#pragma once
#include <array>
#include <string_view>
namespace kindergarten_garden {
  enum class Plants {
    clover,
    grass,
    radishes,
    violets
  };
  auto plants(const std::string_view garden, const std::string_view student) -> std::array<Plants, 4>;
}
