public function squareOfSum(integer n)
    atom sum = 0
    for i = 1 to n do
        sum += i
    end for
    return power(sum, 2)
end function

public function sumOfSquares(integer n)
    atom sum = 0
    for i = 1 to n do
        sum += power(i, 2)
    end for
    return sum
end function

public function differenceOfSquares(integer n)
    return squareOfSum(n) - sumOfSquares(n)
end function