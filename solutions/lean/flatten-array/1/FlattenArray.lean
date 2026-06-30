namespace FlattenArray

inductive Box (α : Type) : Type where
  | zero
  | one (value : α)
  | many (boxes : Array (Box α))

def flatten : Box Int -> Array Int
  | .zero       => #[]
  | .one x      => #[x]
  | .many boxes => boxes.foldl (fun acc box => acc ++ flatten box) #[]

end FlattenArray