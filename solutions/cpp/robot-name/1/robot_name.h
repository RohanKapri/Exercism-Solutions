#ifndef ROBOT_NAME_H
#define ROBOT_NAME_H
#include <set>
#include <string>
namespace robot_name {
  using namespace std;
  class robot {
   public:
    robot();
    auto name() const -> string;
    auto reset() -> void;
   private:
    string _name;
    static set<string> _names;
  };
}
#endif
