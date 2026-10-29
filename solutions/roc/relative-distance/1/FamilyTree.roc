FamilyTree :: { family_tree : Dict(Str, List(Str)) }.{
    degree_of_separation : FamilyTree, Str, Str -> U64

    degree_of_separation = |tree, start, target| {
        if start == target {
            0
        } else {
            family = tree.family_tree
            graph = Dict.empty()

            graph = family.to_list().walk(graph, |graph, (parent, children)| {
                graph = graph.insert(parent, graph.get(parent).with_default([]))

                children.walk(graph, |graph, child| {
                    graph = graph.insert(
                        parent,
                        graph.get(parent).with_default([]).append(child),
                    )
                    graph.insert(
                        child,
                        graph.get(child).with_default([]).append(parent),
                    )
                })
            })

            search = |queue, visited| {
                when queue {
                    [] => 0
                    [(person, distance), ..rest] =>
                        if person == target {
                            distance
                        } else if visited.contains(person) {
                            search(rest, visited)
                        } else {
                            visited = visited.insert(person)
                            neighbors = graph.get(person).with_default([])
                            next = neighbors.map(|neighbor| (neighbor, distance + 1))
                            search(List.concat(rest, next), visited)
                        }
                }
            }

            search([(start, 0)], Set.empty())
        }
    }
}
