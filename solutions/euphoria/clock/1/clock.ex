include std/math.e

constant MINUTES_IN_HOUR = 60
constant HOURS_IN_DAY = 24
constant MINUTES_IN_DAY = HOURS_IN_DAY * MINUTES_IN_HOUR

function convertMinutesToHoursAndMinutes(integer m)
    m = mod(m, MINUTES_IN_DAY)
    if m < 0 then m += MINUTES_IN_DAY end if
    integer mins = remainder(m, MINUTES_IN_HOUR),
            hours = remainder((m - mins)/MINUTES_IN_HOUR, HOURS_IN_DAY)
    return {hours, mins}
end function

public function create(integer hours, integer minutes)
    return convertMinutesToHoursAndMinutes(hours * MINUTES_IN_HOUR + minutes)
end function

public function toString(sequence clock)
    return sprintf("%02d:%02d", clock)
end function

public function add(sequence clock, integer minutes)
    return convertMinutesToHoursAndMinutes(clock[1] * MINUTES_IN_HOUR + clock[2] + minutes)
end function

public function subtract(sequence clock, integer minutes)
    return add(clock, -minutes)
end function

public function equalClocks(sequence clock1, sequence clock2)
    return equal(clock1, clock2)
end function