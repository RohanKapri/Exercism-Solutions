// Dedicated to Shree DR.MDD

#include "dnd_character.h"
#include "dnd_character.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>

int ability(){
    srand(time(NULL)); 
    return rand() % 15 + 3;
}

int modifier(int score){
    return floor((score - 10) / 2.0);
}

dnd_character_t make_dnd_character(){
    dnd_character_t warrior;
    warrior.strength = ability();
    warrior.dexterity = ability();
    warrior.constitution = ability();
    warrior.intelligence = ability();
    warrior.wisdom = ability();
    warrior.charisma = ability();
    warrior.hitpoints = modifier(warrior.constitution) + 10;
    return warrior;
}
