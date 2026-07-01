#include "leap.h"
bool leap::is_leap_year(uint16_t year) {
  auto div400 = !(year % 400);
  auto div100 = !(year % 100);
  auto div4 = !(year % 4);
  return div4 && (!div100 || div400);
}
