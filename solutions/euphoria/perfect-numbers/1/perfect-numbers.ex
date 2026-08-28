public function classify(integer number)
    if number <= 0 then
        return 0  -- Not a positive integer, thus false
    end if

    integer sum = 0
    for i = 1 to number - 1 do
        if remainder(number, i) = 0 then
            sum = sum + i
        end if
    end for

    if sum = number then
        return "perfect"
    elsif sum > number then
        return "abundant"
    else
        return "deficient"
    end if
end function