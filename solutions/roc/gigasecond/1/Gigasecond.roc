module [add]

gigasecond : I64
gigasecond = 1_000_000_000

secsPerMin  : I64
secsPerMin  = 60

secsPerHour : I64
secsPerHour = 3600

secsPerDay  : I64
secsPerDay  = 86400

# Extract a single decimal digit from a UTF-8 byte list.
parseByte : List U8, U64 -> I64
parseByte = |bytes, pos|
    List.get(bytes, pos) |> Result.with_default('0') |> Num.to_i64 |> Num.sub(48)

# Parse a 2-digit decimal integer from bytes[pos] and bytes[pos+1].
parseByte2 : List U8, U64 -> I64
parseByte2 = |bytes, pos|
    parseByte(bytes, pos) * 10 + parseByte(bytes, pos + 1)

# Parse a 4-digit decimal integer from bytes[pos..pos+3].
parseByte4 : List U8, U64 -> I64
parseByte4 = |bytes, pos|
    parseByte2(bytes, pos) * 100 + parseByte2(bytes, pos + 2)

isLeap : I64 -> Bool
isLeap = |y| (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)

# Days in a given month.
daysInMonth : I64, I64 -> I64
daysInMonth = |year, month|
    when month is
        1 | 3 | 5 | 7 | 8 | 10 | 12 -> 31
        4 | 6 | 9 | 11 -> 30
        2 -> if isLeap(year) then 29 else 28
        _ -> 30

# Total days in months 1..(month-1) for a given year
monthDaysBefore : I64, I64 -> I64
monthDaysBefore = |year, month|
    leap = if isLeap(year) then 1 else 0
    when month is
        1  -> 0
        2  -> 31
        3  -> 59  + leap
        4  -> 90  + leap
        5  -> 120 + leap
        6  -> 151 + leap
        7  -> 181 + leap
        8  -> 212 + leap
        9  -> 243 + leap
        10 -> 273 + leap
        11 -> 304 + leap
        12 -> 334 + leap
        _  -> 0

# ---------------------------------------------------------------------------
# Epoch-seconds conversion
# ---------------------------------------------------------------------------

toEpochSecs : I64, I64, I64, I64, I64, I64 -> I64
toEpochSecs = |year, month, day, hour, minute, second|
    y         = year - 1
    yearDays  = y * 365 + y // 4 - y // 100 + y // 400
    totalDays = yearDays + monthDaysBefore(year, month) + (day - 1)
    totalDays * secsPerDay + hour * secsPerHour + minute * secsPerMin + second

fromEpochSecs : I64 -> { year : I64, month : I64, day : I64, hour : I64, minute : I64, second : I64 }
fromEpochSecs = |totalSecs|
    r         = totalSecs % secsPerDay
    timeOfDay = if r < 0 then r + secsPerDay else r
    dayNum    = (totalSecs - timeOfDay) // secsPerDay
    hour      = timeOfDay // secsPerHour
    minute    = (timeOfDay % secsPerHour) // secsPerMin
    second    = timeOfDay % secsPerMin
    { year, month, day } = daysToYmd(dayNum)
    { year, month, day, hour, minute, second }

daysToYmd : I64 -> { year : I64, month : I64, day : I64 }
daysToYmd = |dayNum|
    n400   = dayNum // 146097
    rem400 = dayNum % 146097
    n100   = Num.min((rem400 // 36524), 3)
    rem100 = rem400 - n100 * 36524
    n4     = rem100 // 1461
    rem4   = rem100 % 1461
    n1     = Num.min((rem4 // 365), 3)
    remDay = rem4 - n1 * 365
    year   = n400 * 400 + n100 * 100 + n4 * 4 + n1 + 1
    { month, day } = dayOfMonth(year, remDay)
    { year, month, day }

dayOfMonth : I64, I64 -> { month : I64, day : I64 }
dayOfMonth = |year, remDay|
    leap = if isLeap(year) then 1 else 0
    m1  = 31
    m2  = m1 + 28 + leap
    m3  = m2 + 31
    m4  = m3 + 30
    m5  = m4 + 31
    m6  = m5 + 30
    m7  = m6 + 31
    m8  = m7 + 31
    m9  = m8 + 30
    m10 = m9 + 31
    m11 = m10 + 30
    if      remDay < m1  then { month:  1, day: remDay + 1 }
    else if remDay < m2  then { month:  2, day: remDay - m1 + 1 }
    else if remDay < m3  then { month:  3, day: remDay - m2 + 1 }
    else if remDay < m4  then { month:  4, day: remDay - m3 + 1 }
    else if remDay < m5  then { month:  5, day: remDay - m4 + 1 }
    else if remDay < m6  then { month:  6, day: remDay - m5 + 1 }
    else if remDay < m7  then { month:  7, day: remDay - m6 + 1 }
    else if remDay < m8  then { month:  8, day: remDay - m7 + 1 }
    else if remDay < m9  then { month:  9, day: remDay - m8 + 1 }
    else if remDay < m10 then { month: 10, day: remDay - m9 + 1 }
    else if remDay < m11 then { month: 11, day: remDay - m10 + 1 }
    else                      { month: 12, day: remDay - m11 + 1 }

# Write a 2-digit zero-padded number into buf at position pos.
write2 : List U8, U64, I64 -> List U8
write2 = |buf, pos, n|
    buf
    |> List.set(pos,     Num.to_u8(n // 10 + 48))
    |> List.set(pos + 1, Num.to_u8(n % 10  + 48))

# Write a 4-digit zero-padded number into buf at position pos.
write4 : List U8, U64, I64 -> List U8
write4 = |buf, pos, n|
    buf
    |> write2(pos,     n // 100)
    |> write2(pos + 2, n % 100)

# Produce "YYYY-MM-DDTHH:MM:SS" in a single allocation.
formatDateTime : I64, I64, I64, I64, I64, I64 -> Str
formatDateTime = |year, month, day, hour, minute, second|
    buf =
        List.repeat(0u8, 19)
        |> write4(0, year)
        |> List.set(4, '-')
        |> write2(5, month)
        |> List.set(7, '-')
        |> write2(8, day)
        |> List.set(10, 'T')
        |> write2(11, hour)
        |> List.set(13, ':')
        |> write2(14, minute)
        |> List.set(16, ':')
        |> write2(17, second)
    Str.from_utf8(buf) |> Result.with_default("")

# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

add : Str -> Str
add = |moment|
    bytes  = Str.to_utf8(moment)
    year   = parseByte4(bytes, 0)
    month  = parseByte2(bytes, 5)
    day    = parseByte2(bytes, 8)
    { hour, minute, second } =
        if List.len(bytes) == 10 then
            { hour: 0, minute: 0, second: 0 }
        else
            { hour: parseByte2(bytes, 11), minute: parseByte2(bytes, 14), second: parseByte2(bytes, 17) }
    newSecs = toEpochSecs(year, month, day, hour, minute, second) + gigasecond
    r = fromEpochSecs(newSecs)
    formatDateTime(r.year, r.month, r.day, r.hour, r.minute, r.second)
    