import Std.Data.TreeMap

namespace SgfParsing

structure SgfTree where
  properties : Std.TreeMap String (Array String)
  children   : Array SgfTree
  deriving Repr

namespace Original

private def isUpperAlpha (c : Char) : Bool :=
  'A' ≤ c && c ≤ 'Z'

private def isAlpha (c : Char) : Bool :=
  isUpperAlpha c || ('a' ≤ c && c ≤ 'z')

private def isNonNewlineWhitespace (c : Char) : Bool :=
  c.isWhitespace && c ≠ '\n'

private def processSgfChar (c : Char) : String :=
  if isNonNewlineWhitespace c then " " else c.toString

private partial def parsePropertyValue (chars : List Char) : Except String (String × List Char) :=
  let rec go (acc : String) (cs : List Char) : Except String (String × List Char) :=
    match cs with
    | [] => .error "unterminated property value"
    | ']' :: rest => .ok (acc, rest)
    | '\\' :: c :: rest =>
        if c == '\n' then
          go acc rest
        else if isNonNewlineWhitespace c then
          go (acc ++ " ") rest
        else
          go (acc ++ c.toString) rest
    | '\\' :: [] => .error "unterminated property value"
    | c :: rest => go (acc ++ processSgfChar c) rest
  go "" chars

private def takePropertyKey (cs : List Char) : Option (String × List Char) :=
  match cs with
  | c :: rest =>
      if isAlpha c then
        let rec go (acc : String) (cs : List Char) : String × List Char :=
          match cs with
          | c :: rest =>
              if isAlpha c then go (acc ++ c.toString) rest else (acc, cs)
          | [] => (acc, cs)
        some (go c.toString rest)
      else
        none
  | [] => none

private partial def parseProperties (chars : List Char) (props : List (String × Array String)) :
    Except String (List (String × Array String) × List Char) :=
  match takePropertyKey chars with
  | none => .ok (props, chars)
  | some (key, afterKey) =>
      if !key.all isUpperAlpha then
        .error "property must be in uppercase"
      else
        let rec parseValues (values : Array String) (cs : List Char) :
            Except String (Array String × List Char) :=
          match cs with
          | '[' :: rest =>
              match parsePropertyValue rest with
              | .error e => .error e
              | .ok (val, afterVal) => parseValues (values.push val) afterVal
          | _ =>
              if values.isEmpty then
                .error "properties without delimiter"
              else
                .ok (values, cs)
        match parseValues #[] afterKey with
        | .error e => .error e
        | .ok (values, afterValues) =>
            parseProperties afterValues (props ++ [(key, values)])

private def propsToTreeMap (props : List (String × Array String)) : Std.TreeMap String (Array String) :=
  props.foldl (fun tm (k, v) => tm.insert k v) {}

