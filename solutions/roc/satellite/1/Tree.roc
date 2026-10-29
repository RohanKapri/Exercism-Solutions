Tree := [Empty, Node(Node)].{
	Node := { value : U8, left : Tree, right : Tree }.{
		is_eq : _
	}

	is_eq : _

	from_traversals : { pre_order : List(U8), in_order : List(U8) } -> Try(Tree, _)
	from_traversals = |{ pre_order, in_order }|
		if List.len(pre_order) != List.len(in_order) then
			Err(MismatchedLengths)
		else if List.is_empty(pre_order) then
			Ok(Empty)
		else
			root_val = List.first(pre_order)?

			# Find root position in in_order list
			split_index_res = List.find_first_index(in_order, |v| v == root_val)
			split_index = split_index_res?

			in_left = List.take_first(in_order, split_index)
			in_right = List.drop_first(in_order, split_index + 1)

			left_len = List.len(in_left)

			# Pre-order split: skip root (1 element), then take left_len elements for left subtree, rest for right subtree
			pre_rest = List.drop_first(pre_order, 1)
			pre_left = List.take_first(pre_rest, left_len)
			pre_right = List.drop_first(pre_rest, left_len)

			left_tree = from_traversals({ pre_order: pre_left, in_order: in_left })?
			right_tree = from_traversals({ pre_order: pre_right, in_order: in_right })?

			Ok(Node({ value: root_val, left: left_tree, right: right_tree }))
}
