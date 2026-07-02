module [parse, GameTree]

# HINT: we have added the `roc-parser` package to the app's header in
#       sgf-parsing-test.roc. You can use it if you want, particularly the
#       Core module, and perhaps the String module as well.
#       However, if you prefer to roll out your own solution, that's fine too!
# import parser.Core
# import parser.String

NodeProperties : Dict Str (List Str)

# Note: Empty is unused, it's only here to avoid infinite type recursion because
#       the Roc compiler does not yet understand that an empty List can end the
#       recursion.
GameTree : [Empty, GameNode { properties : NodeProperties, children : List GameTree }]

ParseErr : {}

parse : Str -> Result GameTree _
parse = |sgf|
    if Str.is_empty(sgf) then
        Err({})
    else
        bytes = Str.to_utf8(sgf)
        when parse_game_tree(bytes, 0) is
            Ok((tree, end)) ->
                if end != List.len(bytes) then
                    Err({})
                else
                    Ok(tree)

            Err(_) ->
                Err({})

## --- Game tree: "(" Sequence GameTree* ")" -------------------------------------

parse_game_tree : List U8, U64 -> Result (GameTree, U64) ParseErr
parse_game_tree = |bytes, i|
    when expect_byte(bytes, i, '(') is
        Err(_) -> Err({})
        Ok(i1) ->
            when parse_sequence_nodes(bytes, i1) is
                Err(_) -> Err({})
                Ok((nodes, i2)) ->
                    when parse_variation_forest(bytes, i2) is
                        Err(_) -> Err({})
                        Ok((variations, i3)) ->
                            Ok((link_sequence(nodes, variations), i3))

expect_byte : List U8, U64, U8 -> Result U64 ParseErr
expect_byte = |bytes, i, b|
    when List.get(bytes, i) is
        Ok(c) if c == b -> Ok(i + 1)
        _ -> Err({})

## After "(", read one or more ";"+properties until "(" or ")".

parse_sequence_nodes : List U8, U64 -> Result (List GameTree, U64) ParseErr
parse_sequence_nodes = |bytes, i_start|
    when expect_byte(bytes, i_start, ';') is
        Err(_) -> Err({})
        Ok(i0) ->
            when parse_properties(bytes, i0) is
                Err(_) -> Err({})
                Ok((props0, i1)) ->
                    node0 = GameNode({ properties: props0, children: [] })
                    walk_sequence(bytes, i1, [node0])

walk_sequence : List U8, U64, List GameTree -> Result (List GameTree, U64) ParseErr
walk_sequence = |bytes, i, nodes_so_far|
    when List.get(bytes, i) is
        Ok(';') ->
            when parse_properties(bytes, i + 1) is
                Err(_) -> Err({})
                Ok((props, j)) ->
                    n = GameNode({ properties: props, children: [] })
                    walk_sequence(bytes, j, List.append(nodes_so_far, n))

        _ ->
            Ok((nodes_so_far, i))

## Variations then closing ")".

parse_variation_forest : List U8, U64 -> Result (List GameTree, U64) ParseErr
parse_variation_forest = |bytes, i_start|
    walk_vars(bytes, i_start, [])

walk_vars : List U8, U64, List GameTree -> Result (List GameTree, U64) ParseErr
walk_vars = |bytes, i, acc|
    when List.get(bytes, i) is
        Ok('(') ->
            when parse_game_tree(bytes, i) is
                Err(_) -> Err({})
                Ok((sub, j)) ->
                    walk_vars(bytes, j, List.append(acc, sub))

        Ok(')') ->
            Ok((acc, i + 1))

        _ ->
            Err({})

link_sequence : List GameTree, List GameTree -> GameTree
link_sequence = |nodes, variations|
    k = List.len(nodes)
    if k == 0 then
        crash("sgf: empty sequence")
    else
        when List.get(nodes, k - 1) is
            Err(_) ->
                crash("sgf: empty sequence")

            Ok(last_raw) ->
                tail = set_children(last_raw, variations)
                pref_rev =
                    nodes
                    |> List.take_first(k - 1)
                    |> List.reverse
                List.walk(
                    pref_rev,
                    tail,
                    |child_so_far, node| set_children(node, [child_so_far]),
                )

set_children : GameTree, List GameTree -> GameTree
set_children = |t, kids|
    when t is
        GameNode(r) -> GameNode({ r & children: kids })
        Empty -> crash("sgf: unexpected Empty")

## --- Properties ---------------------------------------------------------------