mutual
  partial def parseChildren (cs : List Char) (children : Array SgfTree) :
      Except String (Array SgfTree × List Char) :=
    match cs with
    | ';' :: rest =>
        match parseContent (';' :: rest) with
        | .error e => .error e
        | .ok (child, cs') => parseChildren cs' (children.push child)
    | '(' :: rest =>
        match parseTree rest with
        | .error e => .error e
        | .ok (child, cs') => parseChildren cs' (children.push child)
    | _ => .ok (children, cs)

  partial def parseContent (chars : List Char) : Except String (SgfTree × List Char) :=
    match chars with
    | ';' :: rest =>
        match parseProperties rest [] with
        | .error e => .error e
        | .ok (props, afterProps) =>
            match parseChildren afterProps #[] with
            | .error e => .error e
            | .ok (children, cs') =>
                .ok ({ properties := propsToTreeMap props, children }, cs')
    | _ => .error "node missing"

  partial def parseTree (chars : List Char) : Except String (SgfTree × List Char) :=
    match chars with
    | ')' :: _ => .error "tree with no nodes"
    | _ =>
        match parseContent chars with
        | .error e => .error e
        | .ok (tree, cs) =>
            match cs with
            | ')' :: rest => .ok (tree, rest)
            | _ => .error "tree missing"
end

def parse (encoded : String) : Except String SgfTree :=
  match encoded.toList with
  | [] => .error "tree missing"
  | '(' :: rest =>
      match parseTree rest with
      | .error e => .error e
      | .ok (tree, cs) =>
          match cs with
          | [] => .ok tree
          | _ => .error "tree missing"
  | _ => .error "tree missing"

end Original

namespace Fast

private def isNonNewlineWhitespace (c : Char) : Bool :=
  c.isWhitespace && c ≠ '\n'

@[inline] private def byteAt (bs : ByteArray) (i : Nat) : Option UInt8 :=
  if h : i < bs.size then some bs[i] else none

@[inline] private def isAsciiUpperAlpha (b : UInt8) : Bool :=
  let a := 'A'.toUInt8
  let z := 'Z'.toUInt8
  a ≤ b && b ≤ z

@[inline] private def isAsciiLowerAlpha (b : UInt8) : Bool :=
  let a := 'a'.toUInt8
  let z := 'z'.toUInt8
  a ≤ b && b ≤ z

@[inline] private def isAsciiAlpha (b : UInt8) : Bool :=
  isAsciiUpperAlpha b || isAsciiLowerAlpha b

private partial def skipAlpha (bs : ByteArray) (i : Nat) : Nat :=
  match byteAt bs i with
  | some b =>
      if isAsciiAlpha b then skipAlpha bs (i + 1) else i
  | none => i

private def bytesToStringAscii (bs : ByteArray) (start stop : Nat) : String :=
  Id.run do
    let mut out : String := ""
    let mut j := start
    while j < stop do
      out := out.push (Char.ofNat bs[j]!.toNat)
      j := j + 1
    return out

private def pushProcessedChar (buf : Array Char) (c : Char) : Array Char :=
  if isNonNewlineWhitespace c then buf.push ' ' else buf.push c

private partial def parsePropertyValue (bs : ByteArray) (i : Nat) : Except String (String × Nat) :=
  let rec go (buf : Array Char) (i : Nat) : Except String (String × Nat) :=
    match byteAt bs i with
    | none => .error "unterminated property value"
    | some b =>
        if b == ']'.toUInt8 then
          .ok (String.ofList buf.toList, i + 1)
        else if b == '\\'.toUInt8 then
          match byteAt bs (i + 1) with
          | none => .error "unterminated property value"
          | some b2 =>
              if b2 == '\n'.toUInt8 then
                go buf (i + 2)
              else if b2 ≤ 127 then
                let c := Char.ofNat b2.toNat
                if isNonNewlineWhitespace c then
                  go (buf.push ' ') (i + 2)
                else
                  go (buf.push c) (i + 2)
              else
                match bs.utf8DecodeChar? (i + 1) with
                | none => .error "unterminated property value"
                | some c =>
                    if isNonNewlineWhitespace c then
                      go (buf.push ' ') (i + 1 + c.utf8Size)
                    else
                      go (buf.push c) (i + 1 + c.utf8Size)
        else if b ≤ 127 then
          go (pushProcessedChar buf (Char.ofNat b.toNat)) (i + 1)
        else
          match bs.utf8DecodeChar? i with
          | none => .error "unterminated property value"
          | some c =>
              go (pushProcessedChar buf c) (i + c.utf8Size)
  go #[] i

private partial def parseProperties (bs : ByteArray) (i : Nat)
    (props : Std.TreeMap String (Array String)) :
    Except String (Std.TreeMap String (Array String) × Nat) :=
  match byteAt bs i with
  | some b =>
      if isAsciiAlpha b then
        let start := i
        let afterKey := skipAlpha bs i
        let rec checkUpper (j : Nat) : Except String Unit :=
          if j < afterKey then
            match byteAt bs j with
            | some b =>
                if isAsciiLowerAlpha b then
                  .error "property must be in uppercase"
                else
                  checkUpper (j + 1)
            | none => .ok ()
          else
            .ok ()
        match checkUpper start with
        | .error e => .error e
        | .ok _ =>
            let key := bytesToStringAscii bs start afterKey
            let rec parseValues (values : Array String) (i : Nat) : Except String (Array String × Nat) :=
              match byteAt bs i with
              | some b =>
                  if b == '['.toUInt8 then
                    match parsePropertyValue bs (i + 1) with
                    | .error e => .error e
                    | .ok (val, i') => parseValues (values.push val) i'
                  else if values.isEmpty then
                    .error "properties without delimiter"
                  else
                    .ok (values, i)
              | none =>
                  if values.isEmpty then
                    .error "properties without delimiter"
                  else
                    .ok (values, i)
            match parseValues #[] afterKey with
            | .error e => .error e
            | .ok (values, i') =>
                parseProperties bs i' (props.insert key values)
      else
        .ok (props, i)
  | none => .ok (props, i)

mutual
  partial def parseChildren (bs : ByteArray) (i : Nat) (children : Array SgfTree) :
      Except String (Array SgfTree × Nat) :=
    match byteAt bs i with
    | some b =>
        if b == ';'.toUInt8 then
          match parseContent bs i with
          | .error e => .error e
          | .ok (child, i') => parseChildren bs i' (children.push child)
        else if b == '('.toUInt8 then
          match parseTree bs (i + 1) with
          | .error e => .error e
          | .ok (child, i') => parseChildren bs i' (children.push child)
        else
          .ok (children, i)
    | none => .ok (children, i)

  partial def parseContent (bs : ByteArray) (i : Nat) : Except String (SgfTree × Nat) :=
    match byteAt bs i with
    | some b =>
        if b == ';'.toUInt8 then
          match parseProperties bs (i + 1) {} with
          | .error e => .error e
          | .ok (properties, i') =>
              match parseChildren bs i' #[] with
              | .error e => .error e
              | .ok (children, i'') => .ok ({ properties, children }, i'')
        else
          .error "node missing"
    | none => .error "node missing"

  partial def parseTree (bs : ByteArray) (i : Nat) : Except String (SgfTree × Nat) :=
    match byteAt bs i with
    | some b =>
        if b == ')'.toUInt8 then
          .error "tree with no nodes"
        else
          match parseContent bs i with
          | .error e => .error e
          | .ok (tree, i') =>
              match byteAt bs i' with
              | some b =>
                  if b == ')'.toUInt8 then
                    .ok (tree, i' + 1)
                  else
                    .error "tree missing"
              | none => .error "tree missing"
    | none => .error "tree with no nodes"
end

def parse (encoded : String) : Except String SgfTree :=
  if encoded.isEmpty then
    .error "tree missing"
  else
    let bs := encoded.toUTF8
    match byteAt bs 0 with
    | some b =>
        if b == '('.toUInt8 then
          match parseTree bs 1 with
          | .error e => .error e
          | .ok (tree, i) =>
              if i == bs.size then
                .ok tree
              else
                .error "tree missing"
        else
          .error "tree missing"
    | none => .error "tree missing"

end Fast

def parseOriginal (encoded : String) : Except String SgfTree :=
  Original.parse encoded

def parse (encoded : String) : Except String SgfTree :=
  Fast.parse encoded

end SgfParsing
        