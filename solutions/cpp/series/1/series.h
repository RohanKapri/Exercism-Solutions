#if!defined(SERIES_H)
#define SERIES_H
#include <string>
#include <vector>
namespace series {
  std::vector < std::string > slice(const std::string & digits, unsigned int slice_length);
} // namespace series
#endif // SERIES_H