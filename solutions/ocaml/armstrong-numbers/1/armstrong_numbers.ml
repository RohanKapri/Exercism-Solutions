let rec count_digits n =
  if n = 0 then 0 else 1 + count_digits (n / 10)

let rec power base exp =
  if exp = 0 then 1 else base * power base (exp - 1)

let validate candidate =
  if candidate < 0 then false
  else if candidate = 0 then true
  else
    let num_digits = count_digits candidate in
    let rec sum_powers n acc =
      if n = 0 then acc
      else
        let digit = n mod 10 in
        sum_powers (n / 10) (acc + power digit num_digits)
    in
    sum_powers candidate 0 = candidate