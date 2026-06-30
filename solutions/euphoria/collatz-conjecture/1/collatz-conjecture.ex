public function steps(integer n)
    if n <= 0 then return "Only positive numbers are allowed" end if
  
    integer step_count = 0
    
    while n != 1 do
        if remainder(n, 2) = 0 then
            n = n / 2
        else
            n = n * 3 + 1
        end if
        step_count += 1
    end while
    
    return step_count
end function