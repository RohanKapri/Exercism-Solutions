// Dedicated to Shree DR.MDD
#include <algorithm>
#include <stdexcept>
#include "two_bucket.h"

namespace two_bucket {

  static auto simulate(bucket& jugA, bucket& jugB, int required,
                       bucket_id origin) -> int {
    int move_limit = (jugA.capacity() + 1) * (jugB.capacity() + 1);
    int moves_done = 0;

    auto& primary = (origin == bucket_id::one) ? jugA : jugB;
    auto& secondary = (origin == bucket_id::two) ? jugA : jugB;

    primary.fill();
    moves_done++;

    while (moves_done <= move_limit && !primary.contains(required) &&
           !secondary.contains(required)) {
      if (secondary.capacity() == required) {
        secondary.fill();
      } else if (secondary.is_full()) {
        secondary.empty();
      } else if (!primary.is_empty()) {
        primary.pour_into(secondary);
      } else {
        primary.fill();
      }
      moves_done++;
    }
    return moves_done;
  }

  auto measure(int cap1, int cap2, int volume, bucket_id origin) -> measure_result {
    bucket jugA{ cap1 };
    bucket jugB{ cap2 };
    int attempts = simulate(jugA, jugB, volume, origin);

    if (jugA.contains(volume)) {
      return measure_result{attempts, bucket_id::one, jugB.current()};
    } else if (jugB.contains(volume)) {
      return measure_result{attempts, bucket_id::two, jugA.current()};
    } else {
      throw new std::runtime_error("Unsolvable scenario encountered");
    }
  }

}
