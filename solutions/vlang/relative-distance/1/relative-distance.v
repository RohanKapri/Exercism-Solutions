module main

// `family_tree` maps a person to the list of their children.
//
// Return the shortest number of connections between `person_a` and
// `person_b`, or an error when they are not connected at all.
fn degree_of_separation(family_tree map[string][]string, person_a string, person_b string) !int {
	mut edges := map[string][]string{}

	for parent, children in family_tree {
		for child in children {
			// connect parent, child
			edges[parent] << child
			edges[child] << parent
		}

		for j in 0 .. children.len {
			for i in 0 .. j {
				// connect children[i], children[j]
				edges[children[i]] << children[j]
				edges[children[j]] << children[i]
			}
		}
	}

	if person_a == person_b {
		return 0
	}

	mut seen := map[string]bool{}
	seen[person_a] = true

	mut generations := 0

	mut next := [person_a]

	for next.len > 0 {
		generations++
		current := next.clone()

		next = []string{}

		for entry in current {
			for neighbour in edges[entry] {
				if neighbour in seen {
					continue
				}

				if neighbour == person_b {
					return generations
				}

				seen[neighbour] = true
				next << neighbour
			}
		}
	}

	return error('not connected')
}