#ifndef TWO_BUCKET_H
#define TWO_BUCKET_H
#include <algorithm>
namespace two_bucket{
  enum class bucket_id {one, two};
  struct measure_result {
    int num_moves;
    bucket_id goal_bucket;
    int other_bucket_volume;
  };
  auto measure(int bucket1_capacity, int bucket2_capacity, int target_volume,
               bucket_id start_bucket) -> measure_result;
class bucket {
  public:
    bucket(int capacity) : _capacity(capacity), _current(0) {}
    auto capacity() const -> int {return _capacity;}
    auto current() const -> int {return _current;}
    auto is_empty() const -> bool{return _current == 0;}
    auto is_full() const -> bool {return _current == _capacity;}
    auto contains(int amount) const -> bool {return _current == amount;}
    auto empty() -> void {_current = 0;}
    auto fill() -> void {_current = _capacity;}
    auto pour_into(bucket& other) -> void {
      int amount = std::min(_current, other.capacity() - other.current());
      _current -= amount;
      other._current += amount;}
   private:
    int _capacity;
    int _current;
};
}
#endif
