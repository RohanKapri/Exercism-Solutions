namespace Forth

namespace Original

private def normalize (s : String) : String :=
  s.toLower

private def parseNumber (tok : String) : Option Int :=
  tok.toInt?

private def isNumberName (name : String) : Bool :=
  (parseNumber name).isSome

private def isBuiltin (w : String) : Bool :=
  w == "+" || w == "-" || w == "*" || w == "/" ||
  w == "dup" || w == "drop" || w == "swap" || w == "over"

private def dictFind? (dict : List (String × List String)) (key : String) : Option (List String) :=
  (dict.find? fun (k, _) => k == key).map (·.2)

private def dictSet (dict : List (String × List String)) (key : String) (val : List String) :
    List (String × List String) :=
  (key, val) :: (dict.filter fun (k, _) => k ≠ key)

private def pop1 (stk : List Int) : Except String (Int × List Int) :=
  match stk with
  | [] => .error "empty stack"
  | stk => .ok (stk.getLast!, stk.dropLast)

private def pop2 (stk : List Int) : Except String (Int × Int × List Int) :=
  match stk with
  | [] => .error "empty stack"
  | [_] => .error "only one value on the stack"
  | stk =>
    let a := stk.getLast!
    let t1 := stk.dropLast
    let b := t1.getLast!
    let rest := t1.dropLast
    .ok (a, b, rest)

private def executeBuiltin (w : String) (stk : List Int) : Except String (List Int) :=
  match w with
  | "+" => do
      let (a, b, rest) ← pop2 stk
      pure (rest ++ [b + a])
  | "-" => do
      let (a, b, rest) ← pop2 stk
      pure (rest ++ [b - a])
  | "*" => do
      let (a, b, rest) ← pop2 stk
      pure (rest ++ [b * a])
  | "/" => do
      let (a, b, rest) ← pop2 stk
      if a == 0 then .error "divide by zero" else pure (rest ++ [b / a])
  | "dup" => do
      let (a, rest) ← pop1 stk
      pure (rest ++ [a, a])
  | "drop" => do
      let (_, rest) ← pop1 stk
      pure rest
  | "swap" => do
      let (a, b, rest) ← pop2 stk
      pure (rest ++ [a, b])
  | "over" => do
      let (a, b, rest) ← pop2 stk
      pure (rest ++ [b, a, b])
  | _ => .error "undefined operation"

private def compileOne (dict : List (String × List String)) (tok : String) : Except String (List String) :=
  if (parseNumber tok).isSome then
    pure [tok]
  else
    let key := normalize tok
    match dictFind? dict key with
    | some body => pure body
    | none =>
      if isBuiltin key then
        pure [tok]
      else
        .error "undefined operation"

private def compileTokens (dict : List (String × List String)) (toks : List String) : Except String (List String) :=
  toks.foldlM (fun acc tok => do
    let part ← compileOne dict tok
    pure (acc ++ part)) []

private def tokenize (line : String) : List String :=
  (line.splitOn " ").filter (· ≠ "")

private def defineWord (dict : List (String × List String)) (tokens : List String) : Except String (List (String × List String)) :=
  if tokens.length < 3 then
    .error "undefined operation"
  else
    let rawName := tokens[1]!
    if isNumberName rawName then
      .error "illegal operation"
    else
      let name := normalize rawName
      match tokens.findIdx? (· == ";") with
      | none => .error "undefined operation"
      | some semiIdx =>
          if semiIdx < 2 then
            .error "undefined operation"
          else
            let body := (tokens.drop 2).take (semiIdx - 2)
            do
              let compiled ← compileTokens dict body
              pure (dictSet dict name compiled)

private partial def runTokens (dict : List (String × List String)) (stk : List Int) (toks : List String) : Except String (List Int) :=
  match toks with
  | [] => pure stk
  | tok :: rest =>
    if let some n := parseNumber tok then
      runTokens dict (stk ++ [n]) rest
    else
      let key := normalize tok
      match dictFind? dict key with
      | some body => runTokens dict stk (body ++ rest)
      | none =>
        if isBuiltin key then
          do
            let stk' ← executeBuiltin key stk
            runTokens dict stk' rest
        else
          .error "undefined operation"

