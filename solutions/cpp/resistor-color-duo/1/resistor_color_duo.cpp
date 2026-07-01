#include "resistor_color_duo.h"
#include <algorithm>
using namespace std;
static auto color_code(string color) -> int
{
  static auto _colors = vector<string>{ "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" };
  return find(_colors.begin(), _colors.end(), color) - _colors.begin();
}
auto resistor_color_duo::value(vector<string> colors) -> int
{
  return color_code(colors[0]) * 10 + color_code(colors[1]);
}
