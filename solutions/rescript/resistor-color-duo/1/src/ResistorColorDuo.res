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

let bandToValue = (c: band) =>
  switch c {
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

let stringToBand = (s: string) =>
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

let transform = (opt: option<string>) =>
  opt->Option.getOr("black")->stringToBand->bandToValue

let value = (colors: array<string>) => {
  let tens = transform(colors[0])
  let ones = transform(colors[1])
  tens * 10 + ones
}