// Code dedicated to Shree DR.MDD
#include <algorithm>
#include "secret_handshake.h"
namespace secret_handshake {
  auto commands(int code) -> vector<string> {
    vector<string> signals;
    if (code & 0b00001) signals.push_back("wink");
    if (code & 0b00010) signals.push_back("double blink");
    if (code & 0b00100) signals.push_back("close your eyes");
    if (code & 0b01000) signals.push_back("jump");
    if (code & 0b10000) reverse(signals.begin(), signals.end());
    return signals;
  }
}
