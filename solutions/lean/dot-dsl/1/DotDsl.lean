import Extra
import Std.Data.HashMap

open Lean Macro

private def canonPair (n1 n2 : String) : String × String :=
  if n1 ≤ n2 then (n1, n2) else (n2, n1)

-- ── State ─────────────────────────────────────────────────────────────────────

private structure DotState where
  nodes   : Array Extra.Node                  := #[]
  nodeIdx : Std.HashMap String Nat            := {}
  edges   : Array Extra.Edge                  := #[]
  edgeIdx : Std.HashMap (String × String) Nat := {}
  attrs   : Array Extra.Attribute             := #[]

-- ── State helpers ─────────────────────────────────────────────────────────────

private def upsertNode (state : DotState) (name : String)
    (attrs : Array Extra.Attribute) : DotState :=
  match state.nodeIdx.get? name with
  | some i => { state with nodes := state.nodes.set! i { name := name, attrs := attrs } }
  | none   =>
      { state with
        nodes   := state.nodes.push { name := name, attrs := attrs }
        nodeIdx := state.nodeIdx.insert name state.nodes.size }

private def ensureNode (state : DotState) (name : String) : DotState :=
  match state.nodeIdx.get? name with
  | some _ => state
  | none   =>
      { state with
        nodes   := state.nodes.push { name := name, attrs := #[] }
        nodeIdx := state.nodeIdx.insert name state.nodes.size }

private def upsertEdge (state : DotState) (n1 n2 : String)
    (attrs : Array Extra.Attribute) : DotState :=
  let key := canonPair n1 n2
  match state.edgeIdx.get? key with
  | some i =>
      if attrs.size > 0 then
        { state with edges := state.edges.modify i fun e => { e with attrs := attrs } }
      else
        state
  | none =>
      { state with
        edges   := state.edges.push { node₁ := ⟨n1, #[]⟩, node₂ := ⟨n2, #[]⟩, attrs := attrs }
        edgeIdx := state.edgeIdx.insert key state.edges.size }

-- ── Grammar (must precede any use of syntax categories) ────────────────────

declare_syntax_cat attrPair
declare_syntax_cat graphStmt

syntax ident "=" term                                                 : attrPair
syntax ident ("[" attrPair,* "]")? ";"                               : graphStmt
syntax ident "-" ident ("[" attrPair,* "]")? ";"                     : graphStmt
syntax ident "-" ident "-" ident ("[" attrPair,* "]")? ";"           : graphStmt
syntax ident "-" ident "-" ident "-" ident ("[" attrPair,* "]")? ";" : graphStmt
syntax "[" attrPair,* "]" ";"                                         : graphStmt
syntax "#" term ";"                                                   : graphStmt
syntax "//" term ";"                                                  : graphStmt
syntax "graph" "{" graphStmt* "}" : term

-- ── Syntax helpers ────────────────────────────────────────────────────────────

private partial def syntaxText (stx : Syntax) : String :=
  match stx with
  | .ident _ _ name _ => name.toString
  | .atom _ text =>
      let chars := text.toList
      if chars.length ≥ 2 && chars.head? == some '"' && chars.getLast? == some '"' then
        String.ofList (((chars.drop 1).reverse.drop 1).reverse)
      else
        text
  | .node _ _ args =>
      if args.size > 0 then syntaxText args[0]! else ""
  | _ => ""

private def attrPairToAttr (stx : Syntax) : MacroM Extra.Attribute := do
  match stx with
  | `(attrPair| $name:ident = $value:term) =>
      pure ⟨name.getId.toString, syntaxText value⟩
  | _ => throwError "invalid attribute"

-- Collect attrPair nodes from a TSepArray null-wrapper node.
private def attrsFromSepNode (sepNode : Syntax) : MacroM (Array Extra.Attribute) := do
  let mut out : Array Extra.Attribute := #[]
  for child in sepNode.getArgs do
    if child.getKind == Name.mkSimple "attrPair_=_" then
      out := out.push (← attrPairToAttr child)
  return out

-- Extract attrs from the optional "[" sepNode "]" node.
-- 0 args → absent; 3 args "[", sepNode, "]" → present.
private def attrsFromOptional (optNode : Syntax) : MacroM (Array Extra.Attribute) := do
  if optNode.getArgs.size == 0 then return #[]
  attrsFromSepNode optNode.getArgs[1]!

-- Collect ident names from an arg array, skipping "-" atoms.
private def collectIdents (args : Array Syntax) : List String :=
  let rec go (i : Nat) (acc : List String) : List String :=
    if _ : i < args.size then
      let arg := args[i]!
      if arg.isIdent then
        go (i + 1) (acc ++ [arg.getId.toString])
      else
        match arg with
        | .atom _ "-" => go (i + 1) acc
        | _           => acc
    else
      acc
  go 0 []

-- ── Quoting helpers ───────────────────────────────────────────────────────────

-- Build a flat #[e₁, e₂, …] literal (or #[] when empty).
private def mkArrayExpr (elems : Array (TSyntax `term)) : MacroM (TSyntax `term) := do
  if elems.isEmpty then
    `(#[])
  else
    let sep : Lean.Syntax.TSepArray (.cons `term .nil) "," :=
      ⟨elems.foldl (fun acc e =>
        if acc.isEmpty then acc.push e.raw
        else acc.push (Syntax.atom .none ",") |>.push e.raw) #[]⟩
    `(#[$sep,*])

private def quoteAttr (attr : Extra.Attribute) : MacroM (TSyntax `term) := do
  let prop  : TSyntax `term := ⟨Syntax.mkStrLit attr.property⟩
  let value : TSyntax `term := ⟨Syntax.mkStrLit attr.value⟩
  `(⟨$prop, $value⟩)

private def quoteNode (node : Extra.Node) : MacroM (TSyntax `term) := do
  let name  : TSyntax `term := ⟨Syntax.mkStrLit node.name⟩
  let attrs ← mkArrayExpr (← node.attrs.mapM quoteAttr)
  `(⟨$name, $attrs⟩)

private def quoteEdge (edge : Extra.Edge) : MacroM (TSyntax `term) := do
  let n1    : TSyntax `term := ⟨Syntax.mkStrLit edge.node₁.name⟩
  let n2    : TSyntax `term := ⟨Syntax.mkStrLit edge.node₂.name⟩
  let attrs ← mkArrayExpr (← edge.attrs.mapM quoteAttr)
  `(⟨⟨$n1, #[]⟩, ⟨$n2, #[]⟩, $attrs⟩)

private def quoteTree (state : DotState) : MacroM (TSyntax `term) := do
  let sortedEdges := state.edges.qsort fun e1 e2 =>
    if e1.node₁.name != e2.node₁.name then e1.node₁.name < e2.node₁.name
    else e1.node₂.name < e2.node₂.name
  let sortedAttrs := state.attrs.qsort fun a b => a.property < b.property
  let nodes ← mkArrayExpr (← state.nodes.mapM quoteNode)
  let edges ← mkArrayExpr (← sortedEdges.mapM quoteEdge)
  let attrs ← mkArrayExpr (← sortedAttrs.mapM quoteAttr)
  `(⟨$nodes, $edges, $attrs⟩)

-- ── Statement processor ───────────────────────────────────────────────────────

-- Direct dispatch by first arg; optional attrs null-node is always at
-- args[args.size - 2] for node/edge stmts (";\" is last).
private def stepState (state : DotState) (stx : Syntax) : MacroM DotState := do
  let args := stx.getArgs
  if args.size < 2 then return state
  match args[0]! with
  | .atom _ "#"  | .atom _ "//" => return state
  | .atom _ "[" =>
      let attrs ← attrsFromSepNode args[1]!
      return { state with attrs := state.attrs ++ attrs }
  | _ =>
      let names   := collectIdents args
      let optNode := args[args.size - 2]!
      let attrs   ← attrsFromOptional optNode
      match names with
      | [name]       => return upsertNode state name attrs
      | [n1, n2]     =>
          let state := ensureNode (ensureNode state n1) n2
          return upsertEdge state n1 n2 attrs
      | [a, b, c]    =>
          let state := ensureNode (ensureNode (ensureNode state a) b) c
          return upsertEdge (upsertEdge state a b attrs) b c attrs
      | [a, b, c, d] =>
          let state := ensureNode (ensureNode (ensureNode (ensureNode state a) b) c) d
          return upsertEdge (upsertEdge (upsertEdge state a b attrs) b c attrs) c d attrs
      | _            => throwError "invalid Dot DSL statement"

macro_rules
  | `(graph { $stmts* }) => do
      let rec loop (i : Nat) (state : DotState) : MacroM DotState := do
        if _ : i < stmts.size then
          let state ← stepState state stmts[i]!
          loop (i + 1) state
        else
          pure state
      let state ← loop 0 {}
      quoteTree state