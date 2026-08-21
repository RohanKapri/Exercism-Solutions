import random.Random

RobotName :: {}.{

	## A factory is used to create robots, and holds state such as the existing
	## robot names and the current random state
	Factory := {
		state : Random.State,
		used_names : Set Str,
	}.{
		new : { seed : U32 } -> Factory
		new = |{ seed }| {
			@Factory({
				state: Random.seed(seed),
				used_names: Set.empty({}),
			})
		}

		build_robot : Factory -> Robot
		build_robot = |factory| {
			@Robot({
				factory,
				name: NoName,
			})
		}

		generate_name : Factory -> { name : Str, factory : Factory }
		generate_name = |@Factory(f)| {
			# Generate 2 uppercase letters (ASCII 65..90) and 3 digits (0..9)
			(c1_num, s1) = Random.step(Random.u32(65, 90), f.state)
			(c2_num, s2) = Random.step(Random.u32(65, 90), s1)
			(d1_num, s3) = Random.step(Random.u32(0, 9), s2)
			(d2_num, s4) = Random.step(Random.u32(0, 9), s3)
			(d3_num, s5) = Random.step(Random.u32(0, 9), s4)

			c1 = Num.to_u8(c1_num)
			c2 = Num.to_u8(c2_num)

			name_str =
				when Str.from_utf8([c1, c2]) is
					Ok(prefix) ->
						"${prefix}${Num.to_str(d1_num)}${Num.to_str(d2_num)}${Num.to_str(d3_num)}"

					Err(_) ->
						"AA000"

			if Set.contains(f.used_names, name_str) then
				# Collision: retry with next random state
				generate_name(@Factory({ f & state: s5 }))
			else
				updated_factory = @Factory({
					state: s5,
					used_names: Set.insert(f.used_names, name_str),
				})
				{ name: name_str, factory: updated_factory }
		}

		release_name : Factory, Str -> Factory
		release_name = |@Factory(f), name| {
			@Factory({
				f &
				used_names: Set.remove(f.used_names, name),
			})
		}
	}

	## A robot must either have no name or a name composed of two letters
	## followed by three digits
	Robot := {
		factory : Factory,
		name : [Name(Str), NoName],
	}.{
		boot : Robot -> Robot
		boot = |@Robot(r)| {
			when r.name is
				Name(_) ->
					@Robot(r)

				NoName ->
					{ name, factory: updated_factory } = Factory.generate_name(r.factory)
					@Robot({
						factory: updated_factory,
						name: Name(name),
					})
		}

		factory_reset : Robot -> Robot
		factory_reset = |@Robot(r)| {
			when r.name is
				NoName ->
					@Robot(r)

				Name(old_name) ->
					updated_factory = Factory.release_name(r.factory, old_name)
					@Robot({
						factory: updated_factory,
						name: NoName,
					})
		}

		get_name : Robot -> [Name(Str), NoName]
		get_name = |@Robot(r)| {
			r.name
		}

		get_factory : Robot -> Factory
		get_factory = |@Robot(r)| {
			r.factory
		}
	}
}