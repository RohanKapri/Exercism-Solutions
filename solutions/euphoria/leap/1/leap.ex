public function leap(integer year)
    if remainder(year, 4) = 0 then
        if remainder(year, 100) != 0 or remainder(year, 400) = 0 then
            return 1
        end if
    end if
    return 0
end function