namespace Acronym

inductive State where
  | word  : String → State 
  | delim : String → State

def State.yield : State → String
  | .word acc => acc
  | .delim acc => acc

def abbreviate (phrase : String) : String :=
  phrase.foldl 
    (init := State.delim "") 
    (fun 
      | .word acc,  x => 
        if x.isAlphanum ∨ x = '\''   
        then .word acc
        else .delim acc
      | .delim acc, x =>
        if x.isAlphanum 
        then .word (acc.push x.toUpper)
        else .delim acc) 
  |>.yield    

end Acronym