parse_properties : List U8, U64 -> Result (NodeProperties, U64) ParseErr
parse_properties = |bytes, i_start|
    walk_props(bytes, i_start, Dict.empty({}))

walk_props : List U8, U64, NodeProperties -> Result (NodeProperties, U64) ParseErr
walk_props = |bytes, i, d0|
    when List.get(bytes, i) is
        Ok(';') | Ok('(') | Ok(')') ->
            Ok((d0, i))

        Ok(b) if is_upper(b) ->
            when parse_key(bytes, i) is
                Err(_) -> Err({})
                Ok((key, j)) ->
                    when parse_all_values_for_key(bytes, j) is
                        Err(_) -> Err({})
                        Ok((vals, k)) ->
                            d1 = merge_prop(d0, key, vals)
                            walk_props(bytes, k, d1)

        _ ->
            Err({})

## Single `List.sublist` for the key bytes avoids `drop_first` + `take_first`.
parse_key : List U8, U64 -> Result (Str, U64) ParseErr
parse_key = |bytes, i_start|
    j = walk_upper(bytes, i_start)
    if j == i_start then
        Err({})
    else
        slice = List.sublist(bytes, { start: i_start, len: j - i_start })
        when Str.from_utf8(slice) is
            Ok(s) -> Ok((s, j))
            Err(_) -> Err({})

walk_upper : List U8, U64 -> U64
walk_upper = |bytes, i|
    if i >= List.len(bytes) then
        i
    else
        when List.get(bytes, i) is
            Ok(b) if is_upper(b) ->
                walk_upper(bytes, i + 1)

            _ ->
                i

is_upper : U8 -> Bool
is_upper = |b|
    b >= 'A' && b <= 'Z'

## One or more "[...]" chunks for the same key (e.g. AB[a][b][c]).

parse_all_values_for_key : List U8, U64 -> Result (List Str, U64) ParseErr
parse_all_values_for_key = |bytes, i|
    when List.get(bytes, i) is
        Ok('[') ->
            gather_more(bytes, i, [])

        _ ->
            Err({})

gather_more : List U8, U64, List Str -> Result (List Str, U64) ParseErr
gather_more = |bytes, i, acc|
    when List.get(bytes, i) is
        Ok('[') ->
            when decode_bracket_value(bytes, i) is
                Err(_) -> Err({})
                Ok((val, j)) ->
                    gather_more(bytes, j, List.append(acc, val))

        _ ->
            Ok((acc, i))

merge_prop : NodeProperties, Str, List Str -> NodeProperties
merge_prop = |d, key, vals|
    when Dict.get(d, key) is
        Ok(prev) ->
            Dict.insert(d, key, List.concat(prev, vals))

        Err(_) ->
            Dict.insert(d, key, vals)

## i points at '['; returns decoded Text value and index after closing ']'.

decode_bracket_value : List U8, U64 -> Result (Str, U64) ParseErr
decode_bracket_value = |bytes, i|
    when expect_byte(bytes, i, '[') is
        Err(_) -> Err({})
        Ok(i_body) ->
            when decode_text_loop(bytes, i_body, []) is
                Err(_) -> Err({})
                Ok((out, j)) ->
                    when expect_byte(bytes, j, ']') is
                        Err(_) -> Err({})
                        Ok(j_after) ->
                            when Str.from_utf8(out) is
                                Ok(s) -> Ok((s, j_after))
                                Err(_) -> Err({})

decode_text_loop : List U8, U64, List U8 -> Result (List U8, U64) ParseErr
decode_text_loop = |bytes, i, out|
    when List.get(bytes, i) is
        Ok(']') ->
            Ok((out, i))

        Ok('\\') ->
            when List.get(bytes, i + 1) is
                Err(_) ->
                    Err({})

                Ok(nxt) ->
                    if nxt == '\n' then
                        decode_text_loop(bytes, i + 2, out)
                    else if is_ws_not_newline(nxt) then
                        decode_text_loop(bytes, i + 2, List.append(out, ' '))
                    else
                        decode_text_loop(bytes, i + 2, List.append(out, nxt))

        Ok(b) ->
            if b == '\n' then
                decode_text_loop(bytes, i + 1, List.append(out, b))
            else if is_ws_not_newline(b) then
                decode_text_loop(bytes, i + 1, List.append(out, ' '))
            else
                decode_text_loop(bytes, i + 1, List.append(out, b))

        Err(_) ->
            Err({})

is_ws_not_newline : U8 -> Bool
is_ws_not_newline = |b|
    b == ' ' || b == '\t'
                                   