namespace Clock

structure Clock where
  total : Int

def minutesPerHour : Int := 60
def minutesPerDay : Int := 24 * minutesPerHour

def normalizeMinutes (total : Int) : Int :=
  ((total % minutesPerDay) + minutesPerDay) % minutesPerDay

def fromTotalMinutes (total : Int) : Clock :=
  { total := normalizeMinutes total }

def toTotalMinutes (clock : Clock) : Int :=
  clock.total

def twoDigits (n : Int) : String :=
  if n < 10 then s!"0{n}" else s!"{n}"

-- define equality between Clocks
instance : BEq Clock where
  beq clock1 clock2 :=
    clock1.total == clock2.total

-- define how a Clock should be converted to a String
instance : ToString Clock where
  toString clock :=
    let h := clock.total / minutesPerHour
    let m := clock.total % minutesPerHour
    s!"{twoDigits h}:{twoDigits m}"

def create (hour : Int) (minute : Int) : Clock :=
  fromTotalMinutes (hour * minutesPerHour + minute)

def add (clock : Clock) (minute : Int) : Clock :=
  fromTotalMinutes (toTotalMinutes clock + minute)

def subtract (clock : Clock) (minute : Int) : Clock :=
  fromTotalMinutes (toTotalMinutes clock - minute)

end Clock