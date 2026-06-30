import Std

namespace TwoBucket

inductive BucketId where
  | one | two
  deriving BEq, Repr, Inhabited

abbrev Capacity := Nat
abbrev Volume := Nat

structure Result where
  moves  : Nat
  goal   : BucketId
  other  : Volume
  deriving BEq, Repr

structure State where
  one : Volume
  two : Volume
  deriving BEq, Repr, Inhabited

def isForbidden (start : BucketId) (first second : Capacity) (s : State) : Bool :=
  match start with
  | .one => s.one == 0 && s.two == second
  | .two => s.two == 0 && s.one == first

def toResult (goal : Volume) (moves : Nat) (s : State) : Option Result :=
  if s.one == goal then
    some ⟨moves, .one, s.two⟩
  else if s.two == goal then
    some ⟨moves, .two, s.one⟩
  else
    none

def nextStates (first second : Capacity) (s : State) : List State :=
  let spaceInTwo := second - s.two
  let moveOneToTwo := Nat.min s.one spaceInTwo
  let spaceInOne := first - s.one
  let moveTwoToOne := Nat.min s.two spaceInOne
  [ { one := first, two := s.two }
  , { one := s.one, two := second }
  , { one := 0, two := s.two }
  , { one := s.one, two := 0 }
  , { one := s.one - moveOneToTwo, two := s.two + moveOneToTwo }
  , { one := s.one + moveTwoToOne, two := s.two - moveTwoToOne }
  ].filter (fun n => n != s)

def stateIndex (second : Capacity) (s : State) : Nat :=
  s.one * (second + 1) + s.two

def otherBucketId : BucketId → BucketId
  | .one => .two
  | .two => .one

def resultForStartView
    (start : BucketId)
    (goal : Volume)
    (moves startVolume otherVolume : Nat) : Option Result :=
  if startVolume == goal then
    some ⟨moves, start, otherVolume⟩
  else if otherVolume == goal then
    some ⟨moves, otherBucketId start, startVolume⟩
  else
    none

def simulateDirect
    (startCap otherCap : Capacity)
    (goal : Volume)
    (start : BucketId) : Option Result :=
  Id.run do
    let mut startVolume := startCap
    let mut otherVolume := 0
    let mut moves := 1
    let mut remaining := startCap + otherCap + 2

    while remaining > 0 do
      match resultForStartView start goal moves startVolume otherVolume with
      | some result =>
          return some result
      | none =>
          remaining := remaining - 1
          if startVolume == 0 then
            startVolume := startCap
            moves := moves + 1
          else if otherVolume == otherCap then
            otherVolume := 0
            moves := moves + 1
          else
            let moved := Nat.min startVolume (otherCap - otherVolume)
            let nextStart := startVolume - moved
            let nextOther := otherVolume + moved
            if nextStart == 0 && nextOther == otherCap then
              return none
            startVolume := nextStart
            otherVolume := nextOther
            moves := moves + 1

    return none

def enqueueIfNew
    (start : BucketId)
    (first second : Capacity)
    (current next : State)
    (moves : Nat)
    (visited : Array Bool)
    (queue : Array (State × Nat)) : Array Bool × Array (State × Nat) :=
  if next == current || isForbidden start first second next then
    (visited, queue)
  else
    let idx := stateIndex second next
    if visited.getD idx false then
      (visited, queue)
    else
      (visited.set! idx true, queue.push (next, moves + 1))

def measureBfs (first second : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  if goal > first && goal > second then
    none
  else
    let initial :=
      match start with
      | .one => { one := first, two := 0 }
      | .two => { one := 0, two := second }
    if isForbidden start first second initial then
      none
    else
      let totalStates := (first + 1) * (second + 1)
      let visited0 := (Array.replicate totalStates false).set! (stateIndex second initial) true
      Id.run do
        let mut visited := visited0
        let mut queue : Array (State × Nat) := #[(initial, 1)]
        let mut head := 0
        let mut answer : Option Result := none

        while head < queue.size && answer.isNone do
          let (s, moves) := queue[head]!
          head := head + 1

          match toResult goal moves s with
          | some r =>
            answer := some r
          | none =>
            let spaceInTwo := second - s.two
            let moveOneToTwo := Nat.min s.one spaceInTwo
            let spaceInOne := first - s.one
            let moveTwoToOne := Nat.min s.two spaceInOne

            let n1 : State := { one := first, two := s.two }
            let n2 : State := { one := s.one, two := second }
            let n3 : State := { one := 0, two := s.two }
            let n4 : State := { one := s.one, two := 0 }
            let n5 : State := { one := s.one - moveOneToTwo, two := s.two + moveOneToTwo }
            let n6 : State := { one := s.one + moveTwoToOne, two := s.two - moveTwoToOne }

            let (visited1, queue1) := enqueueIfNew start first second s n1 moves visited queue
            let (visited2, queue2) := enqueueIfNew start first second s n2 moves visited1 queue1
            let (visited3, queue3) := enqueueIfNew start first second s n3 moves visited2 queue2
            let (visited4, queue4) := enqueueIfNew start first second s n4 moves visited3 queue3
            let (visited5, queue5) := enqueueIfNew start first second s n5 moves visited4 queue4
            let (visited6, queue6) := enqueueIfNew start first second s n6 moves visited5 queue5

            visited := visited6
            queue := queue6

        return answer

def measure (first second : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  if goal > first && goal > second then
    none
  else if goal == 0 then
    none
  else
    let divisor := Nat.gcd first second
    if divisor == 0 || goal % divisor != 0 then
      none
    else
      let startCap := match start with | .one => first | .two => second
      let otherCap := match start with | .one => second | .two => first
      if goal == startCap then
        some ⟨1, start, 0⟩
      else if goal == otherCap then
        some ⟨2, otherBucketId start, startCap⟩
      else
        match simulateDirect startCap otherCap goal start with
        | some result => some result
        | none => measureBfs first second goal start

end TwoBucket