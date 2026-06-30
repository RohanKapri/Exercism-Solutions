namespace BinarySearch

def find (value : Int) (array : Array Int) : Option Nat := Id.run do
  let mut low := 0
  let mut high := array.size
  while low < high do
    let middle := (low + high) / 2
    let element := array[middle]!
    if value < element then high := middle
    if value > element then low := middle + 1
    if value == element then return some middle
  none

end BinarySearch