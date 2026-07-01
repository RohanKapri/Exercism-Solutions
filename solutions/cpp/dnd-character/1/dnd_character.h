#pragma once
namespace dnd_character {
int modifier(int score);
int ability();
struct Character {
	int strength = ability();
	int dexterity = ability();
	int constitution = ability();
	int intelligence = ability();
	int wisdom = ability();
	int charisma = ability();
	int hitpoints = 10 + modifier(constitution);
};
}  // namespace dnd_character
