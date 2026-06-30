import Std.Sync.Mutex

namespace BankAccount

private structure State where
  isOpen : Bool
  balance : Nat

structure Account where
  stateRef : IO.Ref State

def Account.create : IO Account :=
  do
  let stateRef ← IO.mkRef ({ isOpen := false, balance := 0 } : State)
  pure { stateRef }

def Account.open (account : Account) : IO Unit :=
  do
  let err ← account.stateRef.modifyGet fun state =>
    if state.isOpen then
      (some "account already open", state)
    else
      (none, { isOpen := true, balance := 0 })
  match err with
  | some msg => throw <| IO.userError msg
  | none => pure ()

def Account.close (account : Account) : IO Unit :=
  do
  let err ← account.stateRef.modifyGet fun state =>
    if !state.isOpen then
      (some "account not open", state)
    else
      (none, { isOpen := false, balance := 0 })
  match err with
  | some msg => throw <| IO.userError msg
  | none => pure ()

def Account.deposit (amount : Nat) (account : Account) : IO Unit :=
  do
  let err ← account.stateRef.modifyGet fun state =>
    if !state.isOpen then
      (some "account not open", state)
    else
      (none, { state with balance := state.balance + amount })
  match err with
  | some msg => throw <| IO.userError msg
  | none => pure ()

def Account.withdraw (amount : Nat) (account : Account) : IO Unit :=
  do
  let err ← account.stateRef.modifyGet fun state =>
    if !state.isOpen then
      (some "account not open", state)
    else if amount > state.balance then
      (some "amount must be less than balance", state)
    else
      (none, { state with balance := state.balance - amount })
  match err with
  | some msg => throw <| IO.userError msg
  | none => pure ()

def Account.balance (account : Account) : IO Nat :=
  do
  let out ← account.stateRef.modifyGet fun state =>
    if !state.isOpen then
      (Except.error "account not open", state)
    else
      (Except.ok state.balance, state)
  match out with
  | .ok n => pure n
  | .error msg => throw <| IO.userError msg

end BankAccount