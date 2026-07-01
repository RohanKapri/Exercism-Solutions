#include "two_fer.h"
namespace two_fer
{
  auto two_fer() -> string {
    return "One for you, one for me.";
  }
  auto two_fer(const string& name) -> string {
    return string("One for ") + name + ", one for me.";
  }
}
