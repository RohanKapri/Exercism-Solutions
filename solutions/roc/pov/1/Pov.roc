Pov :: {}.{
	Tree := [Empty, Node({ label : Str, children : Set(Tree) })].{

		## Are two trees equal?
		is_eq : _ # enable the default is_eq implementation for the Tree type

		## Return the tree from the point of view of the node with the given label.
		## Return Err(NotFound) if no such node is found.
		from_pov : Tree, Str -> Try(Tree, [NotFound, ..])
		from_pov = |tree, from| {
			path = find_path(tree, from)?
			Ok(invert(path))
		}

		## Return the labels of the nodes between the two given nodes
		## If either of these nodes don't exist, return Err(NotFound)
		path_to : Tree, Str, Str -> Try(List(Str), [NotFound, ..])
		path_to = |tree, from, to| {
			rerooted = from_pov(tree, from)?
			path = find_path(rerooted, to)?
			Ok(path.map(label_of))
		}

		label_of : Tree -> Str
		label_of = |tree| {
			match tree {
				Node({ label, children: _ }) => label
				Empty => ""
			}
		}

		find_path : Tree, Str -> Try(List(Tree), [NotFound, ..])
		find_path = |tree, target| {
			match tree {
				Empty => Err(NotFound)
				Node({ label, children }) => {
					if label == target {
						Ok([tree])
					} else {
						find_in_children(tree, Set.to_list(children), target)
					}
				}
			}
		}

		find_in_children : Tree, List(Tree), Str -> Try(List(Tree), [NotFound, ..])
		find_in_children = |parent, kids, target| {
			match kids {
				[] => Err(NotFound)
				[child, .. as rest] => {
					match find_path(child, target) {
						Ok(path) => Ok([parent].concat(path))
						Err(_) => find_in_children(parent, rest, target)
					}
				}
			}
		}

		## Invert parent/child links along a root-to-target path.
		invert : List(Tree) -> Tree
		invert = |path| {
			match path {
				[] => Empty
				[node] => node
				[node, child, .. as rest] => {
					child_label = label_of(child)
					remainder =
						match node {
							Node({ children, label: _ }) => Set.keep_if(children, |c| label_of(c) != child_label)
							Empty => Set.empty()
						}
					ancestor =
						match node {
							Node({ label, children: _ }) => Node({ label, children: remainder })
							Empty => Empty
						}
					insert_under(invert([child].concat(rest)), child_label, ancestor)
				}
			}
		}

		## Insert `new_child` under the unique node with the given label.
		insert_under : Tree, Str, Tree -> Tree
		insert_under = |tree, label, new_child| {
			match tree {
				Empty => Empty
				Node({ label: l, children }) => {
					if l == label {
						Node({ label: l, children: Set.insert(children, new_child) })
					} else {
						Node({
							label: l,
							children: Set.map(children, |c| insert_under(c, label, new_child)),
						})
					}
				}
			}
		}
	}
}