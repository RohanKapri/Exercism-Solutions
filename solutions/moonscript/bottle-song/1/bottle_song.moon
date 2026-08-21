numbers_cap = {
  [10]: "Ten"
  [9]: "Nine"
  [8]: "Eight"
  [7]: "Seven"
  [6]: "Six"
  [5]: "Five"
  [4]: "Four"
  [3]: "Three"
  [2]: "Two"
  [1]: "One"
  [0]: "No"
}

numbers_low = {
  [10]: "ten"
  [9]: "nine"
  [8]: "eight"
  [7]: "seven"
  [6]: "six"
  [5]: "five"
  [4]: "four"
  [3]: "three"
  [2]: "two"
  [1]: "one"
  [0]: "no"
}

bottle_label = (n) ->
  if n == 1 then "bottle" else "bottles"

single_verse = (n) ->
  curr_word = numbers_cap[n]
  curr_noun = bottle_label n

  next_n = if n > 0 then n - 1 else 0
  next_word = numbers_low[next_n]
  next_noun = bottle_label next_n

  "#{curr_word} green #{curr_noun} hanging on the wall,\n" ..
  "#{curr_word} green #{curr_noun} hanging on the wall,\n" ..
  "And if one green bottle should accidentally fall,\n" ..
  "There'll be #{next_word} green #{next_noun} hanging on the wall."

{
  recite: (startVerse, numToTake) ->
    verses = {}
    for i = 0, numToTake - 1
      table.insert verses, single_verse(startVerse - i)
    table.concat verses, "\n\n"
}


