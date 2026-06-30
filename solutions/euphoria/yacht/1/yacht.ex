include std/sort.e
include std/sequence.e
include std/math.e

public function score(sequence roll, sequence play)
  roll = sort(roll)
  switch play do
    case "yacht" then return 50 * (roll[1] = roll[5])
    case "ones" then return 1 * length(retain_all(1, roll))
    case "twos" then return 2 * length(retain_all(2, roll))
    case "threes" then return 3 * length(retain_all(3, roll))
    case "fours" then return 4 * length(retain_all(4, roll))
    case "fives" then return 5 * length(retain_all(5, roll))
    case "sixes" then return 6 * length(retain_all(6, roll))
    case "four of a kind" then return 4 * roll[2] * (roll[1] = roll[4] or roll[2] = roll[5])
    case "full house" then return sum(roll) * ((roll[1] = roll[2] and roll[3] = roll[5] and roll[2] != roll[3]) or (roll[1] = roll[3] and roll[4] = roll[5] and roll[3] != roll[4]))
    case "little straight" then return 30 * equal({1,2,3,4,5}, roll)
    case "big straight" then return 30 * equal({2,3,4,5,6}, roll)
    case "choice" then return sum(roll)
  end switch
end function