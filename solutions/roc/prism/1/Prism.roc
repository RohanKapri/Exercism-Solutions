Prism := { id : U64, x : Dec, y : Dec, angle : Dec }.{
	find_sequence : { start : { x : Dec, y : Dec, angle : Dec }, prisms : List(Prism) } -> List(U64)
	find_sequence = |{ start, prisms }|
		simulate(start.x, start.y, start.angle, prisms, [])

	simulate = |curr_x, curr_y, curr_angle, prisms, acc|
		match find_next_prism(curr_x, curr_y, curr_angle, prisms) is
			Ok({ prism, t }) ->
				new_acc = List.append(acc, prism.id)
				new_angle = curr_angle + prism.angle
				simulate(prism.x, prism.y, new_angle, prisms, new_acc)
			Err(NoPrism) ->
				acc

	find_next_prism = |curr_x, curr_y, curr_angle, prisms|
		(dx, dy) = angle_to_dir(curr_angle)

		candidates = List.keep_oks(prisms, |p|
			vx = p.x - curr_x
			vy = p.y - curr_y

			cross = vx * dy - vy * dx
			if Num.abs(cross) > 0.00001 then
				Err(NotOnRay)
			else
				t = if Num.abs(dx) > 0.00001 then
					vx / dx
				else if Num.abs(dy) > 0.00001 then
					vy / dy
				else
					0.0

				if t > 0.00001 then
					Ok({ prism: p, t })
				else
					Err(BehindOrCurrent)
		)

		List.walk(candidates, Err(NoBest), |acc, candidate|
			match acc is
				Err(_) -> Ok(candidate)
				Ok(best) ->
					if candidate.t < best.t then
						Ok(candidate)
					else
						Ok(best)
		)

	angle_to_dir = |angle|
		if angle == 0.0 then
			(1.0, 0.0)
		else if angle == 90.0 then
			(0.0, 1.0)
		else if angle == 180.0 or angle == -180.0 then
			(-1.0, 0.0)
		else if angle == 270.0 or angle == -90.0 then
			(0.0, -1.0)
		else if angle == 45.0 then
			(0.7071067811865476, 0.7071067811865476)
		else if angle == 135.0 then
			(-0.7071067811865476, 0.7071067811865476)
		else if angle == 225.0 or angle == -135.0 then
			(-0.7071067811865476, -0.7071067811865476)
		else if angle == 315.0 or angle == -45.0 then
			(1.0, -1.0)
		else
			(1.0, 0.0)
}
