module [value]

Color : [
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
]

colorValues : List U8
colorValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

colorIndex : Color -> U64
colorIndex = \color ->
    when color is
        Black -> 0
        Brown -> 1
        Red -> 2
        Orange -> 3
        Yellow -> 4
        Green -> 5
        Blue -> 6
        Violet -> 7
        Grey -> 8
        White -> 9

value : Color, Color -> U8
value = |first, second|
    firstValue = List.get colorValues (colorIndex first) |> Result.with_default 0
    secondValue = List.get colorValues (colorIndex second) |> Result.with_default 0
    firstValue * 10 + secondValue
        