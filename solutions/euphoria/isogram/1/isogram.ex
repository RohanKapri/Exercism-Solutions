include sort.e
include wildcard.e

public function isogram(sequence str)
    str = sort(upper(str))
    sequence cleanedStr = ""

    for i = 1 to length(str) do
        if not find(str[i], " -") then
            cleanedStr &= str[i]
        end if
    end for

    for i = 2 to length(cleanedStr) do
        if cleanedStr[i] = cleanedStr[i - 1] then
            return 0
        end if
    end for

    return 1
end function