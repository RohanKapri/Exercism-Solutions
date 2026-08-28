public function distance(sequence left, sequence right)
    if length(left) != length(right) then
        return "left and right strands must be of equal length"
    end if

    integer hamming_distance = 0
    for i = 1 to length(left) do
        if left[i] != right[i] then
            hamming_distance += 1
        end if
    end for

    return hamming_distance
end function