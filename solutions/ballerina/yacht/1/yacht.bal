import ballerina/lang.array;

const int YACHT_SCORE = 50;
const int STRAIGHT_SCORE = 30;

map<int> yacht_category = {
    "yacht": 0, "ones": 1, "twos": 2, "threes": 3, "fours": 4, "fives": 5, "sixes": 6,
    "full house": 7, "little straight": 8, "big straight": 9,
    "four of a kind": 10, "choice": 11
};

public function score(int[] dice, string category) returns int {
    int[] sorted_dice = array:sort(dice);
    int res = 0;
    int? cat = yacht_category[category];

    if (cat is int) {
        match cat {
            0 => { res = is_yacht(dice) ? YACHT_SCORE : 0; }
            1|2|3|4|5|6 => { res = sum_of_same_number(dice, cat); }
            7 => { res = is_full_house(sorted_dice) ? int:sum(0, ...dice) : 0; }
            8 => { res = sorted_dice == [1,2,3,4,5] ? STRAIGHT_SCORE : 0; }
            9 => { res = sorted_dice == [2,3,4,5,6] ? STRAIGHT_SCORE : 0; }
            10 => { res = is_four_of_kind(sorted_dice) ? sum_of_four(sorted_dice) : 0; }
            11 => { res = int:sum(0, ...dice); }
        }
    }
   
    return res;
}

function is_yacht(int[] dice) returns boolean {
    return 1 == (map from int d in dice select [d.toString(), 0] on conflict()).length();
}

function is_full_house(int[] dice) returns boolean {
    return !is_yacht(dice) && (
        (dice[0] == dice[2] && dice[3] == dice[4]) 
        || (dice[0] == dice[1] && dice[2] == dice[4])
    );
}

function is_four_of_kind(int[] dice) returns boolean {
    return dice[0] == dice[3] || dice[1] == dice[4];
}

function sum_of_four(int[] dice) returns int {
    return int:sum(0, ...(dice[0] == dice[1] ?
        dice.slice(0, 4) :
        dice.slice(1, 5)
    ));
}

function sum_of_same_number(int[] dice, int number) returns int {
    return number * dice.filter(x => x == number).length();
}