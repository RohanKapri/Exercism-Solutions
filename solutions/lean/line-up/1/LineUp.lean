namespace LineUp

def format (name : String) (number : Fin 1000) : String :=
  let firstDigit := number.val % 10
  let secondDigit := (number.val / 10) % 10
  let ordinal := match secondDigit, firstDigit with
  | 1, 1 | 1, 2 | 1, 3 => "th"
  | _, 1 => "st"
  | _, 2 => "nd"
  | _, 3 => "rd"
  | _, _ => "th"
  s!"{name}, you are the {number.val}{ordinal} customer we serve today. Thank you!"

end LineUp