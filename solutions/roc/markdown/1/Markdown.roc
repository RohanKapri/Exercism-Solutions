Markdown :: {}.{
	parse : Str -> Try(Str, _)
	parse = |markdown|
		lines = Str.split_on(markdown, "\n")
		parsed_lines = List.map(lines, parse_line)

		# Accumulate lines while tracking active <ul> state
		(_, final_html) = List.walk(parsed_lines, (False, ""), |(in_list, acc), line|
			when line is
				Header(level, text) ->
					prefix = if in_list then "</ul>" else ""
					tag = Num.to_str(level)
					new_acc = "${acc}${prefix}<h${tag}>${text}</h${tag}>"
					(False, new_acc)
				ListItem(text) ->
					prefix = if in_list then "" else "<ul>"
					new_acc = "${acc}${prefix}<li>${text}</li>"
					(True, new_acc)
				Paragraph(text) ->
					prefix = if in_list then "</ul>" else ""
					new_acc = "${acc}${prefix}<p>${text}</p>"
					(False, new_acc)
		)

		closing = if in_list_state(parsed_lines) then # or handle list close at end
			# Check if last line resulted in an open list
			""
		else
			""

		# Handle trailing list close if the last rendered element left a list open
		# We can determine this by checking the last parsed line type
		closes_with_list = match List.last(parsed_lines) is
			Ok(ListItem(_)) -> True
			_ -> False

		result = if closes_with_list then "${final_html}</ul>" else final_html
		Ok(result)
}

LineType : [Header U64 Str, ListItem Str, Paragraph Str]

parse_line : Str -> LineType
parse_line = |s|
	if s.starts_with("###### ") then
		Header(6, parse_inline(s.drop_prefix("###### ")))
	else if s.starts_with("##### ") then
		Header(5, parse_inline(s.drop_prefix("##### ")))
	else if s.starts_with("#### ") then
		Header(4, parse_inline(s.drop_prefix("#### ")))
	else if s.starts_with("### ") then
		Header(3, parse_inline(s.drop_prefix("### ")))
	else if s.starts_with("## ") then
		Header(2, parse_inline(s.drop_prefix("## ")))
	else if s.starts_with("# ") then
		Header(1, parse_inline(s.drop_prefix("# ")))
	else if s.starts_with("* ") then
		ListItem(parse_inline(s.drop_prefix("* ")))
	else
		Paragraph(parse_inline(s))

parse_inline : Str -> Str
parse_inline = |str|
	b = Str.to_utf8(str)
	bytes_to_str(process_inline_bytes(b, 0))

process_inline_bytes : List(U8), U64 -> List(U8)
process_inline_bytes = |b, i|
	if i >= List.len(b) then
		[]
	else if (List.get(b, i) ?? 0) == '_' then
		n = if (List.get(b, i + 1) ?? 0) == '_' then 2 else 1
		j = find_matching_underscore(b, i + n, n)
		when j is
			Ok(end_idx) ->
				content = List.sublist(b, { start: i + n, len: end_idx - i - n })
				tag = if n == 2 then "strong" else "em"
				open_tag = Str.to_utf8("<${tag}>")
				close_tag = Str.to_utf8("</${tag}>")

				formatted = List.concat(open_tag, content) |> List.concat(close_tag)
				rest = process_inline_bytes(b, end_idx + n)
				List.concat(formatted, rest)
			Err(_) ->
				# Unmatched underscore, treat as literal
				literal = List.repeat('_', n)
				rest = process_inline_bytes(b, i + n)
				List.concat(literal, rest)
	else
		current = List.get(b, i) ?? 0
		rest = process_inline_bytes(b, i + 1)
		List.append(rest, current) |> prepend_elem(current) # simpler: [current] ++ rest

prepend_elem : List(U8), U8 -> List(U8)
prepend_elem = |list, elem|
	List.concat([elem], list)

find_matching_underscore : List(U8), U64, U64 -> Try(U64, [NotFound])
find_matching_underscore = |b, start, n|
	len = List.len(b)
	helper = |idx|
		if idx >= len then
			Err(NotFound)
		else if (List.get(b, idx) ?? 0) == '_' then
			if n == 2 then
				if (List.get(b, idx + 1) ?? 0) == '_' then
					Ok(idx)
				else
					helper(idx + 1)
			else
				# For single underscore, ensure it's not part of a double underscore unless valid
				Ok(idx)
		else
			helper(idx + 1)
	helper(start)

bytes_to_str : List(U8) -> Str
bytes_to_str = |bytes|
	Str.from_utf8_lossy(bytes)

in_list_state : List(LineType) -> Bool
in_list_state = |lines|
	# Track open lists at the end
	List.walk(lines, False, |in_l, line|
		when line is
			ListItem(_) -> True
			_ -> False
	)
