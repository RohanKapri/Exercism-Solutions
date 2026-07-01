#ifndef UUID_F97CC345_F6F5_412E_A8BF_D759E494346F
#define UUID_F97CC345_F6F5_412E_A8BF_D759E494346F
#include <array>
#include <cstdint>
#include <string_view>
namespace yacht
{
using dice_t = std::array<std::int8_t, 5>;
/**
 * Determine the number of points for a set of dice in a specific category.
 */
int score(dice_t dice, std::string_view category);
}  // namespace yacht
#endif //UUID_F97CC345_F6F5_412E_A8BF_D759E494346F
