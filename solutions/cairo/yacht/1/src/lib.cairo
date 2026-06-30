const FOUR_OF_A_KIND_COUNT: u8 = 4;
const YACHT_COUNT: u8 = 5;
const STRAIGHT_SCORE: u8 = 30;
const YACHT_SCORE: u8 = 50;

#[derive(Drop)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

/// Counter struct to track dice face occurrences
#[derive(Copy, Default, Drop, PartialEq)]
struct DiceCounter {
    ones: u8,
    twos: u8,
    threes: u8,
    fours: u8,
    fives: u8,
    sixes: u8,
}

/// Main scoring function for the Yacht game
pub fn score(dice: [u8; 5], category: Category) -> u8 {
    let dice_span = dice.span();
    let counter = count_dice_occurrences(dice_span);
    
    match category {
        Category::Ones => score_single_face(counter.ones, 1),
        Category::Twos => score_single_face(counter.twos, 2),
        Category::Threes => score_single_face(counter.threes, 3),
        Category::Fours => score_single_face(counter.fours, 4),
        Category::Fives => score_single_face(counter.fives, 5),
        Category::Sixes => score_single_face(counter.sixes, 6),
        Category::FullHouse => score_full_house(counter, dice_span),
        Category::FourOfAKind => score_four_of_a_kind(counter),
        Category::LittleStraight => score_little_straight(counter),
        Category::BigStraight => score_big_straight(counter),
        Category::Choice => sum_dice(dice_span),
        Category::Yacht => score_yacht(counter),
    }
}

/// Score single number categories (Ones through Sixes)
fn score_single_face(count: u8, face_value: u8) -> u8 {
    count * face_value
}

/// Score Full House: three of one kind and two of another
fn score_full_house(counter: DiceCounter, dice: Span<u8>) -> u8 {
    if has_exactly_n_of_a_kind(counter, 3) && has_exactly_n_of_a_kind(counter, 2) {
        sum_dice(dice)
    } else {
        0
    }
}

/// Score Four of a Kind: at least four dice showing the same face
fn score_four_of_a_kind(counter: DiceCounter) -> u8 {
    match get_face_with_count_or_more(counter, FOUR_OF_A_KIND_COUNT) {
        Option::Some(face) => face * FOUR_OF_A_KIND_COUNT,
        Option::None => 0,
    }
}

/// Score Little Straight: 1-2-3-4-5
fn score_little_straight(counter: DiceCounter) -> u8 {
    let expected = DiceCounter { ones: 1, twos: 1, threes: 1, fours: 1, fives: 1, sixes: 0 };
    if counter == expected { STRAIGHT_SCORE } else { 0 }
}

/// Score Big Straight: 2-3-4-5-6
fn score_big_straight(counter: DiceCounter) -> u8 {
    let expected = DiceCounter { ones: 0, twos: 1, threes: 1, fours: 1, fives: 1, sixes: 1 };
    if counter == expected { STRAIGHT_SCORE } else { 0 }
}

/// Score Yacht: all five dice showing the same face
fn score_yacht(counter: DiceCounter) -> u8 {
    if has_exactly_n_of_a_kind(counter, YACHT_COUNT) { YACHT_SCORE } else { 0 }
}

/// Check if there's exactly n dice of the same face
fn has_exactly_n_of_a_kind(counter: DiceCounter, n: u8) -> bool {
    counter.ones == n
        || counter.twos == n
        || counter.threes == n
        || counter.fours == n
        || counter.fives == n
        || counter.sixes == n
}

/// Get the face value that appears n or more times, if any
fn get_face_with_count_or_more(counter: DiceCounter, n: u8) -> Option<u8> {
    if counter.ones >= n { Option::Some(1) }
    else if counter.twos >= n { Option::Some(2) }
    else if counter.threes >= n { Option::Some(3) }
    else if counter.fours >= n { Option::Some(4) }
    else if counter.fives >= n { Option::Some(5) }
    else if counter.sixes >= n { Option::Some(6) }
    else { Option::None }
}

/// Count occurrences of each dice face
fn count_dice_occurrences(dice: Span<u8>) -> DiceCounter {
    let mut counter: DiceCounter = Default::default();
    
    for die_value in dice {
        // Subtract 1 from the die value to match array indices (0-5 instead of 1-6)
        match *die_value - 1 {
            0 => counter.ones += 1,
            1 => counter.twos += 1,
            2 => counter.threes += 1,
            3 => counter.fours += 1,
            4 => counter.fives += 1,
            5 => counter.sixes += 1,
            _ => {},
        }
    };
    
    counter
}

/// Sum all dice values
fn sum_dice(dice: Span<u8>) -> u8 {
    let mut total = 0;
    for die_value in dice {
        total += *die_value;
    };
    total
}
  