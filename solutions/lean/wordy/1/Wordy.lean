namespace Wordy

inductive Op where
  | plus
  | minus
  | multiplied
  | divided

private def applyOp (lhs : Int) (op : Op) (rhs : Int) : Int :=
  match op with
  | .plus => lhs + rhs
  | .minus => lhs - rhs
  | .multiplied => lhs * rhs
  | .divided => lhs / rhs

private def parseNatDigitsAux (acc : Nat) : List Char → Option Nat
  | [] => some acc
  | c :: cs =>
      if c.isDigit then
        parseNatDigitsAux (acc * 10 + (c.toNat - '0'.toNat)) cs
      else
        none

private def parseNatDigits (cs : List Char) : Option Nat :=
  match cs with
  | [] => none
  | _ => parseNatDigitsAux 0 cs

private def parseIntToken (token : String) : Option Int :=
  match token.toList with
  | '-' :: cs => do
      let n ← parseNatDigits cs
      pure (-(Int.ofNat n))
  | cs => do
      let n ← parseNatDigits cs
      pure (Int.ofNat n)

private def parseOpTokens : List String → Option (Op × List String)
  | "plus" :: rest => some (.plus, rest)
  | "minus" :: rest => some (.minus, rest)
  | "multiplied" :: "by" :: rest => some (.multiplied, rest)
  | "divided" :: "by" :: rest => some (.divided, rest)
  | _ => none

private def evalWithFuel : Nat → Int → List String → Option Int
  | _, acc, [] => some acc
  | 0, _, _ => none
  | Nat.succ fuel, acc, tokens => do
      let (op, restAfterOp) ← parseOpTokens tokens
      match restAfterOp with
      | [] => none
      | numTok :: rest => do
          let rhs ← parseIntToken numTok
          evalWithFuel fuel (applyOp acc op rhs) rest

private def extractBody (question : String) : Option String :=
  if !question.startsWith "What is " || !question.endsWith "?" then
    none
  else
    match (question.toList.drop 8).reverse with
    | [] => none
    | _ :: revBody => some (String.ofList revBody.reverse)

def answerOriginal (question : String) : Option Int :=
  do
    let body ← extractBody question
    let tokens := body.splitOn " " |>.filter (fun t => t ≠ "")
    match tokens with
    | [] => none
    | firstNum :: rest => do
        let start ← parseIntToken firstNum
        evalWithFuel (rest.length + 1) start rest

private def evalTokenArrayWithFuel (tokens : Array String) : Nat → Nat → Int → Option Int
  | 0, _, _ => none
  | Nat.succ fuel, idx, acc =>
      if idx >= tokens.size then
        none
      else
        let t := tokens[idx]!
        if t = "plus" || t = "minus" then
          let rhsIdx := idx + 1
          if rhsIdx >= tokens.size then
            none
          else
            match (tokens[rhsIdx]!).toInt? with
            | none => none
            | some rhs =>
                let op := if t = "plus" then Op.plus else Op.minus
                let nextAcc := applyOp acc op rhs
                if rhsIdx + 1 = tokens.size then some nextAcc
                else evalTokenArrayWithFuel tokens fuel (idx + 2) nextAcc
        else if t = "multiplied" || t = "divided" then
          let byIdx := idx + 1
          let rhsIdx := idx + 2
          if rhsIdx >= tokens.size then
            none
          else if tokens[byIdx]! ≠ "by" then
            none
          else
            match (tokens[rhsIdx]!).toInt? with
            | none => none
            | some rhs =>
                let op := if t = "multiplied" then Op.multiplied else Op.divided
                let nextAcc := applyOp acc op rhs
                if rhsIdx + 1 = tokens.size then some nextAcc
                else evalTokenArrayWithFuel tokens fuel (idx + 3) nextAcc
        else
          none

def answer (question : String) : Option Int :=
  do
    let body ← extractBody question
    let tokens := body.splitOn " " |>.filter (fun t => t ≠ "") |>.toArray
    if tokens.isEmpty then
      none
    else
      let start ← (tokens[0]!).toInt?
      if tokens.size = 1 then
        some start
      else
        evalTokenArrayWithFuel tokens (tokens.size + 1) 1 start

end Wordy