type band =
  | Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
let bandToValue = (b) =>
  switch b {
  | Black => 0
  | Brown => 1
  | Red => 2
  | Orange => 3
  | Yellow => 4
  | Green => 5
  | Blue => 6
  | Violet => 7
  | Grey => 8
  | White => 9
  }
let stringToBand = (s) =>
  switch s {
  | "black" => Black
  | "brown" => Brown
  | "red" => Red
  | "orange" => Orange
  | "yellow" => Yellow
  | "green" => Green
  | "blue" => Blue
  | "violet" => Violet
  | "grey" => Grey
  | "white" => White
  | _ => Black
  }
let transform = (opt) =>
  opt->Option.getOr("black")->stringToBand->bandToValue
let label = (colors) => {
  let tens = colors[0]->transform
  let ones = colors[1]->transform
  let exponent = colors[2]->transform->Int.toFloat
  let raw = Int.toFloat(tens * 10 + ones)
  let ohms = 10.->Math.pow(~exp=exponent) *. raw
  let (value, unit) = if ohms >= 1_000_000_000. {
    (ohms /. 1_000_000_000., "gigaohms")
  } else if ohms >= 1_000_000. {
    (ohms /. 1_000_000., "megaohms")
  } else if ohms >= 1_000. {
    (ohms /. 1_000., "kiloohms")
  } else {
    (ohms, "ohms")
  }
  `${Float.toString(value)} ${unit}`
}
