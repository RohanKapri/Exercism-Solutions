namespace MatchingBrackets

def validate : List Char -> Char -> Option (List Char)
  | '(' :: ss, ')'
  | '[' :: ss, ']'
  | '{' :: ss, '}' => some ss
  | _, ')' 
  | _, ']'
  | _, '}'         => none
  | ss, '('        => some ('(' :: ss)
  | ss, '['        => some ('[' :: ss)
  | ss, '{'        => some ('{' :: ss)
  | ss, _          => some ss

def isPaired (value : String) : Bool :=
  (value.toList.foldlM validate []).any List.isEmpty

end MatchingBrackets