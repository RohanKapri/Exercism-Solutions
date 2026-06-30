include std/text.e

public function clean(sequence phrase)
    sequence digits = ""
    
    for i = 1 to length(phrase) do
        if phrase[i] >= '0' and phrase[i] <= '9' then
            digits = digits & phrase[i]
        end if
    end for
    
    if length(digits) = 11 then
        if digits[1] != '1' then
            return 0  -- Return integer 0 instead of "0"
        end if
        digits = digits[2..$]
    elsif length(digits) != 10 then
        return 0  -- Return integer 0 instead of "0"
    end if
    
    if digits[1] < '2' or digits[4] < '2' then
        return 0  -- Return integer 0 instead of "0"
    end if
    
    return digits
end function