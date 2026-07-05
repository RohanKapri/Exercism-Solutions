import ballerina/random;

public function min(int[] arr) returns int {
    int min = arr[0];
    foreach int i in arr {
        if (i < min) {
            min = i;
        }
    }
    return min;
}

public function sum(int[] arr) returns int {
    int sum = 0;
    foreach int i in arr {
        sum += i;
    }
    return sum;
}

public function roll() returns int {
    var result = random:createIntInRange(1, 6);
    if (result is int) {
        return result;
    } else {
        return 1; // default value in case of error
    }
}

public function ability() returns int {
    int[] rolls = [roll(), roll(), roll(), roll()];
    int minVal = min(rolls);
    int sumVal = sum(rolls) - minVal;
    return sumVal;
}

public function modifier(int score) returns int {
    if (score % 2 == 1) {
        return (score - 11) / 2; 
    }
    return (score - 10) / 2;
}

class DndCharacter {
    int strength;
    int dexterity;
    int constitution;
    int intelligence;
    int wisdom;
    int charisma;
    int hitpoints;

    public function init() {
        self.strength = ability();
        self.dexterity = ability();
        self.constitution = ability();
        self.intelligence = ability();
        self.wisdom = ability();
        self.charisma = ability();
        self.hitpoints = 10 + modifier(self.constitution);
    }

    public function getStrength() returns int {
        return self.strength;
    }

    public function getDexterity() returns int {
        return self.dexterity;
    }

    public function getConstitution() returns int {
        return self.constitution;
    }

    public function getIntelligence() returns int {
        return self.intelligence;
    }

    public function getWisdom() returns int {
        return self.wisdom;
    }

    public function getCharisma() returns int {
        return self.charisma;
    }

    public function getHitpoints() returns int {
        return self.hitpoints;
    }
}