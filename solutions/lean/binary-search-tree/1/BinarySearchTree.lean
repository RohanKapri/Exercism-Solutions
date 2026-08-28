namespace BinarySearchTree

/-
  You should define a data structure to represent your Binary Search Tree.
  It must be accessed through .data!, .left! and .right!.

  There should also have:

  1. a function buildTree that takes a List of elements and returns your Binary Search Tree with those elements in the correct place.
  2. a .sort, which returns a sorted list of the items in your Tree.
-/

inductive Tree (α : Type) where
  | empty : Tree α
  | node (data : α) (left : Tree α) (right : Tree α) (sorted : List α) : Tree α

def Tree.sorted : Tree α → List α
  | .empty => []
  | .node _ _ _ sorted => sorted

def Tree.mkNode (data : α) (left right : Tree α) : Tree α :=
  .node data left right (left.sorted ++ [data] ++ right.sorted)

def Tree.data! [Inhabited α] : Tree α → α
  | .node data _ _ _ => data
  | .empty => default

def Tree.left! : Tree α → Tree α
  | .node _ left _ _ => left
  | .empty => .empty

def Tree.right! : Tree α → Tree α
  | .node _ _ right _ => right
  | .empty => .empty

def Tree.insert [Ord α] : Tree α → α → Tree α
  | .empty, value => .node value .empty .empty [value]
  | .node data left right _, value =>
      match compare value data with
      | .gt => Tree.mkNode data left (right.insert value)
      | _ => Tree.mkNode data (left.insert value) right

def Tree.sort (tree : Tree α) : List α :=
  tree.sorted

def buildTree [Ord α] (values : List α) : Tree α :=
  values.foldl Tree.insert Tree.empty

end BinarySearchTree