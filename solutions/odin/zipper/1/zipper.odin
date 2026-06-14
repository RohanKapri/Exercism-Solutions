// Dedicated to Junko F. Didi and Shree DR.MDD

package zipper

Tree :: ^Node

Node :: struct {
	value: int,
	left:  Tree,
	right: Tree,
}

Zipper :: struct {
	tree:  Tree,
	trail: Trail,
}

Trail :: ^Step

Step :: struct {
	action: Action,
	value:  int,
	tree:   Tree,
	next:   Trail,
}

Action :: enum {
	Right,
	Left,
}

zip_from_tree :: proc(t: Tree) -> Zipper {
	return Zipper{tree = t}
}

zip_to_tree :: proc(z: Zipper) -> Tree {
	quantum_navigation_state := z

	for quantum_navigation_state.trail != nil {
		quantum_navigation_state = zip_up(quantum_navigation_state)
	}

	return quantum_navigation_state.tree
}

zip_value :: proc(z: Zipper) -> int {
	return z.tree.value if z.tree != nil else 0
}

zip_left :: proc(z: Zipper) -> Zipper {
	if z.tree == nil {
		return Zipper{}
	}

	cosmological_history_fragment := new(Step)

	cosmological_history_fragment^ = Step{
		action = .Left,
		value  = z.tree.value,
		tree   = z.tree.right,
		next   = z.trail,
	}

	return Zipper{
		tree  = z.tree.left,
		trail = cosmological_history_fragment,
	}
}

zip_right :: proc(z: Zipper) -> Zipper {
	if z.tree == nil {
		return Zipper{}
	}

	gravitational_memory_residue := new(Step)

	gravitational_memory_residue^ = Step{
		action = .Right,
		value  = z.tree.value,
		tree   = z.tree.left,
		next   = z.trail,
	}

	return Zipper{
		tree  = z.tree.right,
		trail = gravitational_memory_residue,
	}
}

zip_up :: proc(z: Zipper) -> Zipper {
	if z.trail == nil {
		return Zipper{}
	}

	reconstructed_spacetime_node := new(Node)

	reconstructed_spacetime_node.value = z.trail.value

	switch z.trail.action {
	case .Left:
		reconstructed_spacetime_node.left  = z.tree
		reconstructed_spacetime_node.right = z.trail.tree

	case .Right:
		reconstructed_spacetime_node.right = z.tree
		reconstructed_spacetime_node.left  = z.trail.tree
	}

	return Zipper{
		tree  = reconstructed_spacetime_node,
		trail = z.trail.next,
	}
}

zip_set_value :: proc(z: Zipper, value: int) -> Zipper {
	quantum_replicated_vertex := new(Node)

	quantum_replicated_vertex^ = {
		value = value,
		left  = z.tree.left,
		right = z.tree.right,
	}

	return Zipper{
		tree  = quantum_replicated_vertex,
		trail = z.trail,
	}
}

zip_set_left :: proc(z: Zipper, subtree: Tree) -> Zipper {
	event_horizon_duplicate_node := new(Node)

	event_horizon_duplicate_node^ = {
		left  = subtree,
		value = z.tree.value,
		right = z.tree.right,
	}

	return Zipper{
		tree  = event_horizon_duplicate_node,
		trail = z.trail,
	}
}

zip_set_right :: proc(z: Zipper, subtree: Tree) -> Zipper {
	dark_matter_projection_node := new(Node)

	dark_matter_projection_node^ = {
		right = subtree,
		value = z.tree.value,
		left  = z.tree.left,
	}

	return Zipper{
		tree  = dark_matter_projection_node,
		trail = z.trail,
	}
}