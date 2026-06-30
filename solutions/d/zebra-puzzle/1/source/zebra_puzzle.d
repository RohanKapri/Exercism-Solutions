module zebra_puzzle;

import std.algorithm.sorting : nextPermutation;

// Enum definitions for various attributes
enum Nationality {
    englishman,
    japanese,
    norwegian,
    spaniard,
    ukranian
}

enum Color {
    blue,
    green,
    ivory,
    red,
    yellow
}

enum Drink {
    coffee,
    milk,
    orangeJuice,
    tea,
    water
}

enum Smoke {
    chesterfields,
    kools,
    luckyStrike,
    oldGold,
    parliaments
}

enum Pet {
    dog,
    fox,
    horse,
    snails,
    zebra
}

// Helper function to determine if two houses are adjacent
int adjacent(int a, int b) {
    return a == b + 1 || a + 1 == b;
}

class ZebraPuzzle {
    this() {
        solvePuzzle();
    }

    Nationality drinksWater() {
        return drinksWater_;
    }

    Nationality ownsZebra() {
        return ownsZebra_;
    }

private:
    Nationality drinksWater_;
    Nationality ownsZebra_;

    void solvePuzzle() {
        // Initial setup of attributes
        int[] nationalities = [0, 1, 2, 3, 4];
        do {
            if (nationalities[Nationality.norwegian] != 0)
                continue; // Constraint 10

            int[] colors = [0, 1, 2, 3, 4];
            do {
                if (nationalities[Nationality.englishman] != colors[Color.red])
                    continue; // Constraint 2
                if (colors[Color.green] != colors[Color.ivory] + 1)
                    continue; // Constraint 6
                if (!adjacent(nationalities[Nationality.norwegian], colors[Color.blue]))
                    continue; // Constraint 15

                int[] drinks = [0, 1, 2, 3, 4];
                do {
                    if (drinks[Drink.coffee] != colors[Color.green])
                        continue; // Constraint 4
                    if (nationalities[Nationality.ukranian] != drinks[Drink.tea])
                        continue; // Constraint 5
                    if (drinks[Drink.milk] != 2)
                        continue; // Constraint 9

                    int[] smokes = [0, 1, 2, 3, 4];
                    do {
                        if (smokes[Smoke.kools] != colors[Color.yellow])
                            continue; // Constraint 8
                        if (smokes[Smoke.luckyStrike] != drinks[Drink.orangeJuice])
                            continue; // Constraint 13
                        if (nationalities[Nationality.japanese] != smokes[Smoke.parliaments])
                            continue; // Constraint 14

                        int[] pets = [0, 1, 2, 3, 4];
                        do {
                            if (nationalities[Nationality.spaniard] != pets[Pet.dog])
                                continue; // Constraint 3
                            if (smokes[Smoke.oldGold] != pets[Pet.snails])
                                continue; // Constraint 7
                            if (!adjacent(smokes[Smoke.chesterfields], pets[Pet.fox]))
                                continue; // Constraint 11
                            if (!adjacent(smokes[Smoke.kools], pets[Pet.horse]))
                                continue; // Constraint 12

                            // Store the results if valid
                            foreach (nationality; [Nationality.englishman,
                                                   Nationality.japanese,
                                                   Nationality.norwegian,
                                                   Nationality.spaniard,
                                                   Nationality.ukranian]) {
                                if (nationalities[nationality] == drinks[Drink.water])
                                    drinksWater_ = nationality;
                                if (nationalities[nationality] == pets[Pet.zebra])
                                    ownsZebra_ = nationality;
                            }
                        } while (nextPermutation(pets));
                    } while (nextPermutation(smokes));
                } while (nextPermutation(drinks));
            } while (nextPermutation(colors));
        } while (nextPermutation(nationalities));
    }
}

unittest
{
    ZebraPuzzle zebraPuzzle = new ZebraPuzzle();
    assert(zebraPuzzle.drinksWater() == Nationality.norwegian);
    assert(zebraPuzzle.ownsZebra() == Nationality.japanese);
}