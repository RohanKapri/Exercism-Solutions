#[derive(Debug, Drop, PartialEq)]
pub enum Color {
    Black,
    Brown, 
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Violet,
    Grey,
    White,
}

pub fn color_code(color: Color) -> u8 {
    match color {
        Color::Black => 0,
        Color::Brown => 1,
        Color::Red => 2,
        Color::Orange => 3,
        Color::Yellow => 4,
        Color::Green => 5,
        Color::Blue => 6,
        Color::Violet => 7,
        Color::Grey => 8,
        Color::White => 9,
    }
}

pub fn colors() -> Array<Color> {
    let mut colors = ArrayTrait::new();
    colors.append(Color::Black);
    colors.append(Color::Brown);
    colors.append(Color::Red);
    colors.append(Color::Orange);
    colors.append(Color::Yellow);
    colors.append(Color::Green);
    colors.append(Color::Blue);
    colors.append(Color::Violet);
    colors.append(Color::Grey);
    colors.append(Color::White);
    colors
}