module [find_chain]

Domino : (U8, U8)

ChainError : [InvalidChain]

find_chain : List Domino -> Result (List Domino) ChainError
find_chain = |dominoes|
    if List.is_empty(dominoes) then
        Ok([])
    else
        when precheck(dominoes) is
            Err(e) -> Err(e)
            Ok({}) ->
                search(dominoes, [])

precheck : List Domino -> Result {} ChainError
precheck = |dominoes|
    degrees =
        List.walk(
            dominoes,
            Dict.empty({}),
            |acc, (a, b)| bump(bump(acc, a), b),
        )

    if !(degrees_all_even(degrees)) then
        Err(InvalidChain)
    else if !(graph_connected(dominoes, degrees)) then
        Err(InvalidChain)
    else
        Ok({})

bump : Dict U8 U64, U8 -> Dict U8 U64
bump = |dict, k|
    prev = Dict.get(dict, k) |> Result.with_default(0)
    Dict.insert(dict, k, prev + 1)

degrees_all_even : Dict U8 U64 -> Bool
degrees_all_even = |degrees|
    Dict.walk(degrees, Bool.true, |ok, _, count| ok && Num.bitwise_and(count, 1) == 0)

graph_connected : List Domino, Dict U8 U64 -> Bool
graph_connected = |dominoes, degrees|
    when Dict.keys(degrees) is
        [] -> Bool.true
        [start, ..] ->
            visited = dfs_component(start, dominoes, Set.empty({}))
            Dict.walk(degrees, Bool.true, |ok, v, _| ok && Set.contains(visited, v))

dfs_component : U8, List Domino, Set U8 -> Set U8
dfs_component = |u, edges, visited|
    if Set.contains(visited, u) then
        visited
    else
        nextVisited = Set.insert(visited, u)
        neighbors = neighbors_through_edges(u, edges)
        List.walk(neighbors, nextVisited, |acc, v| dfs_component(v, edges, acc))

neighbors_through_edges : U8, List Domino -> List U8
neighbors_through_edges = |u, edges|
    List.walk_backwards(
        edges,
        [],
        |acc, e|
            a = e.0
            b = e.1
            if u == a then
                List.append(acc, b)
            else if u == b then
                List.append(acc, a)
            else
                acc,
    )

remove_at : U64, List Domino -> List Domino
remove_at = |i, list|
    List.walk_with_index(list, [], |acc, x, j|
        if j == i then acc else List.append(acc, x),
    )

chain_closed : List Domino -> Bool
chain_closed = |rev|
    when List.last(rev) is
        Err(_) -> Bool.false
        Ok((firstTileL, _)) ->
            when List.first(rev) is
                Err(_) -> Bool.false
                Ok((_, lastTileR)) -> firstTileL == lastTileR

search : List Domino, List Domino -> Result (List Domino) ChainError
search = |remaining, rev|
    when remaining is
        [] ->
            if chain_closed(rev) then
                Ok(List.reverse(rev))
            else
                Err(InvalidChain)
        _ ->
            when rev is
                [] ->
                    try_each_start(remaining, 0)
                _ ->
                    when List.first(rev) is
                        Err(_) -> crash("unreachable")
                        Ok(tile) ->
                            try_extend(tile.1, remaining, rev, 0)

try_each_start : List Domino, U64 -> Result (List Domino) ChainError
try_each_start = |remaining, i|
    if i >= List.len(remaining) then
        Err(InvalidChain)
    else
        when List.get(remaining, i) is
            Err(_) -> Err(InvalidChain)
            Ok(domino) ->
                rest = remove_at(i, remaining)
                (a, b) = domino
                trial1 = search(rest, [(a, b)])
                when trial1 is
                    Ok(chain) -> Ok(chain)
                    Err(_) ->
                        if a == b then
                            try_each_start(remaining, i + 1)
                        else
                            when search(rest, [(b, a)]) is
                                Ok(chain) -> Ok(chain)
                                Err(_) -> try_each_start(remaining, i + 1)

try_extend : U8, List Domino, List Domino, U64 -> Result (List Domino) ChainError
try_extend = |needed, remaining, rev, i|
    if i >= List.len(remaining) then
        Err(InvalidChain)
    else
        when List.get(remaining, i) is
            Err(_) -> Err(InvalidChain)
            Ok(domino) ->
                (p, q) = domino
                candidate =
                    if p == needed then
                        Ok((p, q))
                    else if q == needed then
                        Ok((q, p))
                    else
                        Err({})

                when candidate is
                    Err(_) -> try_extend(needed, remaining, rev, i + 1)
                    Ok(oriented) ->
                        rest = remove_at(i, remaining)
                        when search(rest, List.prepend(rev, oriented)) is
                            Ok(chain) -> Ok(chain)
                            Err(_) -> try_extend(needed, remaining, rev, i + 1)
    