namespace Meetup

inductive DayOfWeek where
  | Monday : DayOfWeek
  | Tuesday : DayOfWeek
  | Wednesday : DayOfWeek
  | Thursday : DayOfWeek
  | Friday : DayOfWeek
  | Saturday : DayOfWeek
  | Sunday : DayOfWeek
  deriving BEq, Repr

def Month := { m : Nat // m ≥ 1 ∧ m ≤ 12 }

inductive Week where
  | first : Week
  | second : Week
  | third : Week
  | fourth : Week
  | teenth : Week
  | last : Week
  deriving BEq, Repr

def isLeapYear (year : Nat) : Bool :=
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

def daysInMonth (year month : Nat) : Nat :=
  match month with
  | 1 | 3 | 5 | 7 | 8 | 10 | 12 => 31
  | 4 | 6 | 9 | 11 => 30
  | 2 => if isLeapYear year then 29 else 28
  | _ => 0

def dayOfWeekIndex (dayOfWeek : DayOfWeek) : Nat :=
  match dayOfWeek with
  | .Monday => 0
  | .Tuesday => 1
  | .Wednesday => 2
  | .Thursday => 3
  | .Friday => 4
  | .Saturday => 5
  | .Sunday => 6

def monthOffset (month : Nat) : Nat :=
  #[0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4][month - 1]!

def weekdayIndex (year month day : Nat) : Nat :=
  let y := if month < 3 then year - 1 else year
  -- Sakamoto gives Sunday=0..Saturday=6; convert to Monday=0..Sunday=6.
  let sundayFirst := (y + y / 4 - y / 100 + y / 400 + monthOffset month + day) % 7
  (sundayFirst + 6) % 7

def meetupDay (dayOfWeek : DayOfWeek) (month : Month) (week : Week) (year : Nat) : Nat :=
  let m := month.val
  let target := dayOfWeekIndex dayOfWeek
  let firstWeekday := weekdayIndex year m 1
  let firstMatch := 1 + ((target + 7 - firstWeekday) % 7)
  match week with
  | .first  => firstMatch
  | .second => firstMatch + 7
  | .third  => firstMatch + 14
  | .fourth => firstMatch + 21
  | .teenth =>
    let teenthWeekday := (firstWeekday + 12) % 7
    13 + ((target + 7 - teenthWeekday) % 7)
  | .last =>
    let lastDay := daysInMonth year m
    let lastWeekday := (firstWeekday + (lastDay - 1)) % 7
    let back := (lastWeekday + 7 - target) % 7
    lastDay - back

private def formatDate (year month day : Nat) : String :=
  let buf : ByteArray := (ByteArray.emptyWithCapacity 10)
    -- year (4 digits, years 1000–9999)
    |>.push ((year / 1000 % 10 + 48).toUInt8)
    |>.push ((year / 100  % 10 + 48).toUInt8)
    |>.push ((year / 10   % 10 + 48).toUInt8)
    |>.push ((year        % 10 + 48).toUInt8)
    |>.push 45  -- '-'
    |>.push ((month / 10 + 48).toUInt8)
    |>.push ((month % 10 + 48).toUInt8)
    |>.push 45  -- '-'
    |>.push ((day / 10 + 48).toUInt8)
    |>.push ((day % 10 + 48).toUInt8)
  String.fromUTF8! buf

def meetup (dayOfWeek : DayOfWeek) (month : Month) (week : Week) (year : Nat) : String :=
  formatDate year month.val (meetupDay dayOfWeek month week year)

end Meetup