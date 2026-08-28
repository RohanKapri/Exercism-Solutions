namespace Leap

def leapYear (year : UInt16) : Bool :=
  if year &&& 3 != 0 then false
  else if year % 25 != 0 then true
  else year &&& 15 == 0

end Leap