namespace Dominoes

def Half := { x : Nat // x ≥ 1 ∧ x ≤ 6 }

def Stone := Half × Half

private def zeroRow : Array Bool := Array.replicate 6 false

private def zeroAdj : Array (Array Bool) := Array.replicate 6 zeroRow

private def updateAdj (adj : Array (Array Bool)) (i j : Nat) : Array (Array Bool) :=
  let rowI := adj[i]!
  let rowI' := rowI.set! j true
  let adj' := adj.set! i rowI'
  let rowJ := adj'[j]!
  let rowJ' := rowJ.set! i true
  adj'.set! j rowJ'

private def buildState (dominoes : List Stone) : Array Nat × Array (Array Bool) :=
  dominoes.foldl (init := (Array.replicate 6 0, zeroAdj)) fun (deg, adj) stone =>
    let i := stone.1.1 - 1
    let j := stone.2.1 - 1
    let deg' := deg.set! i (deg[i]! + 1)
    let deg'' := deg'.set! j (deg'[j]! + 1)
    (deg'', updateAdj adj i j)

private def expandVisited (adj : Array (Array Bool)) (visited : Array Bool) : Array Bool :=
  (List.range 6).foldl (init := visited) fun vis i =>
    if vis[i]! then
      (List.range 6).foldl (init := vis) fun vis2 j =>
        if adj[i]![j]! then vis2.set! j true else vis2
    else
      vis

private def iterateExpand (adj : Array (Array Bool)) : Nat → Array Bool → Array Bool
  | 0, visited => visited
  | n + 1, visited => iterateExpand adj n (expandVisited adj visited)

def canChain (dominoes : List Stone) : Bool :=
  let (deg, adj) := buildState dominoes
  let allEven := (List.range 6).all fun i => deg[i]! % 2 == 0
  let active := (List.range 6).filter fun i => deg[i]! > 0
  let connected :=
    match active with
    | [] => true
    | start :: _ =>
        let seed := (Array.replicate 6 false).set! start true
        let visited := iterateExpand adj 6 seed
        active.all fun i => visited[i]!
  allEven && connected

end Dominoes
                  