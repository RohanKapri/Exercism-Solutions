namespace RationalNumbers

/--
  Represents a fully reduced rational number.
  It is constructed from a numerator (`num`) and a denominator (`den`), both of type `Int`, and a proof that: `den > 0 ∧ Int.gcd num den = 1`.
-/
structure RationalNumber where
  num : Int
  den : Int
  h : den > 0 ∧ Int.gcd num den = 1
  deriving BEq, Repr

-- Prove that dividing both by their GCD yields coprime pair
private theorem gcd_div_coprime (a b : Int) (hb : b > 0) :
    Int.gcd (a / ↑(Int.gcd a b)) (b / ↑(Int.gcd a b)) = 1 := by
  simp only [Int.gcd]
  have hb_natAbs_pos : 0 < b.natAbs := Int.natAbs_pos.mpr (by omega)
  have hdvd_a : (↑(Nat.gcd a.natAbs b.natAbs) : Int) ∣ a := Int.gcd_dvd_left a b
  have hdvd_b : (↑(Nat.gcd a.natAbs b.natAbs) : Int) ∣ b := Int.gcd_dvd_right a b
  rw [Int.natAbs_ediv_of_dvd hdvd_a, Int.natAbs_ediv_of_dvd hdvd_b]
  simp only [Int.natAbs_natCast]
  exact Nat.gcd_div_gcd_div_gcd_of_pos_right hb_natAbs_pos

private theorem pow_coprime (a b : Int) (m : Nat) (h : Int.gcd a b = 1) :
    Int.gcd (a ^ m) (b ^ m) = 1 :=
  Int.pow_gcd_pow_of_gcd_eq_one h

-- Build a RationalNumber from a / b where b > 0. Automatically reduces to lowest terms.
private def mkRatPos (a b : Int) (hb : b > 0) : RationalNumber :=
  let g : Int := Int.gcd a b
  have hg_pos : g > 0 := by
    simp only [g, Int.gcd]
    exact_mod_cast Nat.gcd_pos_of_pos_right _ (Int.natAbs_pos.mpr (by omega))
  ⟨a / g, b / g,
    ⟨Int.ediv_pos_of_pos_of_dvd hb (by omega) (Int.gcd_dvd_right a b),
     gcd_div_coprime a b hb⟩⟩

private def mkReduced (num den : Int) (h : den > 0 ∧ Int.gcd num den = 1) : RationalNumber :=
  ⟨num, den, h⟩

-- Build a RationalNumber from a / b where b ≠ 0. Normalises sign.
private def mkRat (a b : Int) (hb : b ≠ 0) : RationalNumber :=
  if h : b < 0 then mkRatPos (-a) (-b) (by omega)
  else mkRatPos a b (by omega)

def add (r1 r2 : RationalNumber) : RationalNumber :=
  let g := Int.gcd r1.den r2.den
  if _ : g = 1 then
    mkRatPos (r1.num * r2.den + r2.num * r1.den) (r1.den * r2.den)
      (Int.mul_pos r1.h.1 r2.h.1)
  else
    mkRatPos (r1.num * (r2.den / g) + r2.num * (r1.den / g)) ((r1.den / g) * r2.den)
      (Int.mul_pos (Int.ediv_pos_of_pos_of_dvd r1.h.1 (by omega) (Int.gcd_dvd_left r1.den r2.den))
        r2.h.1)

def sub (r1 r2 : RationalNumber) : RationalNumber :=
  let g := Int.gcd r1.den r2.den
  if _ : g = 1 then
    mkRatPos (r1.num * r2.den - r2.num * r1.den) (r1.den * r2.den)
      (Int.mul_pos r1.h.1 r2.h.1)
  else
    mkRatPos (r1.num * (r2.den / g) - r2.num * (r1.den / g)) ((r1.den / g) * r2.den)
      (Int.mul_pos (Int.ediv_pos_of_pos_of_dvd r1.h.1 (by omega) (Int.gcd_dvd_left r1.den r2.den))
        r2.h.1)

def mul (r1 r2 : RationalNumber) : RationalNumber :=
  let g1 := Int.gcd r1.num r2.den
  let g2 := Int.gcd r2.num r1.den
  if _ : g1 = 1 ∧ g2 = 1 then
    mkRatPos (r1.num * r2.num) (r1.den * r2.den)
      (Int.mul_pos r1.h.1 r2.h.1)
  else
    mkRatPos ((r1.num / g1) * (r2.num / g2)) ((r1.den / g2) * (r2.den / g1))
      (Int.mul_pos (Int.ediv_pos_of_pos_of_dvd r1.h.1 (by omega) (Int.gcd_dvd_right r2.num r1.den))
        (Int.ediv_pos_of_pos_of_dvd r2.h.1 (by omega) (Int.gcd_dvd_right r1.num r2.den)))

def div (r1 r2 : RationalNumber) : RationalNumber :=
  let g1 := Int.gcd r1.num r2.num
  let g2 := Int.gcd r2.den r1.den
  if _ : g1 = 1 ∧ g2 = 1 then
    let b := r1.den * r2.num
    if h : b = 0 then ⟨0, 1, by decide⟩
    else mkRat (r1.num * r2.den) b h
  else
    let num := (r1.num / g1) * (r2.den / g2)
    let den := (r1.den / g2) * (r2.num / g1)
    if h : den = 0 then ⟨0, 1, by decide⟩
    else mkRat num den h

def abs (r : RationalNumber) : RationalNumber :=
  if r.num ≥ 0 then r
  else mkRatPos (r.num.natAbs : Int) r.den r.h.1

def exprational (r : RationalNumber) (n : Int) : RationalNumber :=
  if n = 0 then
    ⟨1, 1, by decide⟩
  else if n > 0 then
    let m := n.toNat
    mkReduced (r.num ^ m) (r.den ^ m)
      ⟨Int.pow_pos r.h.1, pow_coprime r.num r.den m r.h.2⟩
  else
    let m := (-n).toNat
    let den' := r.num ^ m
    if h : den' = 0 then ⟨0, 1, by decide⟩
    else mkRat (r.den ^ m) den' h

def expreal (x : Int) (r : RationalNumber) : Float :=
  let xf := Float.ofInt x
  let af := Float.ofInt r.num
  let bf := Float.ofInt r.den
  Float.pow (Float.pow xf af) (1.0 / bf)

end RationalNumbers