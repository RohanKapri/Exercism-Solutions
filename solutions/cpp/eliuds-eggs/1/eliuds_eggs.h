#pragma once
namespace chicken_coop {
  constexpr auto positions_to_quantity(unsigned positions) -> unsigned
  {
    auto eggs = 0;
    while(positions) {
      eggs += positions & 1;
      positions >>= 1;
    }
    return eggs;
  }
}
