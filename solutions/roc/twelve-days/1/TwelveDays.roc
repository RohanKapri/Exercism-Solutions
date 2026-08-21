TwelveDays :: {}.{
	recite : U8, U8 -> Result Str *
	recite = |first_verse, last_verse| {
		generate_verses(first_verse, last_verse, [])
		|> Str.join_with("\n\n")
		|> Ok
	}
}

generate_verses : U8, U8, List Str -> List Str
generate_verses = |current, last, acc|
	if current > last then
		acc
	else
		verse_str = make_verse(current)
		generate_verses(current + 1, last, List.append(acc, verse_str))

make_verse : U8 -> Str
make_verse = |day|
	day_word = get_day_word(day)
	gifts_str = build_gifts(day, day)
	"On the ${day_word} day of Christmas my true love gave to me: ${gifts_str}."

get_day_word : U8 -> Str
get_day_word = |day|
	when day is
		1 -> "first"
		2 -> "second"
		3 -> "third"
		4 -> "fourth"
		5 -> "fifth"
		6 -> "sixth"
		7 -> "seventh"
		8 -> "eighth"
		9 -> "ninth"
		10 -> "tenth"
		11 -> "eleventh"
		12 -> "twelfth"
		_ -> ""

get_gift : U8 -> Str
get_gift = |n|
	when n is
		1 -> "a Partridge in a Pear Tree"
		2 -> "two Turtle Doves"
		3 -> "three French Hens"
		4 -> "four Calling Birds"
		5 -> "five Gold Rings"
		6 -> "six Geese-a-Laying"
		7 -> "seven Swans-a-Swimming"
		8 -> "eight Maids-a-Milking"
		9 -> "nine Ladies Dancing"
		10 -> "ten Lords-a-Leaping"
		11 -> "eleven Pipers Piping"
		12 -> "twelve Drummers Drumming"
		_ -> ""

build_gifts : U8, U8 -> Str
build_gifts = |current_gift, total_day|
	if current_gift == 1 then
		if total_day == 1 then
			get_gift(1)
		else
			"and " |> Str.concat(get_gift(1))
	else
		gift_text = get_gift(current_gift)
		rest = build_gifts(current_gift - 1, total_day)
		"${gift_text}, ${rest}"