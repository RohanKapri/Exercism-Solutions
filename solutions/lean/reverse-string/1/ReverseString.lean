namespace ReverseString

def reverse : String -> String :=
  String.foldr (init := "") (flip String.push)
  
end ReverseString