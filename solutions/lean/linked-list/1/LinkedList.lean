namespace LinkedList

structure NodeData (α : Type) where
  value : α
  prev  : Option Nat   -- index of previous node, none if head
  next  : Option Nat   -- index of next node, none if tail

structure LinkedList (σ α : Type) where
  nodes : ST.Ref σ (Array (ST.Ref σ (NodeData α)))
  head  : ST.Ref σ (Option Nat)
  tail  : ST.Ref σ (Option Nat)
  sz    : ST.Ref σ Nat

private partial def scanForValue {α σ : Type} [BEq α]
    (arr : Array (ST.Ref σ (NodeData α))) (v : α) : Option Nat → ST σ (Option Nat)
  | none   => pure none
  | some i =>
    match arr[i]? with
    | none   => pure none
    | some r => do
      let nd ← r.get
      if nd.value == v then pure (some i)
      else scanForValue arr v nd.next

def LinkedList.empty {α σ : Type} : ST σ (LinkedList σ α) := do
  let nodes ← ST.mkRef (#[] : Array (ST.Ref σ (NodeData α)))
  let head  ← ST.mkRef (none : Option Nat)
  let tail  ← ST.mkRef (none : Option Nat)
  let sz    ← ST.mkRef 0
  pure { nodes, head, tail, sz }

def LinkedList.count {α σ : Type} (list : LinkedList σ α) : ST σ Nat :=
  list.sz.get

def LinkedList.push {α σ : Type} (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let tailIdx ← list.tail.get
  let newRef  ← ST.mkRef ({ value, prev := tailIdx, next := none } : NodeData α)
  let arr     ← list.nodes.get
  let newIdx  := arr.size
  -- arr.push copies the pointer array (8 bytes/element); after set, arr refcount drops to 1
  list.nodes.set (arr.push newRef)
  match tailIdx with
  | none    =>
    list.head.set (some newIdx)
    list.tail.set (some newIdx)
  | some ti =>
    -- arr[ti]? reads from the OLD array (still valid, refcount now 1 locally)
    -- modifying the node ref's contents requires NO array write
    if let some tRef := arr[ti]? then
      tRef.modify fun n => { n with next := some newIdx }
    list.tail.set (some newIdx)
  list.sz.modify (· + 1)

def LinkedList.unshift {α σ : Type} (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let headIdx ← list.head.get
  let newRef  ← ST.mkRef ({ value, prev := none, next := headIdx } : NodeData α)
  let arr     ← list.nodes.get
  let newIdx  := arr.size
  list.nodes.set (arr.push newRef)
  match headIdx with
  | none    =>
    list.head.set (some newIdx)
    list.tail.set (some newIdx)
  | some hi =>
    if let some hRef := arr[hi]? then
      hRef.modify fun n => { n with prev := some newIdx }
    list.head.set (some newIdx)
  list.sz.modify (· + 1)

def LinkedList.pop {α σ : Type} (list : LinkedList σ α) : ST σ (Option α) := do
  let tailIdx ← list.tail.get
  match tailIdx with
  | none    => pure none
  | some ti =>
    let arr ← list.nodes.get
    match arr[ti]? with
    | none     => pure none
    | some ref =>
      let nd      ← ref.get
      let prevIdx := nd.prev
      match prevIdx with
      | none    =>
        list.head.set none
        list.tail.set none
      | some pi =>
        if let some pRef := arr[pi]? then
          pRef.modify fun n => { n with next := none }
        list.tail.set prevIdx
      list.sz.modify (· - 1)
      pure (some nd.value)

def LinkedList.shift {α σ : Type} (list : LinkedList σ α) : ST σ (Option α) := do
  let headIdx ← list.head.get
  match headIdx with
  | none    => pure none
  | some hi =>
    let arr ← list.nodes.get
    match arr[hi]? with
    | none     => pure none
    | some ref =>
      let nd      ← ref.get
      let nextIdx := nd.next
      match nextIdx with
      | none    =>
        list.head.set none
        list.tail.set none
      | some ni =>
        if let some nRef := arr[ni]? then
          nRef.modify fun n => { n with prev := none }
        list.head.set nextIdx
      list.sz.modify (· - 1)
      pure (some nd.value)

def LinkedList.delete {α σ : Type} [BEq α] (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let arr     ← list.nodes.get
  let headIdx ← list.head.get
  match ← scanForValue arr value headIdx with
  | none   => pure ()
  | some i =>
    match arr[i]? with
    | none   => pure ()
    | some r =>
      let nd      ← r.get
      let prevIdx := nd.prev
      let nextIdx := nd.next
      match prevIdx with
      | none    => list.head.set nextIdx
      | some pi =>
        if let some pRef := arr[pi]? then
          pRef.modify fun n => { n with next := nextIdx }
      match nextIdx with
      | none    => list.tail.set prevIdx
      | some ni =>
        if let some nRef := arr[ni]? then
          nRef.modify fun n => { n with prev := prevIdx }
      list.sz.modify (· - 1)

end LinkedList