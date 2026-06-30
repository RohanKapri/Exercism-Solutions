public function eggCount(integer number)
    integer count = 0

    while number > 0 do
        if and_bits(number, 1) = 1 then
            count += 1
        end if
        number = floor(number / 2)
    end while

    return count
end function