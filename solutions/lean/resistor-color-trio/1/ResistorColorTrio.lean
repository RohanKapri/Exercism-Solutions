import Extra

/-
  You are given syntax for colors already predefined using the `c*` prefix, e.g., `c*black`.
  You must then define syntax that associates a sequence of colors to a number, according to the instructions.
  The colors are within `*[[` and `]]` and separated by `, `, e.g., `*[[c*black, c*yellow, c*violet]]`.

  Note that the online test runner does not have support to the `Lean` library.
  Any solution that uses it will fail when submitted to exercism, even if correct.
  This library is not necessary to solve the exercise.

  Macros and notations are not qualified by namespace.
  For this reason, this exercise does not define a namespace.
-/

structure ResistanceLabel where
  text : String

instance : Repr ResistanceLabel where
  reprPrec v _ := Std.Format.text v.text

def formatOhms (total : Nat) : ResistanceLabel :=
  if total == 0 then
    ⟨"0 \u2126"⟩
  else if total % 1_000_000_000 == 0 then
    ⟨s!"{total / 1_000_000_000} G\u2126"⟩
  else if total % 1_000_000 == 0 then
    ⟨s!"{total / 1_000_000} M\u2126"⟩
  else if total % 1_000 == 0 then
    ⟨s!"{total / 1_000} k\u2126"⟩
  else
    ⟨s!"{total} \u2126"⟩

def resistorColorTrio (a b c : Fin 10) : ResistanceLabel :=
  let significant := a.val * 10 + b.val
  let total := significant * Nat.pow 10 c.val
  formatOhms total

macro_rules
  | `(*[[ $a:colors, $b:colors, $c:colors ]]) => do
      let a' : Lean.TSyntax `term := ⟨a.raw⟩
      let b' : Lean.TSyntax `term := ⟨b.raw⟩
      let c' : Lean.TSyntax `term := ⟨c.raw⟩
      `(resistorColorTrio $a' $b' $c')
  | `(*[[ $a:colors, $b:colors, $c:colors, $rest:colors,* ]]) => do
      let a' : Lean.TSyntax `term := ⟨a.raw⟩
      let b' : Lean.TSyntax `term := ⟨b.raw⟩
      let c' : Lean.TSyntax `term := ⟨c.raw⟩
      `(resistorColorTrio $a' $b' $c')