#ifndef SPACE_AGE_H
#define SPACE_AGE_H
namespace space_age {
  class space_age {
   public:
    space_age(long seconds);
    auto seconds() const -> double;
    auto on_mercury() const -> double;
    auto on_venus() const -> double;
    auto on_earth() const -> double;
    auto on_mars() const -> double;
    auto on_jupiter() const -> double;
    auto on_saturn() const -> double;
    auto on_uranus() const -> double;
    auto on_neptune() const -> double;
   private:
    long _seconds;
  };
}
#endif