private def processLine (dict : List (String × List String)) (stk : List Int) (line : String) : Except String (List Int × List (String × List String)) :=
  let tokens := tokenize line
  if tokens.isEmpty then
    pure (stk, dict)
  else if tokens[0]! == ":" then
    do
      let dict' ← defineWord dict tokens
      pure (stk, dict')
  else
    do
      let stk' ← runTokens dict stk tokens
      pure (stk', dict)

def evaluate (instructions : List String) : Except String (List Int) := do
  let (stk, _) ← instructions.foldlM
    (fun (acc : List Int × List (String × List String)) line => do
      let (stk, dict) := acc
      processLine dict stk line)
    ([], [])
  pure stk

end Original

private inductive Builtin where
  | add | sub | mul | div | dup | drop | swap | over
  deriving Repr, BEq

private inductive Instr where
  | push (n : Int)
  | builtin (op : Builtin)
  deriving Repr, BEq

private abbrev Dict := List (String × Array Instr)

private def dictFind? (dict : Dict) (key : String) : Option (Array Instr) :=
  (dict.find? fun (k, _) => k == key).map (·.2)

private def dictSet (dict : Dict) (key : String) (val : Array Instr) : Dict :=
  (key, val) :: (dict.filter fun (k, _) => k ≠ key)

private def builtinOp? (w : String) : Option Builtin :=
  match w with
  | "+" => some .add
  | "-" => some .sub
  | "*" => some .mul
  | "/" => some .div
  | "dup" => some .dup
  | "drop" => some .drop
  | "swap" => some .swap
  | "over" => some .over
  | _ => none

private def tokenBuiltin? (tok : String) : Option Builtin :=
  match tok with
  | "+" => some .add
  | "-" => some .sub
  | "*" => some .mul
  | "/" => some .div
  | _ => builtinOp? tok.toLower

private def parseNumber (tok : String) : Option Int :=
  tok.toInt?

private def isNumberName (name : String) : Bool :=
  (parseNumber name).isSome

private def stackPop (stk : List Int) : Except String (Int × List Int) :=
  match stk with
  | [] => .error "empty stack"
  | h :: t => .ok (h, t)

private def stackPop2 (stk : List Int) : Except String (Int × Int × List Int) :=
  match stk with
  | [] => .error "empty stack"
  | [_] => .error "only one value on the stack"
  | a :: b :: rest => .ok (a, b, rest)

private def applyBuiltin (op : Builtin) (stk : List Int) : Except String (List Int) :=
  match op with
  | .add => do
      let (a, b, rest) ← stackPop2 stk
      pure ((b + a) :: rest)
  | .sub => do
      let (a, b, rest) ← stackPop2 stk
      pure ((b - a) :: rest)
  | .mul => do
      let (a, b, rest) ← stackPop2 stk
      pure ((b * a) :: rest)
  | .div => do
      let (a, b, rest) ← stackPop2 stk
      if a == 0 then .error "divide by zero" else pure ((b / a) :: rest)
  | .dup =>
      match stk with
      | [] => .error "empty stack"
      | h :: t => pure (h :: h :: t)
  | .drop => do
      let (_, rest) ← stackPop stk
      pure rest
  | .swap => do
      let (a, b, rest) ← stackPop2 stk
      pure (b :: a :: rest)
  | .over => do
      let (a, b, rest) ← stackPop2 stk
      pure (b :: a :: b :: rest)

private def executeCode (stk : List Int) (code : Array Instr) : Except String (List Int) := do
  let mut stk := stk
  let mut pc := 0
  while h : pc < code.size do
    match code[pc] with
    | .push n =>
      stk := n :: stk
      pc := pc + 1
    | .builtin op =>
      stk ← applyBuiltin op stk
      pc := pc + 1
  return stk

private def runTokensFast (dict : Dict) (stk : List Int) (toks : Array String) : Except String (List Int) := do
  let mut stk := stk
  let mut i := 0
  while h : i < toks.size do
    let tok := toks[i]
    if let some n := parseNumber tok then
      stk := n :: stk
    else
      let key := tok.toLower
      match dictFind? dict key with
      | some code =>
        stk ← executeCode stk code
      | none =>
        match tokenBuiltin? tok with
        | some op => stk ← applyBuiltin op stk
        | none => .error "undefined operation"
    i := i + 1
  return stk

private def compileOne (dict : Dict) (tok : String) : Except String (Array Instr) :=
  if let some n := parseNumber tok then
    pure #[.push n]
  else
    let key := tok.toLower
    match dictFind? dict key with
    | some body => pure body
    | none =>
      match builtinOp? key with
      | some op => pure #[.builtin op]
      | none => .error "undefined operation"

private def compileTokens (dict : Dict) (toks : Array String) : Except String (Array Instr) := do
  let mut acc : Array Instr := #[]
  for tok in toks do
    let part ← compileOne dict tok
    acc := acc ++ part
  pure acc

private def tokenize (line : String) : Array String :=
  (line.splitOn " ").filter (· ≠ "") |>.toArray

private def defineWord (dict : Dict) (tokens : Array String) : Except String Dict :=
  if tokens.size < 3 then
    .error "undefined operation"
  else
    let rawName := tokens[1]!
    if isNumberName rawName then
      .error "illegal operation"
    else
      let name := rawName.toLower
      match tokens.findIdx? (· == ";") with
      | none => .error "undefined operation"
      | some semiIdx =>
          if semiIdx < 2 then
            .error "undefined operation"
          else
            let body := tokens.extract 2 semiIdx
            do
              let compiled ← compileTokens dict body
              pure (dictSet dict name compiled)

private def processLine (dict : Dict) (stk : List Int) (line : String) : Except String (List Int × Dict) := do
  let tokens := tokenize line
  if tokens.isEmpty then
    pure (stk, dict)
  else if tokens[0]! == ":" then
    let dict' ← defineWord dict tokens
    pure (stk, dict')
  else
    let stk' ← runTokensFast dict stk tokens
    pure (stk', dict)

def evaluate (instructions : List String) : Except String (List Int) := do
  let mut dict : Dict := []
  let mut stk : List Int := []
  for line in instructions do
    (stk, dict) ← processLine dict stk line
  pure stk.reverse

def evaluateOriginal (instructions : List String) : Except String (List Int) :=
  Original.evaluate instructions

end Forth