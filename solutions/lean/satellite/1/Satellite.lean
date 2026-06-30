import Std.Data.HashMap
import Std.Data.HashSet

namespace Satellite

inductive Tree (α : Type) : Type where
  | leaf
  | branch (value : α) (left right : Tree α)
  deriving BEq, Repr, Nonempty

inductive Result where
  | ok : Tree Char → Result
  | error : String → Result
  deriving BEq, Repr

private structure RangeLookup where
  minCode : Nat
  slots : Array (Option Nat)

private def spanLimit (n : Nat) : Nat :=
  n * 4 + 1

private partial def rangeOfArray (xs : Array Char) (i : Nat) (minC maxC : Nat) : Nat × Nat :=
  if i < xs.size then
    let v := xs[i]!.toNat
    rangeOfArray xs (i + 1) (Nat.min minC v) (Nat.max maxC v)
  else
    (minC, maxC)

private def mkRangeLookup (inA : Array Char) : Option RangeLookup :=
  if inA.isEmpty then
    some { minCode := 0, slots := #[] }
  else
    let (minC, maxC) := rangeOfArray inA 1 inA[0]!.toNat inA[0]!.toNat
    let span := maxC - minC + 1
    if span > spanLimit inA.size then
      none
    else
      some { minCode := minC, slots := Array.replicate span none }

private def slotIdx (lk : RangeLookup) (c : Char) : Option (Fin lk.slots.size) :=
  let v := c.toNat
  if v >= lk.minCode then
    let i := v - lk.minCode
    if h2 : i < lk.slots.size then some ⟨i, h2⟩ else none
  else
    none

private partial def fillRangeLoop (inA : Array Char) (i : Nat) (lk : RangeLookup) : Option RangeLookup :=
  if i < inA.size then
    let c := inA[i]!
    match slotIdx lk c with
    | none => none
    | some slot =>
      match lk.slots[slot] with
      | some _ => none
      | none =>
        fillRangeLoop inA (i + 1) { lk with slots := lk.slots.set slot (some i) }
  else
    some lk

private inductive BuildErr where
  | unique
  | sameElems

private partial def buildConsumeRange
    (pre : Array Char) (lk : RangeLookup) (preL preR inL inR : Nat) : Except BuildErr (Tree Char) :=
  if preL >= preR then
    .ok .leaf
  else
    let root := pre[preL]!
    match slotIdx lk root with
    | none => .error .sameElems
    | some slot =>
      match lk.slots[slot] with
      | none => .error .unique
      | some inRoot =>
        let lk' := { lk with slots := lk.slots.set slot none }
        let leftSize := inRoot - inL
        let mid := preL + 1
        match buildConsumeRange pre lk' mid (mid + leftSize) inL inRoot with
        | .error e => .error e
        | .ok left =>
          match buildConsumeRange pre lk' (mid + leftSize) preR (inRoot + 1) inR with
          | .error e => .error e
          | .ok right => .ok (.branch root left right)

private abbrev PosMap := Std.HashMap Char Nat

private def insertPos (m : PosMap) (c : Char) (idx : Nat) : Option PosMap :=
  if m.contains c then none else some (m.insert c idx)

private partial def buildPositionsLoop (inorder : Array Char) (i : Nat) (m : PosMap) : Option PosMap :=
  if i < inorder.size then
    match insertPos m inorder[i]! i with
    | none => none
    | some m' => buildPositionsLoop inorder (i + 1) m'
  else
    some m

private partial def validateHashLoop
    (pre : Array Char) (pos : PosMap) (seen : Std.HashSet Char) (i : Nat) : Option Result :=
  if i < pre.size then
    let c := pre[i]!
    if seen.contains c then
      some (.error "traversals must contain unique items")
    else if !pos.contains c then
      some (.error "traversals must have the same elements")
    else
      validateHashLoop pre pos (seen.insert c) (i + 1)
  else
    none

partial def buildIdxHash (pre : Array Char) (pos : PosMap) (preL preR inL inR : Nat) : Tree Char :=
  if preL >= preR then
    .leaf
  else
    let root := pre[preL]!
    let inRoot := pos.getD root inL
    let leftSize := inRoot - inL
    let mid := preL + 1
    .branch root
      (buildIdxHash pre pos mid (mid + leftSize) inL inRoot)
      (buildIdxHash pre pos (mid + leftSize) preR (inRoot + 1) inR)

private def buildWithRange (pre inA : Array Char) : Result :=
  match mkRangeLookup inA with
  | none => .error "traversals must contain unique items"
  | some lk0 =>
    match fillRangeLoop inA 0 lk0 with
    | none => .error "traversals must contain unique items"
    | some lk =>
      match buildConsumeRange pre lk 0 pre.size 0 inA.size with
      | .error .unique => .error "traversals must contain unique items"
      | .error .sameElems => .error "traversals must have the same elements"
      | .ok t => .ok t

private def buildWithHash (pre inA : Array Char) : Result :=
  match buildPositionsLoop inA 0 (Std.HashMap.emptyWithCapacity inA.size) with
  | none => .error "traversals must contain unique items"
  | some pos =>
    match validateHashLoop pre pos (Std.HashSet.emptyWithCapacity pre.size) 0 with
    | some err => err
    | none => .ok (buildIdxHash pre pos 0 pre.size 0 inA.size)

def treeFromTraversals (preorder inorder : List Char) : Result :=
  if preorder.length != inorder.length then
    .error "traversals must have the same length"
  else
    let pre := preorder.toArray
    let inA := inorder.toArray
    match mkRangeLookup inA with
    | some _ => buildWithRange pre inA
    | none => buildWithHash pre inA

end Satellite