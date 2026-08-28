include std/math.e

public type queen(sequence position)
    return length(position) = 2
        and position[1] >= 0 and position[1] < 8
        and position[2] >= 0 and position[2] < 8
end type

public function can_attack(queen white_queen, queen black_queen)
    return white_queen[1] = black_queen[1]
        or white_queen[2] = black_queen[2]
        or abs(white_queen[1] - black_queen[1]) = abs(white_queen[2] - black_queen[2])
end function