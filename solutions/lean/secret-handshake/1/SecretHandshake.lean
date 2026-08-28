namespace SecretHandshake

inductive Action where
  | wink
  | doubleBlink
  | closeYourEyes
  | jump
  deriving BEq, Repr

private def allActions : Array Action := #[
  .wink, 
  .doubleBlink, 
  .closeYourEyes, 
  .jump
]

private def Action.bit : Action -> BitVec 5
  | .wink          => 0b00001
  | .doubleBlink   => 0b00010
  | .closeYourEyes => 0b00100
  | .jump          => 0b01000

def commands (number : BitVec 5) : Array Action :=
  let actions := allActions.filter fun action =>
    (action.bit &&& number) != 0
  if (number &&& 0b10000) != 0
  then actions.reverse 
  else actions

end SecretHandshake