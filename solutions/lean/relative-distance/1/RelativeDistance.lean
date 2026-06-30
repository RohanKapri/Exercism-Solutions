namespace RelativeDistance

abbrev Parent := String
abbrev Children := List String

private def buildAdjList (familyTree : List (Parent × Children)) : List (String × List String) :=
  let allPeople : List String :=
    (familyTree.flatMap fun pair => pair.1 :: pair.2).eraseDups
  
  let pcEdges : List (String × String) :=
    familyTree.flatMap fun pair => pair.2.map fun c => (pair.1, c)
  
  let sibEdges : List (String × String) :=
    familyTree.flatMap fun pair =>
      pair.2.flatMap fun c1 => pair.2.filterMap fun c2 =>
        if c1 != c2 then some (c1, c2) else none
  let edges := pcEdges ++ sibEdges
  allPeople.map fun person =>
    let neighbors : List String := edges.flatMap fun edge =>
      if edge.1 == person then [edge.2]
      else if edge.2 == person then [edge.1]
      else []
    (person, neighbors)

private def bfsAux (adj : List (String × List String)) (goal : String) :
    Nat → List (String × Nat) → List String → Option Nat
  | 0, _, _ => none
  | _, [], _ => none
  | n + 1, (curr, dist) :: rest, visited =>
    let neighbors := match adj.find? fun (x, _) => x == curr with
      | some (_, ns) => ns
      | none => []
    let fresh := neighbors.filter fun name => !visited.contains name
    if fresh.contains goal then some (dist + 1)
    else bfsAux adj goal n (rest ++ fresh.map fun name => (name, dist + 1)) (visited ++ fresh)

def degreeOfSeparation (familyTree : List (Parent × Children)) (personA personB : String) : Option Nat :=
  if personA == personB then some 0
  else
    let adj := buildAdjList familyTree
    bfsAux adj personB (adj.length + 1) [(personA, 0)] [personA]

end RelativeDistance