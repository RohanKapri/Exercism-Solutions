namespace RomanNumerals

def roman (number : Fin 4000) : String :=
  let n := number.val

  let thousands : Array String :=
    #["", "M", "MM", "MMM"]
  let hundreds : Array String :=
    #["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
  let tens : Array String :=
    #["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
  let ones : Array String :=
    #["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]

  let t := n / 1000
  let h := (n / 100) % 10
  let te := (n / 10) % 10
  let o := n % 10

  thousands[t]! ++ hundreds[h]! ++ tens[te]! ++ ones[o]!

end RomanNumerals