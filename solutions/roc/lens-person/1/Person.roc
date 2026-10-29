Person := { name : Name, birth : Birth, address : Address }.{
	Name : { forenames : Str, surname : Str }

	Address : { street : Str, house_number : U64, place : Str, country : Str }

	Date : { year : I64, month : U8, day : U8 }

	Birth := { born_at : Address, born_on : Date }.{
		is_eq : _

		street : Birth -> Str
		street = |Birth(b)| b.born_at.street
	}

	# The following line enables the default `is_eq` implementation
	is_eq : _

	Lens : whole, part -> {
		get : whole -> part,
		set : whole, part -> whole,
	}

	compose : Lens(outer, inner), Lens(inner, part) -> Lens(outer, part)
	compose = |l1, l2| {
		get: |outer| l2.get(l1.get(outer)),
		set: |outer, part| l1.set(outer, l2.set(l1.get(outer), part)),
	}

	over : Lens(whole, part), whole, (part -> part) -> whole
	over = |lens, whole_val, f|
		part_val = lens.get(whole_val)
		lens.set(whole_val, f(part_val))

	# Lenses for Person
	address_lens : Lens(Person, Address)
	address_lens = {
		get: |p| p.address,
		set: |p, address| { ..p, address },
	}

	birth_lens : Lens(Person, Birth)
	birth_lens = {
		get: |p| p.birth,
		set: |p, birth| { ..p, birth },
	}

	street_lens : Lens(Address, Str)
	street_lens = {
		get: |a| a.street,
		set: |a, street| { ..a, street },
	}

	born_at_lens : Lens(Birth, Address)
	born_at_lens = {
		get: |b|
			Birth(inner) = b
			inner.born_at,
		set: |b, born_at|
			Birth(inner) = b
			Birth({ ..inner, born_at }),
	}

	born_on_lens : Lens(Birth, Date)
	born_on_lens = {
		get: |b|
			Birth(inner) = b
			inner.born_on,
		set: |b, born_on|
			Birth(inner) = b
			Birth({ ..inner, born_on }),
	}

	month_lens : Lens(Date, U8)
	month_lens = {
		get: |d| d.month,
		set: |d, month| { ..d, month },
	}

	current_street_lens : Lens(Person, Str)
	current_street_lens = compose(address_lens, street_lens)

	birth_street_lens : Lens(Person, Str)
	birth_street_lens = compose(compose(birth_lens, born_at_lens), street_lens)

	birth_month_lens : Lens(Person, U8)
	birth_month_lens = compose(compose(birth_lens, born_on_lens), month_lens)

	set_current_street : Person, Str -> Person
	set_current_street = |person, new_street|
		current_street_lens |> over(person, |_| new_street)

	set_birth_month : Person, U8 -> Person
	set_birth_month = |person, new_month|
		birth_month_lens |> over(person, |_| new_month)

	rename_streets : Person, (Str -> Str) -> Person
	rename_streets = |person, rename|
		p1 = current_street_lens |> over(person, rename)
		birth_street_lens |> over(p1, rename)
}
