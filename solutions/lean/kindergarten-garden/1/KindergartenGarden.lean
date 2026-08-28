namespace KindergartenGarden

inductive Plant where
  | grass | clover | radishes | violets
  deriving BEq, Repr, Inhabited

private def toPlant! : Char → Plant
  | 'G' => .grass
  | 'C' => .clover
  | 'R' => .radishes
  | 'V' => .violets
  | _   => panic! "Invalid plant encoding."

private inductive Student where
  | Alice | Bob | Charlie
  | David | Eve | Fred
  | Ginny | Harriet | Ileana
  | Joseph | Kincaid | Larry
  deriving Inhabited

private def Student.ofString! : String → Student
  | "Alice"   => .Alice   | "Bob"     => .Bob
  | "Charlie" => .Charlie | "David"   => .David
  | "Eve"     => .Eve     | "Fred"    => .Fred
  | "Ginny"   => .Ginny   | "Harriet" => .Harriet
  | "Ileana"  => .Ileana  | "Joseph"  => .Joseph
  | "Kincaid" => .Kincaid | "Larry"   => .Larry
  | _         => panic! "Invalid student."

private def Student.index : Student → Nat
  | .Alice   => 0  | .Bob     => 2
  | .Charlie => 4  | .David   => 6
  | .Eve     => 8  | .Fred    => 10
  | .Ginny   => 12 | .Harriet => 14
  | .Ileana  => 16 | .Joseph  => 18
  | .Kincaid => 20 | .Larry   => 22

private def charAt? (row : String) (pos : Nat) : Option Char :=
  row.pos? ⟨pos⟩ >>= (·.get?)

def plants (diagram : String) (student: String) : Vector Plant 4 :=
  let start := Student.ofString! student |>.index
  let indices := #[start, start + 1]
  match diagram.splitOn "\n" with
  | [row1, row2] =>
    let pos1 := indices.filterMap (charAt? row1)
    let pos2 := indices.filterMap (charAt? row2)
    if vlenrow: pos1.size = 2 ∧ pos2.size = 2 then
      let chars : Vector Char 4 := ⟨pos1 ++ pos2, by simp [vlenrow]⟩
      chars.map toPlant!
    else panic! "Invalid row length."
  | _            => panic! "Invalid diagram."

end KindergartenGarden