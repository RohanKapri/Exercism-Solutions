namespace TwoFer

def twoFer : Option String -> String
  | none =>  s!"One for you, one for me."
  | some name =>  s!"One for {name}, one for me."
  
end TwoFer