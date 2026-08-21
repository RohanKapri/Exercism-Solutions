BottleSong :: {}.{
	recite : U8, U8 -> Result Str *
	recite = |starting_number, number_of_verses| {
		generate_verses(starting_number, number_of_verses, [])
		|> Str.join_with("\n\n")
		|> Ok
	}
}

generate_verses : U8, U8, List Str -> List Str
generate_verses = |current, count_remaining, acc|
	if count_remaining == 0 then
		acc
	else
		current_verse = make_verse(current)
		next_acc = List.append(acc, current_verse)
		next_num = if current > 0 then current - 1 else 0
		generate_verses(next_num, count_remaining - 1, next_acc)

make_verse : U8 -> Str
make_verse = |n| {
	curr_cap =
		when n is
			10 -> "Ten"
			9 -> "Nine"
			8 -> "Eight"
			7 -> "Seven"
			6 -> "Six"
			5 -> "Five"
			4 -> "Four"
			3 -> "Three"
			2 -> "Two"
			1 -> "One"
			_ -> "No"

	curr_bottle =
		if n == 1 then "bottle" else "bottles"

	next_n = if n > 0 then n - 1 else 0

	next_low =
		when next_n is
			10 -> "ten"
			9 -> "nine"
			8 -> "eight"
			7 -> "seven"
			6 -> "six"
			5 -> "five"
			4 -> "four"
			3 -> "three"
			2 -> "two"
			1 -> "one"
			_ -> "no"

	next_bottle =
		if next_n == 1 then "bottle" else "bottles"

	"${curr_cap} green ${curr_bottle} hanging on the wall,\n${curr_cap} green ${curr_bottle} hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be ${next_low} green ${next_bottle} hanging on the wall."
}


