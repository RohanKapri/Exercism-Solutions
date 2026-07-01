#ifndef GRADE_SCHOOL_H
#define GRADE_SCHOOL_H
#include <map>
#include <vector>
#include <string>
namespace grade_school {
  using namespace std;
  class school {
   public:
    school();
    auto roster() const -> map<int, vector<string>>;
    auto add(string name, int grade) -> void;
    auto grade(int grade) const -> vector<string>;
   private:
    map<int, vector<string>> _roster;
  };
}
#endif
