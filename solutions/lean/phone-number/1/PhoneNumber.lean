namespace PhoneNumber

def validate : List Char -> Option String
  | '0' :: _  | '1' :: _                
  | _ :: _ :: _ :: '0' :: _ 
  | _ :: _ :: _ :: '1' :: _ => none
  | xs                      => some $ String.ofList xs

def clean (phrase : String) : Option String :=
  let digits := phrase.toList.filter Char.isDigit
  match digits.length with
  | 10 => validate digits
  | 11 => match digits with
          | '1' :: ds => validate ds
          | _         => none
  | _  => none

end PhoneNumber
