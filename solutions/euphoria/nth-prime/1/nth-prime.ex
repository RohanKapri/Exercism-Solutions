public function prime(integer number)
    integer count
    integer candidate
    integer is_prime

    if number < 1 then
        return -1
    end if

    if number = 1 then
        return 2
    end if

    count = 1
    candidate = 1

    while count < number do
        candidate += 2
        is_prime = 1

        for d = 3 to floor(sqrt(candidate)) by 2 do
            if remainder(candidate, d) = 0 then
                is_prime = 0
                exit
            end if
        end for

        if is_prime then
            count += 1
        end if
    end while

    return candidate
end function