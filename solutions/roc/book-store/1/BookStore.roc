BookStore :: {}.{
	total : List(U8) -> Dec
	total = |basket|
		freq_dict = List.walk(basket, Dict.empty(), |acc, item|
			count = Dict.get(acc, item |> Num.to_u32) |> Result.with_default(0)
			Dict.insert(acc, item |> Num.to_u32, count + 1)
		)
		
		counts_list = Dict.values(freq_dict) |> List.sort_desc
		padded_counts = pad_to_5(counts_list)
		
		calculate_min(padded_counts)

	pad_to_5 = |lst|
		if List.len(lst) >= 5 then
			lst
		else
			pad_to_5(List.append(lst, 0))

	set_cost = |k|
		base = k.to_dec() * 8.0
		discount = when k is
			1 -> 1.0
			2 -> 0.95
			3 -> 0.90
			4 -> 0.80
			5 -> 0.75
			_ -> 1.0
		base * discount

	calculate_min = |counts|
		if List.all(counts, |c| c == 0) then
			0.0
		else
			prices = List.map([1, 2, 3, 4, 5], |k|
				val = List.get(counts, k - 1) |> Result.with_default(0)
				if val == 0 then
					99999.0
				else
					new_counts = List.map_with_index(counts, |c, i|
						if i < k and c > 0 then c - 1 else c
					) |> List.sort_desc
					
					set_cost(k) + calculate_min(new_counts)
			)
			List.min(prices) |> Result.with_default(0.0)
}