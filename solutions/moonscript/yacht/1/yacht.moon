sum = (dice) ->
  total = 0
  total += die for die in *dice
  total

nums = (num) -> (dice) ->
  sum [ d for d in *dice when d == num ]

validate = (pred, score_fn) -> (dice) ->
  table.sort dice
  if pred dice then score_fn dice else 0

categories = 
  ones: nums(1), twos: nums(2), threes: nums(3), fours: nums(4), fives: nums(5), sixes: nums(6)
  "full house": validate ((dice) -> 
    option1 = dice[1] == dice[3] and dice[4] == dice[5] and dice[1] != dice[4]
    option2 = dice[1] == dice[2] and dice[3] == dice[5] and dice[1] != dice[4]
    return option1 or option2), sum
  "four of a kind": validate ((dice) ->
    option1 = dice[1] == dice[4]
    option2 = dice[2] == dice[5]
    return option1 or option2), ((dice) -> 4 * dice[3])
  "little straight": validate ((dice) ->
    for i = 1, 5
      return false unless dice[i] == i
    true), -> 30
  "big straight": validate ((dice) ->
    for i = 1, 5
      return false unless dice[i] == i + 1
    true), -> 30
  choice: sum
  yacht: validate ((dice) -> dice[1] == dice[5]), -> 50

score = (category, dice) ->
  categories[category] dice

{ :score }