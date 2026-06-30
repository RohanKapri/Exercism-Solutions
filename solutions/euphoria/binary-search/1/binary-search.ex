public function my_find(sequence values, atom value)
    integer low = 1
    integer high = length(values)

    while low <= high do
        integer mid = floor((low + high) / 2)
        if values[mid] < value then
            low = mid + 1
        elsif values[mid] > value then
            high = mid - 1
        else
            return mid
        end if
    end while

    return -1
end function