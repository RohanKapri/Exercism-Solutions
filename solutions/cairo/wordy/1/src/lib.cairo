use core::byte_array::ByteArray;
use core::byte_array::ByteArrayTrait;
use core::option::OptionTrait;
use core::traits::Into;

#[derive(Copy, Drop)]
enum Op {
    Add,
    Sub,
    Mul,
    Div,
}

fn is_digit(b: u8) -> bool {
    b >= 48 && b <= 57  // '0'..='9'
}

fn is_ascii_letter(b: u8) -> bool {
    (b >= 97 && b <= 122) || (b >= 65 && b <= 90) // a..z or A..Z
}

fn skip_spaces(q: @ByteArray, mut i: usize) -> usize {
    loop {
        match q.at(i) {
            Option::Some(b) => {
                if b == 32 {  // ' '
                    i = i + 1;
                } else {
                    break i;
                }
            },
            Option::None => { break i; }
        }
    }
}

/// Try to match the literal `lit` at position `i` in `q`.
/// If it matches, returns `Some(new_index)` where `new_index = i + lit.len()`.
/// If it doesn't match (or runs out of input), returns `None`.
fn eat_lit(q: @ByteArray, i: usize, lit: @ByteArray) -> Option<usize> {
    let mut j: usize = 0;
    loop {
        match lit.at(j) {
            Option::Some(bl) => {
                match q.at(i + j) {
                    Option::Some(bq) => {
                        if bq != bl {
                            break Option::None;
                        } else {
                            j = j + 1;
                        }
                    },
                    Option::None => { break Option::None; }
                }
            },
            Option::None => {
                // Reached the end of the literal; full match.
                break Option::Some(i + j);
            },
        }
    }
}

fn parse_number_or_panic(q: @ByteArray, mut i: usize) -> (i32, usize) {
    i = skip_spaces(q, i);

    // Optional leading sign
    let mut sign: i32 = 1;
    match q.at(i) {
        Option::Some(b) => {
            if b == 45 { // '-'
                sign = -1;
                i = i + 1;
            }
        },
        Option::None => {}
    }

    // Require at least one digit
    match q.at(i) {
        Option::Some(b) => {
            if !is_digit(b) {
                panic!("syntax error");
            }
        },
        Option::None => { panic!("syntax error"); }
    }

    // Accumulate digits
    let mut value: i32 = 0;
    loop {
        match q.at(i) {
            Option::Some(b) => {
                if is_digit(b) {
                    let dv: i32 = (b - 48).into(); // '0' -> 0, etc.
                    value = value * 10 + dv;
                    i = i + 1;
                } else {
                    break;
                }
            },
            Option::None => { break; }
        }
    };

    (value * sign, i)
}

fn parse_operator_or_panic(q: @ByteArray, i: usize) -> (Op, usize) {
    let i0 = skip_spaces(q, i);

    match eat_lit(q, i0, @"plus") {
        Option::Some(j) => { return (Op::Add, j); },
        Option::None => {}
    }
    match eat_lit(q, i0, @"minus") {
        Option::Some(j) => { return (Op::Sub, j); },
        Option::None => {}
    }
    match eat_lit(q, i0, @"multiplied") {
        Option::Some(j1) => {
            let j1s = skip_spaces(q, j1);
            match eat_lit(q, j1s, @"by") {
                Option::Some(j2) => { return (Op::Mul, j2); },
                Option::None => { panic!("syntax error"); }
            }
        },
        Option::None => {}
    }
    match eat_lit(q, i0, @"divided") {
        Option::Some(j1) => {
            let j1s = skip_spaces(q, j1);
            match eat_lit(q, j1s, @"by") {
                Option::Some(j2) => { return (Op::Div, j2); },
                Option::None => { panic!("syntax error"); }
            }
        },
        Option::None => {}
    }

    // Not a recognized operator. Choose error kind.
    let unknown = match q.at(i0) {
        Option::Some(b) => is_ascii_letter(b), // e.g. "cubed"
        Option::None => false,
    };
    if unknown {
        panic!("unknown operation");
    } else {
        panic!("syntax error");
    }

    // Unreachable fallback to satisfy the type checker
    (Op::Add, 0)
}

pub fn answer(question: ByteArray) -> i32 {
    let q = question;

    // Must start with "What is" (no trailing space required).
    let mut i: usize = 0;
    match eat_lit(@q, 0, @"What is") {
        Option::Some(j) => { i = j; },
        Option::None => { panic!("unknown operation"); }
    }
    i = skip_spaces(@q, i);

    // First token must be a number.
    let (mut acc, mut pos) = parse_number_or_panic(@q, i);
    i = pos;

    // Repeatedly parse (op number), then expect a '?'
    loop {
        i = skip_spaces(@q, i);

        match q.at(i) {
            Option::Some(b) => {
                if b == 63 { // '?'
                    // No trailing garbage allowed.
                    i = i + 1;
                    i = skip_spaces(@q, i);
                    match q.at(i) {
                        Option::None => { break; },   // <- exit loop, then return acc
                        _ => { panic!("syntax error"); }
                    }
                } else {
                    // Expect an operator, then a number.
                    let (op, j) = parse_operator_or_panic(@q, i);
                    i = j;
                    let (rhs, k) = parse_number_or_panic(@q, i);
                    i = k;

                    // Left-to-right evaluation (ignore precedence).
                    match op {
                        Op::Add => { acc = acc + rhs; },
                        Op::Sub => { acc = acc - rhs; },
                        Op::Mul => { acc = acc * rhs; },
                        Op::Div => { acc = acc / rhs; },
                    }
                }
            },
            Option::None => { panic!("syntax error"); } // missing '?'
        }
    };

    // Final result after seeing '?'
    acc
}
          