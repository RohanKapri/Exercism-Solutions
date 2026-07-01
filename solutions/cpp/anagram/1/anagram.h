#ifndef ANAGRAM_H
#define ANAGRAM_H
#include <string>
#include <vector>
namespace anagram {
  class anagram {
   public:
    anagram(const std::string& s);
    std::vector<std::string> matches(const std::vector<std::string> &candidates);
   private:
    std::string subject;
  };
}
#endif
