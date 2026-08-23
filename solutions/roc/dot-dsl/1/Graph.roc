Graph := {
    title ?: Str,
    color ?: Graph.Color,
    custom_attributes : Dict(Str, Graph.CustomAttributeValue),
    nodes : Dict(Str, Graph.Attributes),
    edges : Dict(Graph.EdgeId, Graph.Attributes),
}.{
    is_eq : _

    Color : [Blue, Green]

    Style : [Solid, Dotted]

    CustomAttributeValue : [
        Text(Str),
        Int(I64),
        True,
        False,
    ]

    Attributes : {
        color ?: Color,
        style ?: Style,
        label ?: Str,
        custom_attributes : Dict(Str, CustomAttributeValue),
    }

    EdgeId : (Str, Str) # these two node IDs must be ordered alphabetically

    # Attribute Constructors
    default_attrs : Attributes
    default_attrs = { custom_attributes: Dict.empty() }

    attr_color : Color -> Attributes
    attr_color = |c| { custom_attributes: Dict.empty(), color: c }

    attr_label : Str -> Attributes
    attr_label = |l| { custom_attributes: Dict.empty(), label: l }

    attr_style : Style -> Attributes
    attr_style = |s| { custom_attributes: Dict.empty(), style: s }

    # DSL Builders
    new : Graph
    new = {
        nodes: Dict.empty(),
        edges: Dict.empty(),
        custom_attributes: Dict.empty(),
    }

    title : Graph, Str -> Graph
    title = |g, t| { ..g, title: t }

    attr : Graph, Str, CustomAttributeValue -> Graph
    attr = |g, k, v| { ..g, custom_attributes: Dict.insert(g.custom_attributes, k, v) }

    node : Graph, Str -> Graph
    node = |g, name| node_with(g, name, default_attrs)

    node_with : Graph, Str, Attributes -> Graph
    node_with = |g, name, attrs| {
        ..g,
        nodes: Dict.insert(g.nodes, name, attrs),
    }

    edge : Graph, Str, Str -> Graph
    edge = |g, n1, n2| edge_with(g, n1, n2, default_attrs)

    edge_with : Graph, Str, Str, Attributes -> Graph
    edge_with = |g, n1, n2, attrs| {
        edge_id = make_edge_id(n1, n2)
        nodes_with_n1 =
            if Dict.contains(g.nodes, n1) {
                g.nodes
            } else {
                Dict.insert(g.nodes, n1, default_attrs)
            }
        nodes_with_both =
            if Dict.contains(nodes_with_n1, n2) {
                nodes_with_n1
            } else {
                Dict.insert(nodes_with_n1, n2, default_attrs)
            }
        {
            ..g,
            nodes: nodes_with_both,
            edges: Dict.insert(g.edges, edge_id, attrs),
        }
    }

    chain_with : Graph, List(Str), Attributes -> Graph
    chain_with = |g, chain, attrs| {
        nodes_updated = add_chain_nodes(g.nodes, chain)
        edges_updated = add_chain_edges(g.edges, chain, attrs)
        { ..g, nodes: nodes_updated, edges: edges_updated }
    }

    add_chain_nodes : Dict(Str, Attributes), List(Str) -> Dict(Str, Attributes)
    add_chain_nodes = |nodes, chain| {
        match chain {
            [] => nodes
            [n, .. as rest] => {
                new_nodes =
                    if Dict.contains(nodes, n) {
                        nodes
                    } else {
                        Dict.insert(nodes, n, default_attrs)
                    }
                add_chain_nodes(new_nodes, rest)
            }
        }
    }

    add_chain_edges : Dict(EdgeId, Attributes), List(Str), Attributes -> Dict(EdgeId, Attributes)
    add_chain_edges = |edges, chain, attrs| {
        match chain {
            [] => edges
            [_] => edges
            [a, b, .. as rest] => {
                edge_id = make_edge_id(a, b)
                new_edges = Dict.insert(edges, edge_id, attrs)
                add_chain_edges(new_edges, [b].concat(rest), attrs)
            }
        }
    }

    make_edge_id : Str, Str -> EdgeId
    make_edge_id = |n1, n2| {
        match compare_strings(n1, n2) {
            GT => (n2, n1)
            _ => (n1, n2)
        }
    }

    ## empty graph
    empty_graph : Graph
    empty_graph = Graph.new

    ## graph with one node
    graph_with_one_node : Graph
    graph_with_one_node =
        Graph.new
        |> Graph.node("a")

    ## graph with one node with attribute
    graph_with_one_node_with_attribute : Graph
    graph_with_one_node_with_attribute =
        Graph.new
        |> Graph.node_with("a", Graph.attr_color(Green))

    ## graph with one edge
    graph_with_one_edge : Graph
    graph_with_one_edge =
        Graph.new
        |> Graph.edge("a", "b")

    ## graph with one attribute
    graph_with_one_attribute : Graph
    graph_with_one_attribute =
        Graph.new
        |> Graph.attr("foo", Int(1))

    ## graph with comments
    graph_with_comments : Graph
    graph_with_comments =
        Graph.new
        |> Graph.attr("foo", Int(1))

    ## graph with nodes, edges, and attributes
    graph_with_nodes_edges_and_attributes : Graph
    graph_with_nodes_edges_and_attributes =
        Graph.new
        |> Graph.attr("foo", Int(1))
        |> Graph.title("Testing Attrs")
        |> Graph.node_with("a", Graph.attr_color(Green))
        |> Graph.node_with("b", Graph.attr_label("Beta!"))
        |> Graph.edge("b", "c")
        |> Graph.edge_with("a", "b", Graph.attr_color(Blue))
        |> Graph.attr("bar", True)

    ## multiple edges on one line
    multiple_edges_on_one_line : Graph
    multiple_edges_on_one_line =
        Graph.new
        |> Graph.chain_with(["a", "b", "c", "d"], Graph.attr_style(Dotted))

    ## only 1 edge between nodes
    only_1_edge_between_nodes : Graph
    only_1_edge_between_nodes =
        Graph.new
        |> Graph.edge("a", "b")
        |> Graph.edge("a", "b")
        |> Graph.edge_with("b", "a", Graph.attr_color(Blue))
}

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2| {
    b1 = string1.to_utf8()
    b2 = string2.to_utf8()
    result =
        b1.map2(b2, |c1, c2| c1.compare(c2))
            .fold_try(
                Ok(EQ),
                |_state, cmp| {
                    match cmp {
                        EQ => Ok(EQ)
                        res => Err(res)
                    }
                },
            )
    match result {
        Ok(_cmp) => b1.len().compare(b2.len())
        Err(res) => res
    }
}