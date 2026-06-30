namespace QueenAttack

structure Queen where
  row : Int
  col : Int
  h : row ≥ 0 ∧ row < 8 ∧ col ≥ 0 ∧ col < 8

instance : BEq Queen where
  beq a b := a.row == b.row && a.col == b.col

instance : Repr Queen where
  reprPrec q prec := reprPrec (q.row, q.col) prec

def create? (row col : Int) : Option Queen :=
  if h : row ≥ 0 ∧ row < 8 ∧ col ≥ 0 ∧ col < 8 then
    some { row, col, h }
  else
    none

def canAttack (white black : Queen) : Bool :=
  white.row == black.row ||
  white.col == black.col ||
  white.row + black.col == black.row + white.col ||
  white.row + white.col == black.row + black.col

end QueenAttack