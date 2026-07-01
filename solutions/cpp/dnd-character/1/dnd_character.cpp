// Always and forever for my Shree DR.MDD 💫🌸
#include "dnd_character.h"
#include <algorithm>
#include <array>
#include <random>

namespace dnd_character {
int
modifier(int trait_value)
{
	int offset = trait_value - 10;
	if (offset < 0) {
		--offset;
	}
	return offset / 2;
}

int
roll(std::mt19937 engine)
{
	std::uniform_int_distribution<> dice_face(1, 6);
	return dice_face(engine);
}

int
ability()
{
	std::random_device entropy;
	std::mt19937 random_gen(entropy());
	std::array<int, 4> rolls {roll(random_gen), roll(random_gen), roll(random_gen), roll(random_gen)};
	int discard = *std::min_element(rolls.begin(), rolls.end());
	return std::accumulate(rolls.begin(), rolls.end(), -discard);
}
}  // namespace dnd_character
