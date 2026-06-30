const std = @import("std");
const mem = std.mem;

pub const Nationality = enum {
    englishman,
    japanese,
    norwegian,
    spaniard,
    ukrainian,
};

pub const Color = enum {
    blue,
    green,
    ivory,
    red,
    yellow,
};

pub const Drink = enum {
    coffee,
    milk,
    orange_juice,
    tea,
    water,
};

pub const Hobby = enum {
    reading,
    painting,
    football,
    dancing,
    chess,
};

pub const Pet = enum {
    dog,
    fox,
    horse,
    snails,
    zebra,
};

pub const Solution = struct {
    drinks_water: Nationality,
    owns_zebra: Nationality,
};

fn nextPermutation(a: *[5]u3) bool {
    const n = a.len;

    // Step 1. find j
    var j = n - 2;
    while (a[j] >= a[j + 1]) : (j -= 1) {
        if (j == 0) {
            return false;
        }
    }

    // Step 2. increase a[j]
    var l = n - 1;
    while (a[j] >= a[l]) : (l -= 1) {}

    {
        const aj = a[j];
        const al = a[l];
        a[j] = al;
        a[l] = aj;
    }

    // Step 3. reverse a[j+1] ... a[n-1]
    var k = j + 1;
    l = n - 1;
    while (k < l) : ({
        k += 1;
        l -= 1;
    }) {
        const ak = a[k];
        const al = a[l];
        a[k] = al;
        a[l] = ak;
    }

    return true;
}

fn adjacent(i: u3, j: u3) bool {
    return i + 1 == j or j + 1 == i;
}

pub fn solve(_: mem.Allocator) mem.Allocator.Error!Solution {
    var nationalities = [_]u3{ 1, 2, 3, 4, 5 };
    while (true) : ({
        if (!nextPermutation(&nationalities)) {
            break;
        }
    }) {
        const englishman = nationalities[@intFromEnum(Nationality.englishman)];
        const japanese = nationalities[@intFromEnum(Nationality.japanese)];
        const norwegian = nationalities[@intFromEnum(Nationality.norwegian)];
        const spaniard = nationalities[@intFromEnum(Nationality.spaniard)];
        const ukrainian = nationalities[@intFromEnum(Nationality.ukrainian)];

        // 10. The Norwegian lives in the first house.
        if (norwegian != 1) {
            continue;
        }

        var colors = [_]u3{ 1, 2, 3, 4, 5 };
        while (true) : ({
            if (!nextPermutation(&colors)) {
                break;
            }
        }) {
            const blue = colors[@intFromEnum(Color.blue)];
            const green = colors[@intFromEnum(Color.green)];
            const ivory = colors[@intFromEnum(Color.ivory)];
            const red = colors[@intFromEnum(Color.red)];
            const yellow = colors[@intFromEnum(Color.yellow)];

            // 2. The Englishman lives in the red house.
            // 6. The green house is immediately to the right of the ivory house.
            // 15. The Norwegian lives next to the blue house.
            if (englishman != red or green != ivory + 1 or !adjacent(norwegian, blue)) {
                continue;
            }

            var drinks = [_]u3{ 1, 2, 3, 4, 5 };
            while (true) : ({
                if (!nextPermutation(&drinks)) {
                    break;
                }
            }) {
                const coffee = drinks[@intFromEnum(Drink.coffee)];
                const milk = drinks[@intFromEnum(Drink.milk)];
                const orange_juice = drinks[@intFromEnum(Drink.orange_juice)];
                const tea = drinks[@intFromEnum(Drink.tea)];
                const water = drinks[@intFromEnum(Drink.water)];

                // 4. Coffee is drunk in the green house.
                // 5. The Ukrainian drinks tea.
                // 9. Milk is drunk in the middle house.
                if (coffee != green or ukrainian != tea or milk != 3) {
                    continue;
                }

                var hobbies = [_]u3{ 1, 2, 3, 4, 5 };
                while (true) : ({
                    if (!nextPermutation(&hobbies)) {
                        break;
                    }
                }) {
                    const reading = hobbies[@intFromEnum(Hobby.reading)];
                    const painting = hobbies[@intFromEnum(Hobby.painting)];
                    const football = hobbies[@intFromEnum(Hobby.football)];
                    const dancing = hobbies[@intFromEnum(Hobby.dancing)];
                    const chess = hobbies[@intFromEnum(Hobby.chess)];

                    // 8. The person in the yellow house is a painter.
                    // 13. The person who plays football drinks orange juice.
                    // 14. The Japanese person plays chess.
                    if (painting != yellow or football != orange_juice or japanese != chess) {
                        continue;
                    }

                    var pets = [_]u3{ 1, 2, 3, 4, 5 };
                    while (true) : ({
                        if (!nextPermutation(&pets)) {
                            break;
                        }
                    }) {
                        const dog = pets[@intFromEnum(Pet.dog)];
                        const fox = pets[@intFromEnum(Pet.fox)];
                        const horse = pets[@intFromEnum(Pet.horse)];
                        const snails = pets[@intFromEnum(Pet.snails)];
                        const zebra = pets[@intFromEnum(Pet.zebra)];

                        // 3. The Spaniard owns the dog.
                        // 7. The snail owner likes to go dancing.
                        // 11. The person who enjoys reading lives in the house next to the person with the fox.
                        // 12. The painter's house is next to the house with the horse.
                        if (spaniard != dog or dancing != snails or !adjacent(reading, fox) or !adjacent(painting, horse)) {
                            continue;
                        }

                        const drinks_water = if (water == englishman)
                            Nationality.englishman
                        else if (water == japanese)
                            Nationality.japanese
                        else if (water == norwegian)
                            Nationality.norwegian
                        else if (water == spaniard)
                            Nationality.spaniard
                        else if (water == ukrainian)
                            Nationality.ukrainian
                        else
                            unreachable;

                        const owns_zebra = if (zebra == englishman)
                            Nationality.englishman
                        else if (zebra == japanese)
                            Nationality.japanese
                        else if (zebra == norwegian)
                            Nationality.norwegian
                        else if (zebra == spaniard)
                            Nationality.spaniard
                        else if (zebra == ukrainian)
                            Nationality.ukrainian
                        else
                            unreachable;

                        return Solution{
                            .drinks_water = drinks_water,
                            .owns_zebra = owns_zebra,
                        };
                    }
                }
            }
        }
    }

    unreachable;
}