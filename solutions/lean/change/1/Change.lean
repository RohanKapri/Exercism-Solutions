namespace Change

inductive Result where
  | ok : Array Nat → Result
  | error : String → Result
  deriving BEq, Repr

def findFewestCoins (coins : Array Nat) (target : Int) : Result :=
  if target < 0 then
    .error "target can't be negative"
  else
    Id.run do
      let targetNat : Nat := Int.toNat target
      let limit := targetNat + 1
      let mut bestCount : Array Nat := Array.replicate (targetNat + 1) limit
      let mut prevCoin : Array Nat := Array.replicate (targetNat + 1) 0
      let mut prevAmount : Array Nat := Array.replicate (targetNat + 1) 0
      bestCount := bestCount.set! 0 0

      for amount in [1:targetNat + 1] do
        let mut best := limit
        let mut chosenCoin := 0
        let mut chosenPrev := 0

        for coin in coins do
          if coin > 0 ∧ coin ≤ amount then
            let prev := bestCount[amount - coin]!
            if prev < limit then
              let candidate := prev + 1
              if candidate < best then
                best := candidate
                chosenCoin := coin
                chosenPrev := amount - coin

        bestCount := bestCount.set! amount best
        prevCoin := prevCoin.set! amount chosenCoin
        prevAmount := prevAmount.set! amount chosenPrev

      if bestCount[targetNat]! == limit then
        .error "can't make target with given coins"
      else
        let mut out : Array Nat := #[]
        let mut amount := targetNat
        while amount > 0 do
          let coin := prevCoin[amount]!
          if coin == 0 then
            return .error "can't make target with given coins"
          out := out.push coin
          amount := prevAmount[amount]!
        .ok <| (out.toList.mergeSort fun a b => decide (a ≤ b)).toArray

end Change