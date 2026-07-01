#ifndef CLOCK_H
#define CLOCK_H
#include <string>
namespace date_independent {
  using namespace std;
  class clock {
   public:
    static auto at(int hour, int minute) -> clock;
    auto plus(int minutes) -> clock;
    operator string() const;
    bool operator==(const clock& other) const;
    bool operator!=(const clock& other) const;
   private:
    clock(int minute);
    int _minutes;
  };
}
#endif
