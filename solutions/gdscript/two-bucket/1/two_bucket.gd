func measure(max_one: int, max_two: int, goal: int, start: String):
	var visited := {}
	visited[[max_one, 0]] = true
	visited[[0, max_two]] = true
	
	var queue := []
	if start == "one":
		queue.append([max_one, 0, 1])
	else:
		queue.append([0, max_two, 1])
	
	while queue.size() > 0:
		var cur = queue.pop_front()
		var cur_one: int = cur[0]
		var cur_two: int = cur[1]
		var cur_moves: int = cur[2]
		
		if cur_one == goal:
			return {
				"moves": cur_moves,
				"goal_bucket": "one",
				"other_bucket": cur_two,
			}
		elif cur_two == goal:
			return {
				"moves": cur_moves,
				"goal_bucket": "two",
				"other_bucket": cur_one,
			}
		
		var candidates := [
			[max_one, cur_two], # fill 1
			[cur_one, max_two], # fill 2
			[0, cur_two],       # empty 1
			[cur_one, 0],       # empty 2
		]
		
		var pour_1to2 := mini(cur_one, max_two - cur_two)
		candidates.append([cur_one - pour_1to2, cur_two + pour_1to2])
		
		var pour_2to1 := mini(cur_two, max_one - cur_one)
		candidates.append([cur_one + pour_2to1, cur_two - pour_2to1])
		
		for candidate in candidates:
			if not visited.has(candidate):
				visited[candidate] = true
				queue.append([candidate[0], candidate[1], cur_moves + 1])
		
	return null
	